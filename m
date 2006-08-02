Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWHBPFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWHBPFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWHBPFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:05:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43956 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751173AbWHBPFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:05:19 -0400
Subject: Re: sparsemem usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
In-Reply-To: <20060802134413.63901.qmail@web25814.mail.ukl.yahoo.com>
References: <20060802134413.63901.qmail@web25814.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Aug 2006 16:24:40 +0100
Message-Id: <1154532280.23655.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 13:44 +0000, ysgrifennodd moreau francis:
> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> #error Allocator MAX_ORDER exceeds SECTION_SIZE
> #endif
> 
> I'm not sure to understand why there's such check. To fix this
> I should change MAX_ORDER to 6.
> 
> Is it the only way to fix that ?

The kernel allocates memory out using groups of blocks in a buddy
system. 128K is smaller than one of the blocks so the kernel cannot
handle this. You need 2MB (if I remember right) granularity for your
sections but nothing stops you marking most of the 2Mb section except
the 128K that exists as "in use"

Alan

