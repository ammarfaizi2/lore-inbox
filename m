Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUCZXXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCZXXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:23:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:56967 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261422AbUCZXXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:23:15 -0500
Date: Fri, 26 Mar 2004 15:25:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       wli@holomorphy.com
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-Id: <20040326152523.5bfe41db.akpm@osdl.org>
In-Reply-To: <20040326180235.GD9604@dualathlon.random>
References: <20040325214529.GJ20019@dualathlon.random>
	<Pine.LNX.4.44.0403261107100.16019-100000@localhost.localdomain>
	<20040326180235.GD9604@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Fri, Mar 26, 2004 at 11:57:23AM +0000, Hugh Dickins wrote:
> > Andrea's 2.6.5-rc2-aa4 (anon_vma): based on Martin's, but very
> > likely safe since it does not use find_vma at all in swapout, and
> > unuse_process downs mmap_sem as Martin's used to before.
> 
> Hugh, thanks for the review! I also don't see locking bugs in this area
> in my tree and I like not to take the page_table_lock during vma
> manipulations since I don't seem to need it.

It would be really, really nice if we could clean this crap up.  mmap_sem
protects the vma tree, i_shared_sem protects the per-address_space vma
lists and page_table_lock protects the pagetables.

Does this sound like something we can achieve?

(Could page_table_lock then become per-vma?)

