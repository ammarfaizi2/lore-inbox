Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTE2BY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTE2BY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 21:24:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44449 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261808AbTE2BY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 21:24:58 -0400
Date: Wed, 28 May 2003 18:37:00 -0700 (PDT)
Message-Id: <20030528.183700.104033543.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: mika.penttila@kolumbus.fi, rmk@arm.linux.org.uk, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305290151470.5042-100000@serv>
References: <Pine.LNX.4.44.0305281827290.5042-100000@serv>
	<20030528.154720.74745668.davem@redhat.com>
	<Pine.LNX.4.44.0305290151470.5042-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Thu, 29 May 2003 02:12:47 +0200 (CEST)

   BTW it's a bit unfortunate that flush_dcache_page() is called for reads 
   and writes.

Please don't say it this way, this is an inaccurate description.

DMA-mapping.txt defines very precisely when flush_dcache_page() is
invoked, and that is it's only definition.  I purposely DO NOT say
that "this is for reads" or "this is for handling virtual aliasing
in L1 caches", I simply define where this macro is invoked and
that is it.

Specifically, flush_dcache_page() is called any time the kernel makes
cpu stores into a page cache page that might be mapped into a user's
address space.
