Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030579AbWBNOJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbWBNOJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWBNOJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:09:49 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:46467 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1030579AbWBNOJs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:09:48 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Tue, 14 Feb 2006 15:09:39 +0100
MIME-Version: 1.0
Subject: Re: time patches by Roman Zippel
Cc: linux-kernel@vger.kernel.org
Message-ID: <43F1F2B4.7205.6BBE301@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0602141400140.9696@scrub.home>
References: <43F195DF.23967.551458C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118674@20060214.140926Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Feb 2006 at 14:21, Roman Zippel wrote:

> Hi,
> 
> On Tue, 14 Feb 2006, Ulrich Windl wrote:
> 
> > 15_time_offset and 18_time_freq change some well-known constants (like MAXPHASE)
> > by three orders of magnitude.

--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:12:00.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:08.000000000 +0100
@@ -95,11 +95,11 @@
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
 #define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
 
-#define MAXPHASE 512000L        /* max phase error (us) */
+#define MAXPHASE 500000000L	/* max phase error (ns) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
 #define MINSEC 16L              /* min interval between updates (s) */
 #define MAXSEC 1200L            /* max interval between updates (s) */
-#define	NTP_PHASE_LIMIT	(MAXPHASE << 5)	/* beyond max. dispersion */
+#define NTP_PHASE_LIMIT	((MAXPHASE / 1000) << 5) /* beyond max. dispersion */


> > 
> > the new adjtime() (16_time_adjust, 12_time_adj) changes the semantics: Since about
> > Linux 0.99, adjtime() had the adjtime_is_accurate property, i.e. on the long term
> > it behaved like an addition.
> 
> I disagree, could you please explain how you come to this conclusion?

+			tick_nsec_curr += time_adjust * 1000 / HZ;

Assuming 1024Hz interrupt frequency:
(1탎 * 1000) / 1024 == 0ns; 0 * 1024 == 0탎, not 1탎
(2탎 * 1000) / 1024 == 1ns; 1 * 1024 == 1.024탎, not 2탎

> The patches don't change the behaviour beyond that they increase 
> resolution and precision. Only the final patch changes the ntp code to 
> match the behaviour of ntp reference code without including all its mess.

It's quite hard to tell: The code is very different what I've ever seen.

Regards,
Ulrich

