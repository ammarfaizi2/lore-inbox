Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTE1Wfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTE1Wfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:35:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49568 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261322AbTE1Wfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:35:41 -0400
Date: Wed, 28 May 2003 15:47:20 -0700 (PDT)
Message-Id: <20030528.154720.74745668.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: mika.penttila@kolumbus.fi, rmk@arm.linux.org.uk, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305281827290.5042-100000@serv>
References: <Pine.LNX.4.44.0305270111370.5042-100000@serv>
	<20030527.142233.71088632.davem@redhat.com>
	<Pine.LNX.4.44.0305281827290.5042-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Wed, 28 May 2003 18:35:15 +0200 (CEST)
   
   set_pte() establishes the mapping, this means another cpu can get the pte 
   and start reading the data e.g. into the instruction cache, but if that 
   cpu still has dirty data in the data cache (e.g. a write() or a disk 
   read), the following update_mmu_cache() might be too late.
   
If that really matters for you, your set_pte() could add this
operation to a list of pending set_pte()'s in the mm_struct arch
specific context area.  Then at update_mmu_cache() it runs this
list of todo items.

I don't see the problem.
   
