Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTKBUDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 15:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTKBUDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 15:03:21 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23444 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261796AbTKBUDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 15:03:20 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stef van der Made <svdmade@planet.nl>
Subject: Re: Di-30 non working [bug 967]
Date: Sun, 2 Nov 2003 21:08:23 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3FA41703.1030408@planet.nl> <200311020054.49869.bzolnier@elka.pw.edu.pl> <3FA55E7B.3050706@planet.nl>
In-Reply-To: <3FA55E7B.3050706@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311022108.23415.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 02 of November 2003 20:43, Stef van der Made wrote:
> Dear Bartlomiej,
>
> The problem is now fully solved. I can read from the tape, use mt on the
> tape drive. Your second patch was the final missing bit.
>
> Thanks for your help, I hope that Linus will accept the patch for test10
> so that more people can enjoy the use of this tape drive with Linux.

Great.  I will send patches to Linus soon.
Thanks for testing.

--bartlomiej

Here is second necessary patch (was posted off-list previously).

 drivers/ide/ide-tape.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/ide/ide-tape.c~ide-tape-chrdev-oops-fix drivers/ide/ide-tape.c
--- linux-2.6.0-test9/drivers/ide/ide-tape.c~ide-tape-chrdev-oops-fix	2003-11-02 19:25:17.356121528 +0100
+++ linux-2.6.0-test9-root/drivers/ide/ide-tape.c	2003-11-02 19:26:13.490587792 +0100
@@ -5548,6 +5548,7 @@ static int idetape_chrdev_open (struct i
 		return -ENXIO;
 	drive = idetape_chrdevs[i].drive;
 	tape = drive->driver_data;
+	filp->private_data = drive;
 
 	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags))
 		return -EBUSY;

_

