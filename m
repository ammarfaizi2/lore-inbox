Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUBJUXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUBJUXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:23:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:25294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266097AbUBJUXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:23:23 -0500
Date: Tue, 10 Feb 2004 12:23:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralf Gerbig <rge-news@quengel.org>
cc: Takashi Iwai <tiwai@suse.de>,
       Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
In-Reply-To: <m3hdxyyar8.fsf-news@hsp-law.de>
Message-ID: <Pine.LNX.4.58.0402101221210.2128@home.osdl.org>
References: <4023BEA8.5060306@vision.ee> <s5hd68o2ia7.wl@alsa2.suse.de>
 <4029143B.30408@vision.ee> <s5hvfmebvr4.wl@alsa2.suse.de> <m3hdxyyar8.fsf-news@hsp-law.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Feb 2004, Ralf Gerbig wrote:
> 
> * On Tue, 10 Feb 2004 20:05:35 +0100, Takashi Iwai <tiwai@suse.de> said:
> 
> > --- linux/sound/pci/intel8x0.c	6 Feb 2004 17:47:49 -0000	1.115
> > +++ linux/sound/pci/intel8x0.c	10 Feb 2004 19:03:43 -0000
> > @@ -807,7 +807,7 @@
> >  		if (status)
> >  			iputdword(chip, chip->int_sta_reg, status);
> >  		spin_unlock(&chip->reg_lock);
> > -		return IRQ_NONE;
> > +		return IRQ_HANDLED(status);
> 
> did not compile, tried 
> 
>                 return IRQ_RETVAL(status);
> 
> instead. Works, but I get 150,000 interrupts/s even without playing any
> sound.

Can you add something like

	static int count = 10;
	if (count) {
		count--;
		printk("sound status = %08x (mask %08x)\n", 
			status, chip->int_sta_mask);
	}

to just before the return?

That should tell what the register contents are, and might be a clue
about what event it thinks is active.

		Linus
