Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030517AbVIOVRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbVIOVRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbVIOVRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:17:38 -0400
Received: from mail0.lsil.com ([147.145.40.20]:21756 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030517AbVIOVRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:17:37 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CD194@exa-atlanta>
From: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: How to avoid "Trying to register duplicated ioctl32 handler"
Date: Thu, 15 Sep 2005 17:17:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In our MegaRAID driver, one of the IOCTLs is defined as
#define MEGASAS_IOC_GET_AEN _IOW('M', 2, struct megasas_aen)

This clashes with some other value in "built_in" ioctl table on x86_64
kernels.
How do I really avoid such problems in the future. Even if I search the
length
of the built_in table and pick a unique value, is it guaranteed to be unique
in
the future releases? The Documentation/ioctl-number.txt isn't of much help
either.
It lists multiple conflicts. Moreover, not all of them are listed there.

On a broader note, if the struct ioctl_trans inside ioctl32_hash_table could
use the combination of cmd + major number instead of just cmd to determine
the
uniqueness, these conflicts could be avoided, right? I mean understand the
reasons
for system-wide unique ioctl numbers. But right now, only those platforms
that
need conversion are technically impeded for violating that guideline.

Thanks,
Sreenivas
