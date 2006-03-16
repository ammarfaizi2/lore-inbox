Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWCTI4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWCTI4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWCTI4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:56:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54972 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932255AbWCTI4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:56:52 -0500
Date: Thu, 16 Mar 2006 22:44:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: does swsusp suck after resume for you?
Message-ID: <20060316214410.GD2674@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603162147.56725.kernel@kolivas.org> <20060316105054.GB9399@atrey.karlin.mff.cuni.cz> <200603170833.27114.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603170833.27114.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 17-03-06 08:33:26, Con Kolivas wrote:
> > > > > The tunable in /proc/sys/vm/swap_prefetch is now bitwise ORed:
> > > > > Thus if you set this value 
> > > > > to 3 it will prefetch aggressively and then drop back to the default
> > > > > of 1. This makes it easy to simply set the aggressive flag once and
> > > > > forget about it. I've booted and tested this feature and it's working
> > > > > nicely. Where exactly you'd set this in your resume scripts I'm not
> > > > > sure. A rolled up patch against 2.6.16-rc6-mm1 is here for
> > > > > simplicity:
> 
> correct url:
> http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_test.patch

I'm sorry, I'm leaving for mountains tommorow, so it will take me a
while to test it.

> > > 2 means aggressively prefetch as much as possible and then disable swap
> > > prefetching from that point on. Too confusing?
> >
> > Ahha... oops, yes, clever; no, I guess keep it.
> 
> Ok the patch works fine for me and the feature is worthwhile in absolute terms 
> as well as for improving resume. 

Good.

> Pavel, while we're talking about improving behaviour after resume I had a look 
> at the mechanism used to free up ram before suspending and I can see scope 
> for some changes in the vm code that would improve the behaviour after 
> resuming. Is the mechanism used to free up ram going to continue being used 
> with uswsusp? If so, I'd like to have a go at improving the free up
> ram vm 

Yes, it is.

> code to make it behave nicer after resume. I have some ideas about how best 
> to free up ram differently from normal reclaim which would improve behaviour 
> post resume.

One possible improvement would be to never ever return 0 if there can
still be more memory freed. Rafael did some ugly workaround, but we
do not even understand the problem.
								Pavel
-- 
82:        return SampleTable;
