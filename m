Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264835AbUEQCUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbUEQCUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUEQCUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:20:22 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:50612 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264835AbUEQCUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:20:16 -0400
To: fc scsi <scsi_fc_group@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: _PAGE_PCD bit in DMAable memory
References: <20040517011257.86012.qmail@web50003.mail.yahoo.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 16 May 2004 19:20:14 -0700
In-Reply-To: <20040517011257.86012.qmail@web50003.mail.yahoo.com>
Message-ID: <52r7tjx09t.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 May 2004 02:20:15.0129 (UTC) FILETIME=[7D588890:01C43BB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    fc> Hi, I am trying to get DMAable memory on i386
    fc> (kmalloc(GFP_DMA,)) but seems _PAGE_PCD is not set on the
    fc> pages that i get back the memory from. Am I getting the
    fc> correct results? If yes, then is it not that GFP_DMA should
    fc> give me non-cacheable memory (equivalent to setting _PAGE_PCD
    fc> along with _PAGE_PWT on i386). Can anyone confirm for me that
    fc> GFP_DMA will *always* give me non-cacheable and contiguous
    fc> memory.

On i386, the GFP_DMA flag controls _where_ the memory will be
allocated, namely in the low 16 MB.  This is really a relic of the
days of 24-bit ISA DMA.

On i386, the memory does not have to be non-cacheable, since in the PC
architecture the bus controller will maintain consistency by snooping
the CPU.  However, to be portable, your code should use
pci_alloc_consistent() to get memory for DMAing.  This will do the
right thing on all platforms, including making sure that the memory is
non-cacheable on architectures where the bus controller does not snoop.

(By the way, kmalloc() will always return contiguous memory, but you
should still use pci_alloc_consistent for DMA memory)

 - Roland
