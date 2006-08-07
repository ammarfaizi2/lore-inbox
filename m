Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWHGXWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWHGXWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWHGXWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:22:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39079 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751190AbWHGXWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:22:31 -0400
Date: Tue, 8 Aug 2006 01:22:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/12] hdaps: Use thinkpad_ec instead of direct port access
Message-ID: <20060807232212.GD2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492333054-git-send-email-multinymous@gmail.com> <20060807135551.GF4032@ucw.cz> <41840b750608070840o76cc605bj76602d83825af4d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608070840o76cc605bj76602d83825af4d3@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> +#define ABORT_INIT(msg) { printk(KERN_ERR "hdaps init: %s\n", msg); 
> >goto bad; }
> >
> >No.. macro with embedded goto is *evil*.
> 
> OK. But it does makes the init function much longer and harder to
>read.

If you keep { printk(); goto } on one line... it is technically
codingstyle violation but it is certainly better than evil macro.

> >> +     if (data.val[0xF]!=0x00)
> >> +             ABORT_INIT("check1");
> >
> >!=0 in if is evil...
> 
> Sure, when zero is special, like for booleans or integer or pointers.
> But this is a status byte value, I don't want to mistreat it just
> because all its bits are unset. Otherwise, imagine the non-systematic
> mess this will become:

Okay, I'd only do it in "single" cases. I guess you have point about
unsigned char not being boolean.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
