Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbTADDQT>; Fri, 3 Jan 2003 22:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbTADDQS>; Fri, 3 Jan 2003 22:16:18 -0500
Received: from hera.cwi.nl ([192.16.191.8]:29927 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266649AbTADDQR>;
	Fri, 3 Jan 2003 22:16:17 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 Jan 2003 04:24:32 +0100 (MET)
Message-Id: <UTC200301040324.h043OWK09534.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: inquiry in scsi_scan.c
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way - there are other cases where the INQUIRY length is
reported incorrectly. Another device does:

usb_stor_bulk_transfer_buf(): xfer 37 bytes
 00 80 02 02 20 00 00 00 65 55 53 42 20 20 20 20
 43 6F 6D 70 61 63 74 20 46 6C 61 73 68 20 20 20
 00 00 00 00
usb-storage: Status code 0; transferred 36/37
usb-storage: -- short transfer

In other words, we asked for 36, got 36 but the 0x20
indicated that the full length is 37. So we ask a second time,
but learn that only 36 bytes are available.

An off-by-one, as happens more often.

Fortunately this device does not hang, so is not yet a reason
to introduce additional patch code.

Andries
