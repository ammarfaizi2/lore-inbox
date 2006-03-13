Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWCMReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWCMReS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWCMReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:34:18 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:34792 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751531AbWCMReR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:34:17 -0500
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state",
	jackd	(alsa	1.0.10 vs. recent kernels)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Takashi Iwai <tiwai@suse.de>
Cc: nando@ccrma.Stanford.EDU, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, cc@ccrma.Stanford.EDU,
       alsa-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <s5h8xremwpb.wl%tiwai@suse.de>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
	 <1141938488.22708.28.camel@cmn3.stanford.edu>
	 <4410B2D7.4090806@yahoo.com.au>
	 <1141958866.22708.69.camel@cmn3.stanford.edu>
	 <441109BC.9070705@yahoo.com.au>
	 <1142016627.6124.33.camel@cmn3.stanford.edu>
	 <44121351.2050703@yahoo.com.au>
	 <1142210977.7471.27.camel@cmn3.stanford.edu>
	 <4414DBFE.1050400@yahoo.com.au>
	 <1142220385.7471.46.camel@cmn3.stanford.edu>
	 <1142220716.25358.273.camel@mindpipe>
	 <1142221144.7471.51.camel@cmn3.stanford.edu>
	 <1142222022.25358.277.camel@mindpipe>  <s5h8xremwpb.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 09:33:50 -0800
Message-Id: <1142271230.13467.13.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 12:05 +0100, Takashi Iwai wrote:
> At Sun, 12 Mar 2006 22:53:41 -0500,
> Lee Revell wrote:
> > On Sun, 2006-03-12 at 19:39 -0800, Fernando Lopez-Lezcano wrote:
> > > On Sun, 2006-03-12 at 22:31 -0500, Lee Revell wrote:
> > >  
> > > > Older ALSA with a newer kernel has never been supported.  Why would you
> > > > want to replace the ALSA in the kernel with an old version?
> > > 
> > > Because it is not an older version?
> > > "cat /proc/asound/version" for the 2.6.15 in kernel tree prints this:
> > >   Advanced Linux Sound Architecture Driver Version 1.0.10rc3
> > > That should be older than 1.0.10 final.
> > 
> > Ah, sorry.  Then you're right, this patch must have slipped through the
> > cracks.
> 
> Well, ALSA 1.0.10-final was already released in last November,
> i.e. before 2.6.15.  When 2.6.15 was released, we had ALSA 1.0.11rc2.

I understand. Still, 2.6.15 has 1.0.10rc3 and current alsa "stable" does
not work out of the box with it (at least for some of the cards and in
my tests - hmmm, maybe this only happens when running with the -rt
patches?). 

There's one additional tiny patch needed in alsa 1.0.10 if you want
snd-rtctimer to be detected by configure and subsequently built under
2.6.15+:

========
alsa-driver-1.0.10/configure~	2005-11-16 09:41:17.000000000 -0500
+++ alsa-driver-1.0.10/configure	2006-03-06 20:48:03.152744160 -0500
@@ -8260,7 +8260,7 @@
 echo "$as_me:$LINENO: checking for RTC callback support in kernel" >&5
 echo $ECHO_N "checking for RTC callback support in kernel... $ECHO_C"
>&6
 rtcsup=""
-if test "$kversion.$kpatchlevel" = "2.6" -a "$kpatchlevel" -ge 15; then
+if test "$kversion.$kpatchlevel" = "2.6" -a "$ksublevel" -ge 15; then
 ac_save_CFLAGS="$CFLAGS"
 ac_save_CC=$CC
 CFLAGS="$KERNEL_CHECK_CFLAGS"
========

-- Fernando


