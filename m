Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbULNH3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbULNH3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULNH3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:29:14 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:54926 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261444AbULNH2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:28:44 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Tue, 14 Dec 2004 08:27:52 +0100
MIME-Version: 1.0
Subject: Re: [2.6 patch] kernel/time.c: possible cleanups
Cc: lkml <linux-kernel@vger.kernel.org>, ulrich.windl@rz.uni-regensburg.de
Message-ID: <41BEA40A.6886.544717D@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1102975027.1281.433.camel@cog.beaverton.ibm.com>
References: <20041212200600.GS22324@stusta.de>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.88.0+V=3.88+U=2.07.079+R=06 December 2004+T=97758@20041214.072827Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Dec 2004 at 13:57, john stultz wrote:

> On Sun, 2004-12-12 at 12:06, Adrian Bunk wrote:
> > The patch below contains some possible cleanups.
> > 
> > I don't claim it's correct, but since all these variables are never 
> > changed it doesn't make a difference.
> > 
> > --- linux-2.6.10-rc2-mm4-full/include/linux/timex.h.old	2004-12-12 03:27:38.000000000 +0100
> > +++ linux-2.6.10-rc2-mm4-full/include/linux/timex.h	2004-12-12 03:28:09.000000000 +0100
> > @@ -249,19 +249,11 @@
> >  extern long time_next_adjust;	/* Value for time_adjust at next tick */
> >  
> >  /* interface variables pps->timer interrupt */
> > -extern long pps_offset;		/* pps time offset (us) */
> >  extern long pps_jitter;		/* time dispersion (jitter) (us) */
> >  extern long pps_freq;		/* frequency offset (scaled ppm) */
> >  extern long pps_stabil;		/* frequency dispersion (scaled ppm) */
> >  extern long pps_valid;		/* pps signal watchdog counter */
> >  
> > -/* interface variables pps->adjtimex */
> > -extern int pps_shift;		/* interval duration (s) (shift) */
> > -extern long pps_jitcnt;		/* jitter limit exceeded */
> > -extern long pps_calcnt;		/* calibration intervals */
> > -extern long pps_errcnt;		/* calibration errors */
> > -extern long pps_stbcnt;		/* stability limit exceeded */
> > -
> 
> There's an out of tree PPS patch that used those values, but since its
> out of tree it could just pick up the reversed change. Really, I'm not
> sure if anyone is using it. 
> 
> Ulrich? Do you have any comments?

AFAIK, adjtimex() [ntp_gettime()] is expected is expected to return those. As long 
as all those are simply zero, you might optimize that case. However once you want 
PPS processing you'll have to add them back. However there's little use in:

1) Declaring variables as extern if you don't use them

2) Do external declarations out side an include file [might introduce conflicting 
external declaration]

Regards,
Ulrich

