Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRKMSwC>; Tue, 13 Nov 2001 13:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277528AbRKMSvw>; Tue, 13 Nov 2001 13:51:52 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:65032 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S278177AbRKMSvg>;
	Tue, 13 Nov 2001 13:51:36 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111131851.fADIpTN20263@oboe.it.uc3m.es>
Subject: blocks or KB? (was: .. current meaning of blk_size array)
In-Reply-To: <200111131508.fADF8Yi09728@oboe.it.uc3m.es> from "Peter T. Breuer"
 at "Nov 13, 2001 04:08:34 pm"
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 13 Nov 2001 19:51:29 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me put it more plainly.  Martin Daleki + rumour assures me that the
blk_size array nowadays measure in blocks not KB, yet to me it seems that
it doesn't.  Look at this code from ll_rw_blk.c in 2.4.13:

 unsigned long maxsector = (blk_size[major][MINOR(bh->b_rdev)] << 1) + 1;

and this comment:

 * blk_size contains the size of all block-devices in units of 1024
 * byte sectors:

so blk_size measures in KB.  Where do I see it wrong? Is everybody
talking about 2.4.14 and 2.4.15? No .. it's just the same in 2.4.14:

 if (blk_size[major])
     minorsize = blk_size[major][MINOR(bh->b_rdev)];
     if (minorsize) {
        unsigned long maxsector = (minorsize << 1) + 1;

KB! Or is it the case that sectors don't mean 512B?


Peter
