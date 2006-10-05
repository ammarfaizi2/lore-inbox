Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWJEAwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWJEAwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWJEAwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:52:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50371 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751282AbWJEAwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:52:00 -0400
Date: Wed, 4 Oct 2006 20:51:24 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Fox <drfickle@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>, kmannth@us.ibm.com
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-ID: <20061005005124.GA23408@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <efh217$8au$1@sea.gmane.org> <20060928140124.5f7154e3.akpm@osdl.org> <1159969349.28106.64.camel@flooterbu> <20061004084540.af17fee5.akpm@osdl.org> <1159980119.28106.75.camel@flooterbu> <20061004170659.f3b089a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004170659.f3b089a8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 05:06:59PM -0700, Andrew Morton wrote:
> On Wed, 04 Oct 2006 11:41:59 -0500
> Steve Fox <drfickle@us.ibm.com> wrote:
> 
> > On Wed, 2006-10-04 at 08:45 -0700, Andrew Morton wrote:
> > > On Wed, 04 Oct 2006 08:42:28 -0500
> > > Steve Fox <drfickle@us.ibm.com> wrote:
> > > > Sorry for the delay. I was finally able to perform a bisect on this. It
> > > > turns out the patch that causes this is
> > > > x86_64-mm-re-positioning-the-bss-segment.patch, which seems like a
> > > > strange candidate, but sure enough I can boot to login: right up until
> > > > that patch is applied.
> > > 
> > > hm, that patch was merged into mainline September 29.  Does mainline work?
> > 
> > -git21 also fails with this same error.
> > 
> 
> OK, thanks.  And we know that
> x86_64-mm-re-positioning-the-bss-segment.patch triggered this failure.  And
> that patch is non-buggy, and the xfrm code is probably non-buggy.  So we don't
> know squat, and we're going to need to debug this crash.
> 
> Well.  There is one trick we could use: apply
> x86_64-mm-re-positioning-the-bss-segment.patch to 2.6.18 base and see if it
> crashes.  If it doesn't, then we can theorise that the bug is some buggy
> post 2.6.18 patch which is being exposed by

I think most likely it would crash on 2.6.18. Keith mannthey had reported
a different crash on 2.6.18-rc4-mm2 when this patch was introduced first
time. Following is the link to the thread.

http://marc.theaimsgroup.com/?l=linux-kernel&m=115629369729911&w=2

Following is the backtrace he had reported.

 Unable to handle kernel NULL pointer dereference at 0000000000000007
 RIP:
  [<ffffffff803d45b0>] __unix_insert_socket+0x49/0x5a
 PGD 115c934067 PUD 115c935067 PMD 0
 Oops: 0002 [1] SMP
 last sysfs file:
 CPU 14
 Modules linked in:
 Pid: 1, comm: init Not tainted 2.6.18-rc4-mm2-smp #3
 RIP: 0010:[<ffffffff803d45b0>]  [<ffffffff803d45b0>]
 __unix_insert_socket+0x49/0x5a
 RSP: 0018:ffff810460605eb8  EFLAGS: 00010286
 RAX: ffffffffffffffff RBX: ffff81115c171c80 RCX: 0000000000000000
 RDX: ffff81115c171c88 RSI: ffff81115c171c80 RDI: ffffffff806656e0
 RBP: ffffffff806656e0 R08: ffff81115c069200 R09: ffff8110700b4000
 R10: 0000000000000000 R11: 0000000000000002 R12: ffff81115c170d00
 R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
 FS:  00002b793a4fd6d0(0000) GS:ffff81115c910e40(0000)
 knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
 CR2: 0000000000000007 CR3: 000000115c92d000 CR4: 00000000000006e0
 Process init (pid: 1, threadinfo ffff810460604000, task
 ffff81115cb10040)
 Stack:  0000000100000001 00000000ffffffff ffff81115c171c80
 ffffffff803d58e9
  ffffffff8045bb30 0000000180298f61 ffffffff80498080 0000000000000001
  ffff81115c170d00 ffffffff803d595d 0000000000000004 ffffffff80376061
 Call Trace:
  [<ffffffff803d58e9>] unix_create1+0xf3/0x107
  [<ffffffff803d595d>] unix_create+0x60/0x6b
  [<ffffffff80376061>] __sock_create+0x12f/0x227
  [<ffffffff80376429>] sys_socket+0xf/0x37
  [<ffffffff8020968e>] system_call+0x7e/0x83


 Code: 48 89 50 08 48 89 55 00 48 89 6a 08 41 58 5b 5d c3 c7 47 08
 RIP  [<ffffffff803d45b0>] __unix_insert_socket+0x49/0x5a
  RSP <ffff810460605eb8>
 CR2: 0000000000000007
  <0>Kernel panic - not syncing: Attempted to kill init!

Thanks
Vivek
