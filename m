Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFJKBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTFJJ7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:59:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64485 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261669AbTFJJ6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:58:32 -0400
Date: Tue, 10 Jun 2003 15:45:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-mpu401
Message-ID: <20030610101503.GI2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610101318.GH2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use copy_to_user to copy mpu_synth_ioctl arg.


 sound/oss/mpu401.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN sound/oss/mpu401.c~cp-user-mpu401 sound/oss/mpu401.c
--- linux-2.5.70-ds/sound/oss/mpu401.c~cp-user-mpu401	2003-06-08 02:59:48.000000000 +0530
+++ linux-2.5.70-ds-dipankar/sound/oss/mpu401.c	2003-06-08 02:59:48.000000000 +0530
@@ -792,7 +792,8 @@ static int mpu_synth_ioctl(int dev,
 	{
 
 		case SNDCTL_SYNTH_INFO:
-			memcpy((&((char *) arg)[0]), (char *) &mpu_synth_info[midi_dev], sizeof(struct synth_info));
+			if(copy_to_user((&((char *) arg)[0]), (char *) &mpu_synth_info[midi_dev], sizeof(struct synth_info)))
+				return -EFAULT;
 			return 0;
 
 		case SNDCTL_SYNTH_MEMAVL:

_
