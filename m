Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSGAQDY>; Mon, 1 Jul 2002 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSGAQDX>; Mon, 1 Jul 2002 12:03:23 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:44202 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S315717AbSGAQDV> convert rfc822-to-8bit; Mon, 1 Jul 2002 12:03:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org
Subject: hd_geometry question.
Date: Mon, 1 Jul 2002 18:02:07 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207011802.07212.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a question about the start field in the hd_geometry structure. We used

	geo->start = device->major_info->gendisk.part[MINOR(kdev)].start_sect
		>> device->sizes.s2b_shift;

in the old dasd driver but now we use

	geo.start = get_start_sect(kdev);

to set the start field. One variant is wrong because the start sector differ if
the block size is not 512 byte. The first variant calculates the start sector
based on physical blocks (e.g. with 4096 bytes instead of 512 bytes). The
second variant calulcates a "soft" start sector based on logical 512 byte
blocks. Whats correct, first or second variant ?? I tend to favor the first
variant because struct hd_geometry describes the physical geometry
(number of heads, sectors, cylinders and start sector) but I am not 100%
sure about it.

blue skies,
  Martin.

