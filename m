Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTE0VL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTE0VL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:11:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1687 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264181AbTE0VKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:10:34 -0400
Date: Tue, 27 May 2003 14:22:33 -0700 (PDT)
Message-Id: <20030527.142233.71088632.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: mika.penttila@kolumbus.fi, rmk@arm.linux.org.uk, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305270111370.5042-100000@serv>
References: <Pine.LNX.4.44.0305261414060.12110-100000@serv>
	<20030526.153415.41663121.davem@redhat.com>
	<Pine.LNX.4.44.0305270111370.5042-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 27 May 2003 12:53:12 +0200 (CEST)

   The point I don't like about update_mmu_cache() is that it's called 
   _after_ set_pte(). Practically it's maybe not a problem right now, but 
   the cache synchronization should happen before set_pte().

update_mmu_cache() is specifically supposed to always occur before
anyone could try to use the mapping created.

If this is ever violated, it will be fixed because it is a BUG().

So I don't see what you're worried about.

If the above were not true, sparc64 wouldn't be able to compile
a kernel successfully. :-)
