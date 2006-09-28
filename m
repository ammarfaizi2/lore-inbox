Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWI1XEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWI1XEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWI1XEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:04:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750818AbWI1XEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:04:39 -0400
Date: Fri, 29 Sep 2006 01:04:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Message-ID: <20060928230433.GG26653@elf.ucw.cz>
References: <200609290005.17616.rjw@sisk.pl> <200609290013.39137.rjw@sisk.pl> <20060928154237.d91abb1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928154237.d91abb1f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +			swdev = old_decode_dev(swap_area.dev);
> > +			if (swdev) {
> > +				offset = swap_area.offset;
> > +				data->swap = swap_type_of(swdev, offset);
> > +				if (data->swap < 0)
> > +					error = -ENODEV;
> > +			} else {
> > +				data->swap = -1;
> > +				error = -EINVAL;
> > +			}
> > +		}
> > +		break;
> > +
> >  	default:
> >  		error = -ENOTTY;
> 
> But I wonder if we need to pass the device identified into this ioctl at
> all.  What device is the ioctl() against?  ie: what do `filp' and `inode'
> point at?  If it's /dev/hda1 then everything we need is right there, is it
> not?
> 
> ohshit, it's a miscdevice.  I wonder if it would have defined all this
> stuff to be operations against the blockdev.  Perhaps not.

Defining it against blockdev would be ugly... we'll want to suspend to
two devices at the same time, and we'll want to suspend over network etc.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
