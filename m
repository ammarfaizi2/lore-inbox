Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTAMHft>; Mon, 13 Jan 2003 02:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTAMHft>; Mon, 13 Jan 2003 02:35:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1690 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267271AbTAMHfs>;
	Mon, 13 Jan 2003 02:35:48 -0500
Date: Sun, 12 Jan 2003 23:35:13 -0800 (PST)
Message-Id: <20030112.233513.83403887.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030113072521.74B842C104@lists.samba.org>
References: <20030113072521.74B842C104@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 13 Jan 2003 18:24:40 +1100

   Dave: Anton suggested you might have a justification for
   __cacheline_aligned doing something on UP?
   
   I think I'd prefer __cacheline_aligned to be the same as
   __cacheline_aligned_in_smp, and have a new __cacheline_aligned_always
   for those who REALLY want it (if any).
   
I think things like oprofile_buffer really want it always.

   -struct tcp_hashinfo __cacheline_aligned tcp_hashinfo = {
   +struct tcp_hashinfo __cacheline_aligned_in_smp tcp_hashinfo = {

This definitely too.

All of the submembers are placed at cacheline boundaries, which
helps even on UP.  If I meant cacheline aligned on SMP I would
have used the corresponding macro :)
