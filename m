Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTEZFYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTEZFYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:24:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54152 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264268AbTEZFY3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:24:29 -0400
Date: Sun, 25 May 2003 22:36:55 -0700 (PDT)
Message-Id: <20030525.223655.123997551.davem@redhat.com>
To: mika.penttila@kolumbus.fi
Cc: rmk@arm.linux.org.uk, akpm@digeo.com, hugh@veritas.com,
       LW@KARO-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3ED1A7E2.6080607@kolumbus.fi>
References: <3ED1A0FE.3000101@kolumbus.fi>
	<20030525.220852.42800415.davem@redhat.com>
	<3ED1A7E2.6080607@kolumbus.fi>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Penttilä <mika.penttila@kolumbus.fi>
   Date: Mon, 26 May 2003 08:36:34 +0300

   ah, ok. so there are cache issues even if if the user pte is not 
   established yet? Then it seems natural to couple flush_dcache_page
   with pte establishing, not at the driver level.

flush_dcache_page() or some architecture level equivalent belongs
whereever the kernel uses CPU store instructions to modify a page's
contents.

When IDE uses PIO to do a data transfer, the flush belongs there.
Right now this is occuring in the architecture defined IDE insw/outsw
macros.  It very well might be more efficient to do this at a higher
level where the total extent of the I/O is known.
