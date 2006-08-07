Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHGXYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHGXYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWHGXYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:24:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41383 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751197AbWHGXYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:24:34 -0400
Date: Tue, 8 Aug 2006 01:24:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Message-ID: <20060807232415.GE2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <1154849246822-git-send-email-multinymous@gmail.com> <20060807140222.GG4032@ucw.cz> <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> +     /* Parse position data: */
> >> +     pos_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1) * (hdaps_invert?-1:1);
> >> +     pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1) * (hdaps_invert?-1:1);
> >> +
> >> +     /* Parse so-called "variance" data: */
> >> +     var_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS2) * (hdaps_invert?-1:1);
> >> +     var_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS2) * (hdaps_invert?-1:1);
> >
> >Perhaps hdaps_invert should already have 1/-1 values.
> 
> It's also used as a module parameter, which is 0/1 in mainline. I
> don't think this is worth extra code.

Okay, so what about ..

#define CONVERT(x) *(s16*)(data.val+x) * (hdaps_invert?-1:1);

...or better inline function?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
