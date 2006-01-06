Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752549AbWAFU1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbWAFU1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbWAFU1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:27:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:57991 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752548AbWAFU1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:27:05 -0500
Content-Type: multipart/mixed; boundary="===============0495824558=="
MIME-Version: 1.0
Subject: [PATCH 0 of 3] 32-bit MMIO copy routine
Message-Id: <patchbomb.1136579193@eng-12.pathscale.com>
Date: Fri,  6 Jan 2006 12:26:33 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0495824558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Following some discussion with Roland, and patterned after the style
anointed by Linus last week, here is a new version of the 32-bit MMIO
copy routine needed by our InfiniPath device.

The name of the routine has changed from memcpy_toio32 to
__raw_memcpy_toio32.  This reflects the basic nature of the routine;
it dodes not guarantee the order in which writes are performed, nor does
it perform a memory barrier after it is done.

The reason for this is that our chip treats the first and last writes
to some MMIO regions specially; our driver performs those directly using
writel, and uses __raw_memcpy_toio32 for the bits in between.

Regarding the specialised x86_64 implementation, Andi Kleen asked me
to perform some measurements of its performance impact.  It makes a
difference of about 5% in performance on moderately large copies over
the HyperTransport bus, compared to the generic implementation.

	<b

--===============0495824558==--
