Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbRFENM0>; Tue, 5 Jun 2001 09:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbRFENMQ>; Tue, 5 Jun 2001 09:12:16 -0400
Received: from lotus.ariel.com ([204.249.107.2]:65248 "EHLO cranmail.ariel.com")
	by vger.kernel.org with ESMTP id <S262999AbRFENL7>;
	Tue, 5 Jun 2001 09:11:59 -0400
From: "Arthur Naseef" <arthur.naseef@ariel.com>
To: "Stephen Wille Padnos" <stephenwp@adelphia.net>,
        "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Exporting new functions from kernel 2.2.14
Date: Tue, 5 Jun 2001 09:10:56 -0400
Message-ID: <OIBBKHIAILDFLNOGGFMNOEHLCBAA.arthur.naseef@ariel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B1D00B7.168B52D1@adelphia.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve:

I still have not figured out the magic that creates the .ver files which
would resolve your concern with the symbol versions, but I do know that
you can edit the .ver file yourself (under /usr/src/linux/include/modules/)
and add entries.  This will eliminate the funny versioning, as in:

    grab_timer_interrupt_R__ver_grab_timer_interrupt

You can pick a hash value to use.  For example, you might add the following:

	#define __ver_grab_timer_interrupt	a1b2c3d4
	#define grab_timer_interrupt	_set_ver(grab_timer_interrupt)

As far as the printk() warning, you need to make sure your module code
includes the right header files.  In this case, I believe you need to grab
<linux/kernel.h> after including <linux/module.h>.

I hope this helps.

-art

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Stephen Wille
> Padnos
> Sent: Tuesday, June 05, 2001 11:55 AM
> To: Linux Kernel
> Subject: Exporting new functions from kernel 2.2.14
> 
> 
> Hello, all.
> 
> I am writing a pseudo-realtime control system, based on kernel 2.2.14.
> The only RT-like task needs to hang off the timer IRQ.  I am using
> techniques like those in the book "Linux Kernel Internals", by Beck, et
> al..
> 
> The patches in that book won't apply (they are for 2.1.24 or lower),
> plus I want a somewaht different functionality, which brings me to my
> question:  How can I get (modversions-enabled) functions exported from
> arch/i386/kernel/irq.c?
> 
> I see in /proc/ksyms that there are some functions exported from there
> ({enable,disable}_irq, probe_irq_{on,off}, etc.), and they have correct
> looking versions.
> 
> When I add my new finctions to i386ksyms.c:
> EXPORT_SYMBOL(grab_timer_interrupt);
> EXPORT_SYMBOL(release_timer_interrupt);
> 
> I get names like
> 
> grab_timer_interrupt_R__ver_grab_timer_interrupt
> release_timer_interrupt_R__ver_release_timer_interrupt
> 
> instead of
> local_irq_count_R4d40375f
> 
> Additionally, when I make a dummy module (a la Alessandro Rubini's
> "Hello" module in "Linux Device Drivers"), I get the following warning:
> control.c:31: warning: implicit declaration of function
> `printk_R1b7d4074'
> The module seems to work (it printk's "module loaded" on load and
> "module unloaded" on unload), but I suspect that this is because I am
> printk()-ing unformatted text strings - only one parameter gets sent.
> 
> So, I obviously have missed some basics about:
> a) versioning,
> b) exporting symbols, and
> c) modules.
> 
> could soemone please enlighten me, or direct me along the path of
> enlightenment :)
> 
> Thanks
> - Steve
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
