Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJ1Q6v>; Mon, 28 Oct 2002 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJ1Q6v>; Mon, 28 Oct 2002 11:58:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60331 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261371AbSJ1Q6t>;
	Mon, 28 Oct 2002 11:58:49 -0500
Date: Mon, 28 Oct 2002 08:55:36 -0800 (PST)
Message-Id: <20021028.085536.32752918.davem@redhat.com>
To: willy@debian.org
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, hugh@veritas.com,
       akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk>
References: <20021028143226.N27461@parcelfarce.linux.theplanet.co.uk>
	<20021028.062608.78045801.davem@redhat.com>
	<20021028163649.P27461@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Mon, 28 Oct 2002 16:36:49 +0000

   While we're on the subject of cache flushing... these make no sense:
   
   fs/binfmt_aout.c:357:           flush_icache_range(text_addr, text_addr+ex.a_text+ex.a_data);
   fs/binfmt_aout.c:381:                   flush_icache_range((unsigned long) N_TXTADDR(ex),
   fs/binfmt_aout.c:479:           flush_icache_range((unsigned long) start_addr,
   fs/binfmt_elf.c:422:    flush_icache_range((unsigned long)addr,
   
   the kernel doesn't execute the code ranges here, userspace does.  Which
   means that the only place in the entire kernel which does need to call
   flush_icache_range() is kernel/module.c, and that could all be done in
   module_arch_init().  So I think we don't need flush_icache_range() at all.

Need to go into the revision history, discover who added these
calls, and ask them why they were added.
