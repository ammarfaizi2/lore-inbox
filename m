Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTJZHjV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 02:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJZHjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 02:39:21 -0500
Received: from smtp3.att.ne.jp ([165.76.15.139]:27059 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262898AbTJZHjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 02:39:16 -0500
Message-ID: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
Date: Sun, 26 Oct 2003 16:37:10 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It gets worse.  First, to recap previous results:

1.  The drive reported a permanent error on read, refused to reallocate the
bad sector, and Linux logged the error but refused to remove the block from
the Reiser file system.  (Different people have different opinions about
whether various parts of this behavior are acceptable, but anyway this was
one of the observed results.)

2.  The drive reported a permanent error on write, refused to reallocate the
bad sector, and Linux logged the error but refused to remove the block from
the Reiser file system.  (I'm not sure if different people have different
opinions about whether various parts of this behavior are acceptable.  This
was a write, good data were known at the time, but subsequently good data
would never be retrievable from the file.)

3.  The drive reported a permanent read error during a S.M.A.R.T. long
self-test and refused to reallocate the bad sector.  (I think different
people have different opinions about the acceptability of this too.)

Well, here's news.

4.  When writing ZEROES to the bad sector, the drive reports SUCCESS.
But it lies.  Subsequent attempts to read still fail.  Subsequent writing of
zeroes appears to succeed again.  Subsequent attempts to read still fail.

I swear, I want that block out of the file system.  Even if the writing of
zeroes really succeeded, I would not be satisfied with the continued use of
that block.  I really want the drive to reallocate it, but Toshiba's
firmware is unsafe to drive at any speed.  So I really want the file system
to exclude that block.

Some participants in this discussion have said that ext2fs can exclude bad
blocks in a way that ReiserFS doesn't, though ReiserFS probably will in the
future.  But to the best of my understanding, ext2fs can detect and exclude
bad blocks at the time of formatting and at the time of a destructive
read-write test.  I have not seen news from anyone about whether ext2fs will
remove a detected permanent bad block from an existing mounted filesystem at
the time that the error is detected during normal operations.  It is 99%
necessary to do so (leaving 1% for audio visual applications where it's more
important to play a movie erroneously at proper speed than to attempt
recovery).

By the way, one participant in this thread recommended not buying disk
drives from bargain basement outlets.  OK, yesterday I inquired at Bic
Camera, which might be one of the biggest two retailers of computers and
parts nationwide, but might not be because they don't have many stores
outside of the Tokyo area.  At least they're surely one of the two biggest
in Tokyo.  They said that they warranty Toshiba disk drives for 1 year.  So
if a customer buys a Toshiba disk drive with firmware that was defective on
the day of purchase and defective on the dates of design and manufacture,
but if the customer doesn't detect the defective firmware until 366 days
later, the customer still gets shafted.

I still have to say, we can't fix Toshiba, and we can avoid Toshiba, but
meanwhile we can fix Linux.  Among other manufacturers, only Maxtor has said
that their firmware isn't broken in this way, but Maxtor doesn't make drives
for notebooks.  Just how many manufacturers of disk drives are we going to
avoid, or can we hope that Linux will be made to compensate for their
defects?

Well, in a future weekend, I will try to see if ext2fs really takes action
on permanently bad blocks that are detected during normal operations on a
mounted partition.

