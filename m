Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVA3XQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVA3XQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVA3XQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:16:41 -0500
Received: from gprs214-48.eurotel.cz ([160.218.214.48]:2690 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261829AbVA3XQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:16:34 -0500
Date: Mon, 31 Jan 2005 00:16:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050130231617.GA2781@elf.ucw.cz>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501272248380.6118@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In short - raw mode in 2.6 is badly broken.
> 
> I think not just that. The whole keyboard input layer needs some serious 
> review. Just the complete lack of any locking is frightening, I'd really 
> like to know how the input layer could become the standard. I tried to 
> find a few times to find any discussion about the input layer design, but 
> I couldn't find anything.

Actually, at one point we went over inputs with vojtech and tried to
fix the locking. We tried adding spinlocks, but it got really ugly
really quickly. Then we figured out that set_bit() and friends should
be enough to do spinlock-equivalent without getting that ugly.

We did not have enough energy to solve plug/unplug races at that
point; but other races should have been fixed. It is possible that we
overlooked something and doing set_bit() instead of spinlocks is
broken. If it is so, please tell us. 

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
