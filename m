Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWDRL4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWDRL4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWDRL4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:56:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55487 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932218AbWDRL4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:56:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: rework memory shrinker
Date: Tue, 18 Apr 2006 13:55:50 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, kernel@kolivas.org
References: <200604181201.53430.rjw@sisk.pl> <20060418031355.7370b1e6.akpm@osdl.org> <200604181347.55259.rjw@sisk.pl>
In-Reply-To: <200604181347.55259.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181355.51318.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 13:47, Rafael J. Wysocki wrote:
> On Tuesday 18 April 2006 12:13, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Rework the swsusp's memory shrinker in the following way:
> > 
> > And what was the observed effect of all this?
> 
> Measurable effects:
> 1) It tends to free only as much memory as required, eg. if the image_size
> is set to 450 MB, the actual image sizes are almost always well above
> 400 MB and they tended to be below that number without the patch
> (~5-10% of a difference, but still :-)).
> 2) If image_size = 0, it frees everything that can be freed without any
> workarounds (we had to add the additional loop checking for
> ret >= nr_pages with the additional blk_congestion_wait() to the
> "original" shrinker to achieve this).
> 
> A non-measurable effect is that with the patch applied  the system seems to
> be more responsive after resume, but of course this may be an illusion.
> 
> > 
> > > +		/* Force reclaiming mapped pages in the passes #3 and #4 */
> > > +		if (pass > 2) {
> > > +			sc.may_swap = 1;
> > > +			vm_swappiness = 100;
> > > +		}
> > 
> > That's a bit klunky.   Maybe we should move swappiness into scan_control.
> 
> Alternatively we can temporarily set zone->prev_priority to 100 in
> shrink_all_zones() if pass > 2?

s/100/0/

Sorry.
