Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318983AbSICX6i>; Tue, 3 Sep 2002 19:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318988AbSICX6i>; Tue, 3 Sep 2002 19:58:38 -0400
Received: from mnh-1-16.mv.com ([207.22.10.48]:56581 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318983AbSICX6h>;
	Tue, 3 Sep 2002 19:58:37 -0400
Message-Id: <200209040107.UAA03954@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: __pa(vmalloc()) considered harmful?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 20:07:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sure doesn't make sense to me, but that's effectively what 
elf_kcore_store_hdr does:

	for (m=vmlist; m; m=m->next) {
		[ snip ]
		phdr->p_paddr	= __pa(m->addr);
		[ snip ]
	}

This doesn't actually hurt when __pa(addr) == addr - $SOMETHING, but it
does produce meaningless numbers.

It does hurt when your __pa() is something more complicated and it can
tell that it's being asked to do something stupid.

So what's p_paddr supposed to be, anyway?

				Jeff

