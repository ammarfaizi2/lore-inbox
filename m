Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWIEVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWIEVGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWIEVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:06:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39828 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422647AbWIEVGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:06:48 -0400
Message-ID: <44FDE6E5.3090009@us.ibm.com>
Date: Tue, 05 Sep 2006 14:06:45 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Will Simoneau <simoneau@ele.uri.edu>
CC: linux-kernel@vger.kernel.org, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
References: <20060905171049.GB27433@ele.uri.edu>
In-Reply-To: <20060905171049.GB27433@ele.uri.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Simoneau wrote:
> Has anyone seen this before? These three traces occured at different times
> today when three new user accounts (and associated quotas) were created. This
> machine is an NFS server which uses quotas on an ext3 fs (dir_index is on).
> Kernel is 2.6.17.11 on an x86 smp w/64G highmem; 4G ram is installed. The
> affected filesystem is on a software raid1 of two hardware raid0 volumes from a
> megaraid card.
>
> BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
>  <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread+0x26/0x2a
>  <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
>  <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
>  <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
>  <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
>  
Made me curious and looking around on what the warning is coming ? Few 
basic questions ..
Do you have CONFIG_LBD ?

I see the ext3_getblk() used "long" for "block" & 
ext3_get_blocks_handle() expects "sector_t"
for "block". Wondering if you are running into 64-bit -to- 32-bit 
conversion issues .. ?

Thanks,
Badari

