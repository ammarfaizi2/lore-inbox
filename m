Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWHHJV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWHHJV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWHHJV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:21:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4737 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750841AbWHHJV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:21:57 -0400
Date: Tue, 8 Aug 2006 11:21:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Message-ID: <20060808092133.GB4245@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <1154849246822-git-send-email-multinymous@gmail.com> <20060807140222.GG4032@ucw.cz> <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com> <20060807232415.GE2759@elf.ucw.cz> <41840b750608080216l58f56030v9c766427f8582f4c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608080216l58f56030v9c766427f8582f4c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Okay, so what about ..
> >
> >#define CONVERT(x) *(s16*)(data.val+x) * (hdaps_invert?-1:1);
> >
> >...or better inline function?
> 
> Actually, some models require fancier transformations. This was
> supposed to be reserved for a future patch, but might as well prepare
> the infrastructure:

Certainly better.

> /* Some models require an axis transformation to the standard reprsentation 
> */
> static void transform_axes(int inx, int iny, int *outx, int *outy) {
> 	*outx = inx * (hdaps_invert?-1:1);
> 	*outy = iny * (hdaps_invert?-1:1);
> }
> ...
> 	/* Parse position data: */
> 	transform_axes(*(s16*)(data.val+EC_ACCEL_IDX_XPOS1),
> 	               *(s16*)(data.val+EC_ACCEL_IDX_YPOS1), &pos_x, &pos_y);

You could also do

void transform_axes(int *x, int *y)
{
 	*outx = inx * (hdaps_invert?-1:1);
 	*outy = iny * (hdaps_invert?-1:1);
}
...
 	/* Parse position data: */
	x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1);
	y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1);
 	transform_axes(&x, &y);

...which looks even better to me.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
