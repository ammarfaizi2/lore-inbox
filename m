Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266438AbUFQJS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266438AbUFQJS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 05:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUFQJS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 05:18:56 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:3713 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S266438AbUFQJSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 05:18:49 -0400
To: linux-kernel@vger.kernel.org
cc: Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Buggy RSDP search in ACPI boot-time code
Date: Thu, 17 Jun 2004 10:18:44 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1Bat2k-0004cJ-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think that the 'high-memory' search range in acpi_find_rsdp() in
arch/i386/kernel/acpi.c (2.4.26) or arch/i386/kernel/acpi/boot.c
(2.6.5) is incorrect.

It is supposed to search 0xE0000-0x100000, but the length field is
incorrectly specified as 0xFFFFF. As in the 'proper' ACPI driver, the
correct length is 0x20000.

The current length means the search grooves on into the kernel itself,
but since the search string "RSD PTR" only appears in the data
section, the search will usually terminate before finding
'itself'. The fact that the search occurs only on 16-byte boundaries
also helps.

Probably best to fix this though. :-) I've already had to for the Xen
VMM (much smaller codebase means that the search string resides within
the too-large search space).

 -- Keir Fraser

PS. Please CC me with responses -- I'm not subscribed.
