Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313595AbSDZHzF>; Fri, 26 Apr 2002 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313635AbSDZHzF>; Fri, 26 Apr 2002 03:55:05 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:51980 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S313595AbSDZHzE>; Fri, 26 Apr 2002 03:55:04 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: kernel 2.5.10 problems
Date: 26 Apr 2002 06:54:56 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnachue0.a20.kraxel@bytesex.org>
In-Reply-To: <courier.3CC89816.00006EFA@softhome.net> <20020426022139.N14343@suse.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1019804096 10305 127.0.0.1 (26 Apr 2002 06:54:56 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  On Thu, Apr 25, 2002 at 05:58:14PM -0600, dmacbanay@softhome.net wrote:
>  
>  > 4.  Starting with kernel 2.5.6 (kernels 2.5.5 through 2.5.6-pre3 work)  the 
>  > KDE program krecord closes right after it starts. 
>  
>  Interesting. last few lines of strace output may show up what's going on.
>  Can you do a before/after strace on a working & non-working kernel?

That one likely is a known bug in the ALSA OSS emulation, Takashi
recently fixed it.

  Gerd

===== sound/core/oss/pcm_oss.c 1.4 vs edited =====
--- 1.4/sound/core/oss/pcm_oss.c	Mon Mar 18 16:21:13 2002
+++ edited/sound/core/oss/pcm_oss.c	Wed Apr 17 12:00:55 2002
@@ -557,7 +557,7 @@
 			if (ret < 0)
 				break;
 		}
-		ret = snd_pcm_lib_read(substream, ptr, frames);
+//		ret = snd_pcm_lib_read(substream, ptr, frames);
 		if (in_kernel) {
 			mm_segment_t fs;
 			fs = snd_enter_user();
