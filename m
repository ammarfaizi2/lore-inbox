Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWHaLQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWHaLQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWHaLQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:16:01 -0400
Received: from lucidpixels.com ([66.45.37.187]:64147 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751480AbWHaLQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:16:00 -0400
Date: Thu, 31 Aug 2006 07:15:59 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
cc: apiszcz@lucidpixels.com
Subject: Re: 2.6.17.6 New(?) NFS Kernel Bug (OOPS) When vi /over/nfs/file.txt
In-Reply-To: <Pine.LNX.4.64.0608310708050.2348@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0608310715560.2391@p34.internal.lan>
References: <Pine.LNX.4.64.0608310708050.2348@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could not easily

On Thu, 31 Aug 2006, Justin Piszcz wrote:

> Short description: I have a text file I was editing over NFS, around 4 to 5 
> kilobytes.  It was during this time this occured:
>
> Note, this is the first time I have ever seen this bug.
> My .config is attached.  After a reboot, I ran the same vi command, no 
> issues, so I could easily reproduce the problem.
>
> Could anyone offer any insight to exactly what it was that caused this bug?
>
> I do have the numbers of NFSD's set to 32, I will set this back to 8 for now.
>
> [4640805.423000] BUG: unable to handle kernel NULL pointer dereference at 
> virtual address 00000003
> [4640805.423000]  printing eip:
> [4640805.423000] c02796cd
> [4640805.423000] *pde = 00000000
> [4640805.423000] Oops: 0000 [#1]
> [4640805.423000] PREEMPT SMP [4640805.423000] CPU:    0
> [4640805.423000] EIP:    0060:[<c02796cd>]    Not tainted VLI
> [4640805.423000] EFLAGS: 00210282   (2.6.17.6 #4) [4640805.423000] EIP is at 
> _atomic_dec_and_lock+0x5/0x58
> [4640805.423000] eax: 00000003   ebx: 00000003   ecx: 00000000   edx: 
> f70c72cc
> [4640805.423000] esi: c01d36b9   edi: c0423520   ebp: c04d2f98   esp: 
> f654bd78
> [4640805.423000] ds: 007b   es: 007b   ss: 0068
> [4640805.423000] Process nfsd (pid: 1130, threadinfo=f654a000 task=f6544a50)
> [4640805.423000] Stack: 00000003 c03bbec1 00000003 c0440800 f70c72c0 c01d36dd 
> 00000003 f70c72cc [4640805.423000]        c027ab7c f70c72cc 00200296 c03bf076 
> f70c72cc c04d2f98 de2e2ec0 c03bfd79 [4640805.423000]        f70c72cc c01d36b9 
> c042352c f70c72c0 f654be34 00000089 00000008 f654be10 [4640805.423000] Call 
> Trace:
> [4640805.423000]  <c03bbec1> auth_domain_put+0x18/0x51  <c01d36dd> 
> expkey_put+0x24/0x54
> [4640805.423000]  <c027ab7c> kref_put+0x31/0x94  <c03bf076> 
> cache_init+0x25/0x34
> [4640805.423000]  <c03bfd79> sunrpc_cache_lookup+0xf4/0x144  <c01d36b9> 
> expkey_put+0x0/0x54
> [4640805.423000]  <c01d1b7f> svc_expkey_lookup+0xa1/0xb4  <c01d1be8> 
> exp_find_key+0x56/0xb7
> [4640805.423000]  <c0376a5f> ip_push_pending_frames+0x2fb/0x466  <c03765c0> 
> dst_output+0x0/0xc
> [4640805.423000]  <c01d2d0b> exp_find+0x20/0x9c  <c0114d82> 
> try_to_wake_up+0x6e/0x3ca
> [4640805.423000]  <c01cdbf2> fh_verify+0x40f/0x57d  <c0350e6d> 
> skb_copy_bits+0x1f4/0x26f
> [4640805.423000]  <c01cea22> nfsd_open+0x34/0x14a  <c01cedb7> 
> nfsd_write+0xb5/0x10f
> [4640805.423000]  <c01d3f1e> nfsd_cache_lookup+0x250/0x36e  <c01d5cac> 
> nfsd3_proc_write+0x104/0x130
> [4640805.423000]  <c01cadeb> nfsd_dispatch+0x9b/0x21a  <c03b9159> 
> svc_process+0x3e4/0x6f8
> [4640805.423000]  <c03bba88> svc_recv+0x268/0x4c8  <c01cb33d> 
> nfsd+0x1ad/0x330
> [4640805.423000]  <c01cb190> nfsd+0x0/0x330  <c0100dc5> 
> kernel_thread_helper+0x5/0xb
> [4640805.423000] Code: ff 31 db 83 f8 01 77 17 89 c3 c7 44 24 04 d8 45 4b c0 
> 89 04 24 e8 64 ff ff ff 83 f8 01 76 e9 89 d8 83 c4 08 5b c3 53 8b 5c 24 08 
> <8b> 13 83 fa 01 74 18 8d 4a ff 89 d0 f0 0f b1 0b 39 c2 75 32 31 
> [4640805.423000] EIP: [<c02796cd>] _atomic_dec_and_lock+0x5/0x58 SS:ESP 
> 0068:f654bd78
> [4640805.423000]
