Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUIUMJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUIUMJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUIUMJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:09:00 -0400
Received: from smtp2k.poczta.onet.pl ([213.180.130.34]:62173 "EHLO
	smtp2k.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S267598AbUIUMI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:08:58 -0400
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Tue, 21 Sep 2004 14:08:41 +0200
From: porterzy@op.pl
To: =?ISO-8859-2?Q?lkml=A0?= <linux-kernel@vger.kernel.org>
Subject: problem with porting 2.6.8 kernel to ppc 405CR
X-Priority: 3
X-Mailer: onet.poczta
Message-Id: <20040921120848Z141960-28297+196544@kps2.test.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have problem with booting the kernel. Bootup stops after message "Now booting the kernel.. Done". I traced that execution doesn't return from function __alloc_bootmem_core (mm/bootmem.c). Depending on crosstool versions I used it stops on different lines (marked ->)

->	offset = 0;
	if (align &&
	    (bdata->node_boot_start & (align - 1UL)) != 0)
		offset = (align - (bdata->node_boot_start & (align - 1UL)));
	offset >>= PAGE_SHIFT;

	/*
	 * We try to allocate bootmem pages above 'goal'
	 * first, then we try to allocate lower pages.
	 */
	if (goal && (goal >= bdata->node_boot_start) && 
	    ((goal >> PAGE_SHIFT) < bdata->node_low_pfn)) {
		preferred = goal - bdata->node_boot_start;

		if (bdata->last_success >= preferred)
			preferred = bdata->last_success;
	} else
		preferred = 0;

	preferred = ((preferred + align - 1) & ~(align - 1)) >> PAGE_SHIFT;
	preferred += offset;
->	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
->	incr = align >> PAGE_SHIFT ? : 1;

This looks very strange. Can someone explain what may be the reason?
Regards,
W.B. Lach
