Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSFKGbm>; Tue, 11 Jun 2002 02:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSFKGbi>; Tue, 11 Jun 2002 02:31:38 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:27321 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316853AbSFKGaM>; Tue, 11 Jun 2002 02:30:12 -0400
Subject: Re: What dose 'general protection fault: 0000' mean?
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Wang Hui <whui@mail.ustc.edu.cn>
Cc: ganda utama <gndutm@netscape.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.31L2A.0206111326530.6179-100000@mail>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Jun 2002 09:27:50 +0300
Message-Id: <1023776870.24401.10.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 08:36, Wang Hui wrote:


> > >Code: 8b 02 8b 55 08 89 02 8b 55 0c 8b 42 04 8b 55 08 89 42 04 8b
> > ><0> Kernel panic: Aiee, killing interrupt handler!
> > >In interrupt handler - not syncing
> > >
> > >==================================================
> > >
> > >I am a newbie to linux kernel hacking.  I dont know how to find out
> > >where is the fault code.  :(  Could anyone give me some hints???

> > it seems that you remove the  process that handles this
> > interupt (perhaps by using kfree). or remove the module,
> > while the kernel still think that the handler is still there...

In the /scripts directory of the Linux tree there is a small utility
that can help you grok these oopses. It is called 'ksymoops'.

> To realize the function 1, I use this tricks: I modified all the kernel's
> active network device's dev->hard_start_xmit function pointer to be my own
> function named as 'my_output_handler', and backuped the original
> 'dev->hard_start_xmit' funtion pointer witch will be called inside
> 'my_output_handler' as to send out the modified data.

Suggestion: don't change kernel primitives like this. Instead write your
code as a Netfilter/iptables module. IMHO it's more of the Right
Thing(tm) and will save you a bunch of headaches...

> ethernet device which is a realtek 8139 network card, I got kernel panic.
> I dont know what to do with it?  I guess this panic is due to something
> difference between loopback network device and the real network device
> drivers. But I dont know exactly what is wrong, or say, that what should I
> do to avoid this panic?  Any rules to write safe code here?

Only 1 rule really - what ever happens, under ANY circumstances, never
ever go chasing after the ship's cat. Remember: "In Kernel space, no one
can hear you scream." :-)

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com
"Hail Eris! All Hail Discordia!"

