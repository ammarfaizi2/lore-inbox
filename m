Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287991AbSAVFLn>; Tue, 22 Jan 2002 00:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAVFLd>; Tue, 22 Jan 2002 00:11:33 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:22010 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287991AbSAVFL0>; Tue, 22 Jan 2002 00:11:26 -0500
Date: Tue, 22 Jan 2002 00:11:25 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch for ymfpci in 2.5.x
Message-ID: <20020122001125.A19661@devserv.devel.redhat.com>
In-Reply-To: <20020111121431.A10147@devserv.devel.redhat.com> <Pine.LNX.4.33.0201111034070.3952-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201111034070.3952-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 11, 2002 at 10:36:30AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 11 Jan 2002 10:36:30 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>

> It would have been even saner to give that bit some sane name, and have
> something like
> 
> 	#define YMFPCI_XXXBIT (__constant_cpu_to_le32(0x40000000))
> 
> instead of creating a totally nonsensical random number.

I think something like this would be better than one more
totally nonsesical random #define:

--- linux-2.5.2/drivers/sound/ymfpci.c	Fri Jan 11 10:34:43 2002
+++ linux-2.5.2-p3/drivers/sound/ymfpci.c	Mon Jan 21 21:06:48 2002
@@ -832,6 +832,13 @@
 	u32 lpfK = ymfpci_calc_lpfK(rate);
 	ymfpci_playback_bank_t *bank;
 	int nbank;
+
+	/*
+	 * The gain is a floating point number. According to the manual,
+	 * bit 31 indicates a sign bit, bit 30 indicates an integer part,
+	 * and bits [29:15] indicate a decimal fraction part. Thus,
+	 * for a gain of 1.0 the constant of 0x40000000 is loaded.
+	 */
 	unsigned le_0x40000000 = cpu_to_le32(0x40000000);
 
 	format = (stereo ? 0x00010000 : 0) | (w_16 ? 0 : 0x80000000);

-- Pete
