Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWAGGYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWAGGYL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 01:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWAGGYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 01:24:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932326AbWAGGYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 01:24:10 -0500
Date: Sat, 7 Jan 2006 01:23:57 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ext3 slab poison.
Message-ID: <20060107062357.GK9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

`tis the season for CONFIG_DEBUG_SLAB problems it seems.
As well as the cfq related bug I posted this afternoon,
I've now hit a different flavour..

		Dave

[179313.562261] Slab corruption: (Not tainted) start=ffff81000062c008, len=992
[179313.583178] Redzone: 0x5a2cf071/0x5a2cf071.
[179313.596153] Last user: [<ffffffff8019f39b>](dispose_list+0xe1/0x117)
[179313.615565]
[179313.615569] Call Trace:<ffffffff8016b318>{check_poison_obj+127} <ffffffff88089850>{:ext3:ext3_alloc_inode+21}
[179313.650499]        <ffffffff8016b4df>{cache_alloc_debugcheck_after+46}
[179313.670456]        <ffffffff8016dcbf>{kmem_cache_alloc+142} <ffffffff88089850>{:ext3:ext3_alloc_inode+21}
[179313.699645]        <ffffffff8019ed47>{alloc_inode+23} <ffffffff8019fe0c>{iget_locked+221}
[179313.724806]        <ffffffff8808957f>{:ext3:ext3_lookup+86} <ffffffff80193e4e>{do_lookup+236}
[179313.750884]        <ffffffff801961de>{__link_path_walk+2484} <ffffffff80196733>{link_path_walk+92}
[179313.778224]        <ffffffff8016b8cb>{cache_free_debugcheck+602} <ffffffff80196aea>{path_lookup+451}
[179313.806086]        <ffffffff801972a9>{__user_walk+44} <ffffffff8018f9ec>{vfs_stat+27}
[179313.830049]        <ffffffff8016b8cb>{cache_free_debugcheck+602} <ffffffff80161207>{audit_syscall_entry+301}
[179313.860007]        <ffffffff8018fbfc>{sys_newstat+17} <ffffffff80113293>{syscall_trace_enter+196}
[179313.887072]        <ffffffff801132cc>{syscall_trace_leave+53} <ffffffff8010f9f0>{tracesys+113}
[179313.913359]        <ffffffff8010fa50>{tracesys+209}
[179313.929182] 390: 01 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
[179313.948032] Next obj: start=ffff81000062c400, len=992
[179313.963496] Redzone: 0x5a2cf071/0x5a2cf071.
[179313.976349] Last user: [<ffffffff8019f39b>](dispose_list+0xe1/0x117)
[179313.995860] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
[179314.014860] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

