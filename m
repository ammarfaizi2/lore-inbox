Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSFKFlC>; Tue, 11 Jun 2002 01:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSFKFlC>; Tue, 11 Jun 2002 01:41:02 -0400
Received: from [61.132.182.1] ([61.132.182.1]:14396 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id <S316832AbSFKFlB>;
	Tue, 11 Jun 2002 01:41:01 -0400
Date: Tue, 11 Jun 2002 13:36:25 +0800 (CST)
From: Wang Hui <whui@mail.ustc.edu.cn>
X-X-Sender: <whui@mail>
To: ganda utama <gndutm@netscape.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: What dose 'general protection fault: 0000' mean?
In-Reply-To: <3D057CDD.3070307@netscape.net>
Message-ID: <Pine.GSO.4.31L2A.0206111326530.6179-100000@mail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Ganda.

In fact, I am implementing RFC3095 to linux kernel.  I want to make it
a kernel module.

The basic function of this module could be described as the following 2
parts:

1. The module will modify the outgoing packet(ipv6 or IPv6 ) and compress
   the IP header.(we will do flow recognition and update some context
   for further compress stuff here.)

2. The other part of this module will de-compress  this compressed
   IP header. And then passes the de-compressed packet up to IP(v4 or v6)
   module to do the normal recieving processes.


To realize the function 1, I use this tricks: I modified all the kernel's
active network device's dev->hard_start_xmit function pointer to be my own
function named as 'my_output_handler', and backuped the original
'dev->hard_start_xmit' funtion pointer witch will be called inside
'my_output_handler' as to send out the modified data.

As to realize function 2, I would like to omitted here.  For it has
nothing to do with this current panic.

All the above funtions are implemented and I tested the codes via my
loopback network device(lo) using the address of '::1' or '127.0.0.1'.
The codes run OK in the lo device.  But when I put my codes to the real
ethernet device which is a realtek 8139 network card, I got kernel panic.
I dont know what to do with it?  I guess this panic is due to something
difference between loopback network device and the real network device
drivers. But I dont know exactly what is wrong, or say, that what should I
do to avoid this panic?  Any rules to write safe code here?

Many thanks again.

Best regards,
Wang.





On Tue, 11 Jun 2002, ganda utama wrote:

> it seems that you remove the  process that handles this
> interupt (perhaps by using kfree). or remove the module,
> while the kernel still think that the handler is still there...
>
> ganz
>
>
> whui@mail.ustc.edu.cn wrote:
>
> >Hi, all,
> >
> >I am coding a linux kernel module, but when I run my testing code I got
> >a kernel panic.  And the panic screen said:
> >
> >general protection fault:0000
> >CPU: 0
> >EIP: 0010:[<d289a213>]       Tainted: P
> >EFLAGS: 00010297
> >............
> >............
> >Code: 8b 02 8b 55 08 89 02 8b 55 0c 8b 42 04 8b 55 08 89 42 04 8b
> ><0> Kernel panic: Aiee, killing interrupt handler!
> >In interrupt handler - not syncing
> >
> >==================================================
> >
> >I am a newbie to linux kernel hacking.  I dont know how to find out
> >where is the fault code.  :(  Could anyone give me some hints???
> >
> >Thanks a lot in advance!!
> >
> >Regards,
> >Wang Hui.
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>


