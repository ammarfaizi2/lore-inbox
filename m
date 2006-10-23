Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWJWKfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWJWKfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWJWKfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:35:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42980 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751881AbWJWKfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:35:07 -0400
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid
	context'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061023061348.AC97DEF086@wolfe.lmc.cs.stonybrook.edu>
References: <20061023061348.AC97DEF086@wolfe.lmc.cs.stonybrook.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 11:38:14 +0100
Message-Id: <1161599894.19388.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 02:13 -0400, ysgrifennodd Giridhar Pemmasani:
> Synopsis of patch: If __vmalloc is called to allocate memory with
> GFP_ATOMIC in atomic context, the chain of calls results in
> __get_vm_area_node allocating memory for vm_struct with GFP_KERNEL

You are not allowed to call vmalloc in atomic context, especially in
interrupt paths. Vmalloc has to do TLB handling work and that can
involve cross calls and other stuff that isn't IRQ friendly on all
platforms.


