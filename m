Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSFKIBH>; Tue, 11 Jun 2002 04:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSFKIBG>; Tue, 11 Jun 2002 04:01:06 -0400
Received: from [61.132.182.1] ([61.132.182.1]:14709 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id <S316909AbSFKIBE>;
	Tue, 11 Jun 2002 04:01:04 -0400
Date: Tue, 11 Jun 2002 15:46:34 +0800 (CST)
From: Wang Hui <whui@mail.ustc.edu.cn>
X-X-Sender: <whui@mail>
To: Gilad Ben-Yossef <gilad@benyossef.com>
cc: ganda utama <gndutm@netscape.net>, <linux-kernel@vger.kernel.org>
Subject: Re: What dose 'general protection fault: 0000' mean?
In-Reply-To: <1023776870.24401.10.camel@gby.benyossef.com>
Message-ID: <Pine.GSO.4.31L2A.0206111533530.27147-100000@mail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Gliad.

As you mentioned in your mail, you suggested me to make a Netfilter module
to realize what I want.  In fact, it is really a good choice.  But as to
my case, I have to modify the outgoing IP packet header.  And after the
modification, the outgoing IP packet's header will become a none-IP
header( as defined in RFC 3095).  So I dont know if this kind of
modified packet could still traverse the netfilter chains?  Will the
kernel drop this 'strange header' packet (for the kernel cannot
understand this kind of none-IP header)?  Or say, where should I put my
modification module in the netfilter chain as to avoid this dropping??

To clearify my problem, I would like to draw a small picture here:

[kernel ipv6 packet output] --> [My Module: modify the IP header to be a
nono-IP header] --> [ put it to the device output queue to sent out]

My current problem is where to put 'my module' in the kernel data flow?
netfilter? or else?

Looking forward to any suggestion.

Best,
Wang Hui

On 11 Jun 2002, Gilad Ben-Yossef wrote:

> On Tue, 2002-06-11 at 08:36, Wang Hui wrote:
>
>
> > > >Code: 8b 02 8b 55 08 89 02 8b 55 0c 8b 42 04 8b 55 08 89 42 04 8b
> > > ><0> Kernel panic: Aiee, killing interrupt handler!
> > > >In interrupt handler - not syncing
> > > >
> > > >==================================================
> > > >
> > > >I am a newbie to linux kernel hacking.  I dont know how to find out
> > > >where is the fault code.  :(  Could anyone give me some hints???
>
> > > it seems that you remove the  process that handles this
> > > interupt (perhaps by using kfree). or remove the module,
> > > while the kernel still think that the handler is still there...
>
> In the /scripts directory of the Linux tree there is a small utility
> that can help you grok these oopses. It is called 'ksymoops'.
>
> > To realize the function 1, I use this tricks: I modified all the kernel's
> > active network device's dev->hard_start_xmit function pointer to be my own
> > function named as 'my_output_handler', and backuped the original
> > 'dev->hard_start_xmit' funtion pointer witch will be called inside
> > 'my_output_handler' as to send out the modified data.
>
> Suggestion: don't change kernel primitives like this. Instead write your
> code as a Netfilter/iptables module. IMHO it's more of the Right
> Thing(tm) and will save you a bunch of headaches...
>
> > ethernet device which is a realtek 8139 network card, I got kernel panic.
> > I dont know what to do with it?  I guess this panic is due to something
> > difference between loopback network device and the real network device
> > drivers. But I dont know exactly what is wrong, or say, that what should I
> > do to avoid this panic?  Any rules to write safe code here?
>
> Only 1 rule really - what ever happens, under ANY circumstances, never
> ever go chasing after the ship's cat. Remember: "In Kernel space, no one
> can hear you scream." :-)
>
> Gilad.
>
> --
> Gilad Ben-Yossef <gilad@benyossef.com>
> http://benyossef.com
> "Hail Eris! All Hail Discordia!"
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

