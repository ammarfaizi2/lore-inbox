Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTFJJyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFJJx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:53:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21491 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261411AbTFJJw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:52:28 -0400
Date: Tue, 10 Jun 2003 15:39:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-awe
Message-ID: <20030610100905.GD2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610100746.GC2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix copy/user in awe_wave.


 sound/oss/awe_wave.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN sound/oss/awe_wave.c~cp-user-awe sound/oss/awe_wave.c
--- linux-2.5.70-ds/sound/oss/awe_wave.c~cp-user-awe	2003-06-08 20:49:13.000000000 +0530
+++ linux-2.5.70-ds-dipankar/sound/oss/awe_wave.c	2003-06-08 20:49:13.000000000 +0530
@@ -2046,9 +2046,9 @@ awe_ioctl(int dev, unsigned int cmd, cad
 			awe_info.nr_voices = awe_max_voices;
 		else
 			awe_info.nr_voices = AWE_MAX_CHANNELS;
-		memcpy((char*)arg, &awe_info, sizeof(awe_info));
+		if(copy_to_user(arg, &awe_info, sizeof(awe_info)))
+			return -EFAULT;
 		return 0;
-		break;
 
 	case SNDCTL_SEQ_RESETSAMPLES:
 		awe_reset(dev);

_
