Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUBENyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUBENyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:54:55 -0500
Received: from tristate.vision.ee ([194.204.30.144]:26070 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265227AbUBENyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:54:51 -0500
Message-ID: <40224B29.5090302@vision.ee>
Date: Thu, 05 Feb 2004 15:54:49 +0200
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc3-mm1 (w_size_write() wo i_sem)
References: <1075822589.2341.2.camel@glass.felipe-alfaro.com> <20040205054209.GF4394@triplehelix.org>
In-Reply-To: <20040205054209.GF4394@triplehelix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i_size_write() called without i_sem
Call Trace:
 [<c0139529>] i_size_write_check+0x59/0x60
 [<f9e2b1df>] nfs_update_inode+0x17f/0x600 [nfs]
 [<f9e31823>] nfs3_rpc_wrapper+0x63/0x70 [nfs]
 [<f9e2ab87>] __nfs_revalidate_inode+0x187/0x330 [nfs]
 [<f9df10c6>] rpc_release_task+0x186/0x240 [sunrpc]
 [<f9e34c00>] nfs3_xdr_accessres+0x0/0x50 [nfs]
 [<f9df0a0a>] __rpc_execute+0x27a/0x310 [sunrpc]
 [<f9dec6af>] rpc_call_sync+0x5f/0xa0 [sunrpc]
 [<f9e26da2>] nfs_lookup_revalidate+0x2f2/0x550 [nfs]
 [<f9e31cb6>] nfs3_proc_access+0xb6/0x120 [nfs]
 [<f9df24b6>] rpcauth_lookupcred+0x56/0xa0 [sunrpc]
 [<c015e10d>] do_lookup+0x5d/0x90
 [<c015e5f5>] link_path_walk+0x4b5/0x930
 [<c015eee4>] __user_walk+0x44/0x60
 [<c015a23a>] vfs_lstat+0x1a/0x50
 [<f9e34780>] nfs3_decode_dirent+0x0/0x240 [nfs]
 [<c0146cde>] do_brk+0x12e/0x200
 [<c015a8f2>] sys_lstat64+0x12/0x30
 [<c0166c3c>] dput+0x1c/0x250
 [<c0152687>] __fput+0xb7/0x110
 [<c0150e2f>] filp_close+0x4f/0x80
 [<c027945a>] sysenter_past_esp+0x43/0x65

Lenar

Ps. Found this too in logs, but think it's not related but has something 
to do with forcedeth driver:

eth1: too many iterations (6) in nic_irq.
