Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFOIA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFOIA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFOIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:00:55 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:16260 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261294AbVFOIAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:00:36 -0400
Message-ID: <000b01c57187$ade6b9b0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: .../asm-i386/bitops.h  performance improvements
Date: Wed, 15 Jun 2005 04:53:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In find_first_bit() there exists this the sequence:

shll $3,%%edi
addl %%edi,%%eax

LEA knows how to multiply by small powers of 2 and add all in one shot very
efficiently:

leal (%%eax,%%edi,8),%%eax


In find_first_zero_bit() the sequence:

shll $3,%%edi
addl %%edi,%%edx

could similarly become:

leal (%%edx,%%edi,8),%%edx



