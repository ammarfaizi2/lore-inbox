Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTJKJBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTJKJBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:01:36 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:44708 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S263264AbTJKJBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:01:32 -0400
Message-ID: <227d01c38fd6$2e4764f0$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Sat, 11 Oct 2003 18:00:31 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first question is why the bad disk sectors are numbered strangely, and
second is what does Linux do with them after detecting them?

I repartitioned and reformatted two Reiser partitions before installing SuSE
8.2 and then compiling kernels 2.6.0-test5, test6, and test7.  My feeling is
that the following errors "should" have been detected during writes, so the
damage "should" not be too bad.  The correct data "should" get written to
replacement sectors.  But my understanding of modern ATA drives is that the
firmware "should" have detected the errors during writes and "should" have
finished the work without the OS knowing about it.

If the following errors occured during reads then I have some pretty angry
questions about why they didn't get detected during writes, especially when
the writes occured minutes or milliseconds prior to the reads.  (I'll copy
this message to some Toshiba employees.  Maybe the next time they visit,
certain persons should get cat food instead of my wife's cooking  _^o^_
MK4018GAP, about 2 years old.)

Hmm, I guess I also need to ask how to figure out if these occured during
writes or reads.

Meanwhile, it seems really strange to see separate numbers for LBAsect and
sector, and to see that the two numbers are sometimes related but sometimes
apparently unrelated, and to see LBAsect remain constant while sector
changes with each error.  What is really going on here?

Also kernel 2.6.0-test7 no longer says whether hda was on 03:08 or 03:00
when the errors were detected.

Sep 27 16:49:41 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 27 16:49:41 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=852296
Sep 27 16:49:41 diamondpana kernel: end_request: I/O error,
   dev 03:08 (hda), sector 852296
Sep 27 16:49:41 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 27 16:49:41 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=852304
Sep 27 16:49:41 diamondpana kernel: end_request: I/O error,
   dev 03:08 (hda), sector 852304
[comment: no more that day]

Sep 28 15:20:20 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:20 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021784
Sep 28 15:20:20 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021784
Sep 28 15:20:20 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:20 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021786
Sep 28 15:20:20 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021786
[... every even-numbered sector in this range ...]
Sep 28 15:20:21 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:21 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021880
Sep 28 15:20:21 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021880
Sep 28 15:20:21 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:21 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021882
Sep 28 15:20:21 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021882
[comment: after hitting equality, it soon repeated from the middle]
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021832
Sep 28 15:20:26 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021832
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021834
Sep 28 15:20:26 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021834
[... every even-numbered sector in this range ...]
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021880
Sep 28 15:20:26 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021880
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 28 15:20:26 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021882
Sep 28 15:20:26 diamondpana kernel: end_request: I/O error,
   dev 03:00 (hda), sector 19021882
[comment:  after hitting equality again, no more that day]

Sep 29 01:24:09 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 29 01:24:09 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=852296
Sep 29 01:24:09 diamondpana kernel: end_request: I/O error,
   dev 03:08 (hda), sector 852296
Sep 29 01:24:09 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Sep 29 01:24:09 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=852304
Sep 29 01:24:09 diamondpana kernel: end_request: I/O error,
   dev 03:08 (hda), sector 852304
[comment:  same sectors as on Sep 27]

Oct 10 18:29:29 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Oct 10 18:29:29 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021842
Oct 10 18:29:29 diamondpana kernel: end_request: I/O error,
   dev hda, sector 19021842
Oct 10 18:29:29 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Oct 10 18:29:29 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021850
Oct 10 18:29:29 diamondpana kernel: end_request: I/O error,
   dev hda, sector 19021850
[... every 8th sector in this range, congruent to 2 modulo 8 ...]
Oct 10 18:29:30 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Oct 10 18:29:30 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021874
Oct 10 18:29:30 diamondpana kernel: end_request: I/O error,
   dev hda, sector 19021874
Oct 10 18:29:30 diamondpana kernel: hda: dma_intr: status=0x51
   { DriveReady SeekComplete Error }
Oct 10 18:29:30 diamondpana kernel: hda: dma_intr: error=0x40
   { UncorrectableError }, LBAsect=19021882, sector=19021882
Oct 10 18:29:30 diamondpana kernel: end_request: I/O error,
   dev hda, sector 19021882
[comment: some of the same sectors as on Sep 28]

