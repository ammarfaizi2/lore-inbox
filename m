Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbULGLS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbULGLS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbULGLS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:18:26 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:4498 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261784AbULGLSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:18:21 -0500
Date: Tue, 7 Dec 2004 12:17:36 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: Stefan Schmidt <zaphodb@zaphods.net>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041207111736.GA10872@mail.muni.cz>
References: <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041203061835.GF1228@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041203061835.GF1228@frodo>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 05:18:35PM +1100, Nathan Scott wrote:
> OK, I took a quick look through - there's two places where we use
> GFP_ATOMIC at the moment.  One is a log debug/tracing chunk of code,
> wont be coming into play here, I'll go back and rework that later.
> The second is in the metadata buffering code, and is in a spot where
> we can cope with a failure (don't need to dip into emergency pools
> at all) but looks like we're avoiding sleeping there.
> 
> Does this patch improve things for your workload, Stefan?

This change leads to:

Filesystem "sda1": XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/x
fs/xfs_da_btree.c.  Caller 0xc0200641
 [<c02003da>] xfs_da_do_buf+0x72a/0x8df
 [<c0200641>] xfs_da_read_buf+0x57/0x5b
 [<c023e16c>] kmem_zone_alloc+0x50/0x96
 [<c01fe46c>] xfs_da_node_lookup_int+0x80/0x369
 [<c0200641>] xfs_da_read_buf+0x57/0x5b
 [<c02090e4>] xfs_dir2_leafn_lookup_int+0x381/0x551
 [<c02090e4>] xfs_dir2_leafn_lookup_int+0x381/0x551
 [<c01fe5f6>] xfs_da_node_lookup_int+0x20a/0x369
 [<c020ae13>] xfs_dir2_node_lookup+0x3f/0xb9
 [<c0202725>] xfs_dir2_lookup+0x13e/0x14e
 [<c0168342>] update_atime+0xd0/0xd5
 [<c0131f02>] do_generic_mapping_read+0x2bc/0x53f
 [<c02333e2>] xfs_dir_lookup_int+0x4c/0x12b
 [<c0238bd5>] xfs_lookup+0x50/0x88
 [<c0244ff0>] linvfs_lookup+0x58/0x96
 [<c015bd7e>] real_lookup+0xcd/0xf0
 [<c015bff4>] do_lookup+0x96/0xa1
 [<c015c692>] link_path_walk+0x693/0xd13
 [<c015cfbe>] path_lookup+0x93/0x155
 [<c015d674>] open_namei+0x85/0x60c
 [<c014dcd1>] filp_open+0x3e/0x64
 [<c014ea08>] vfs_read+0xc9/0x119
 [<c014dfac>] get_unused_fd+0x7b/0xcf
 [<c014e0f4>] sys_open+0x49/0x89
 [<c0103fcf>] syscall_call+0x7/0xb
xfs_da_do_buf: bno 96
			 

-- 
Luká¹ Hejtmánek
