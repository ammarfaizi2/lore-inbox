Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVCARGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVCARGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCARGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:06:21 -0500
Received: from 213-239-234-136.clients.your-server.de ([213.239.234.136]:6306
	"EHLO suckfuell.net") by vger.kernel.org with ESMTP id S261979AbVCARGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:06:20 -0500
Date: Tue, 1 Mar 2005 18:06:14 +0100
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: linux-kernel@vger.kernel.org
Subject: Unbacked shared memory not included in ELF core dump
Message-ID: <20050301170614.GA6121@ds217-115-141-141.dedicated.hosteurope.de>
Mail-Followup-To: Jochen Suckfuell <jo-lkml@suckfuell.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since 2.6.10, unbacked shared memory allocated via shmget is not
included in core dumps. The relevant patch has been done to binfmt_elf.c
after the discussion to "include all vmas with unbacked pages in ELF
core dumps", here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/1890.html

The result was:

static int maydump(struct vm_area_struct *vma)
{
	/* Do not dump I/O mapped devices, shared memory, or special mappings */
	if (vma->vm_flags & (VM_IO | VM_SHARED | VM_RESERVED))
		return 0;
...

I consider this a bug, since we clearly lose unbacked shared memory in
the process.

bye
Jochen Suckfüll

