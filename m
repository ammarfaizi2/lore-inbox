Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272504AbTHEQOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272461AbTHEQOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:14:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:31432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272525AbTHEQNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:13:44 -0400
Date: Tue, 5 Aug 2003 09:09:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, akpm@osdl.org, ogasawara@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
Message-Id: <20030805090958.368ef508.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 16:48:02 +0100 (BST) Hugh Dickins <hugh@veritas.com> wrote:

| Please revert to static zero initialization of a const: when thus
| initialized it's linked into a readonly cacheline shared between cpus;
| otherwise it's linked into bss, likely to be in a dirty cacheline
| bouncing between cpus.
| 
| --- 2.6.0-test2-bk/mm/shmem.c	Tue Aug  5 15:57:31 2003
| +++ linux/mm/shmem.c	Tue Aug  5 16:16:55 2003
| @@ -296,7 +296,7 @@
|  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
|  	struct page *page = NULL;
|  	swp_entry_t *entry;
| -	static const swp_entry_t unswapped;
| +	static const swp_entry_t unswapped = {0};

In all of the "don't init statics to 0" patches, should we
check for "const" also and leave those with 0 initializers
(with explanation as Arjan requested)?

--
~Randy
