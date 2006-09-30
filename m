Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWI3BeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWI3BeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWI3BeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:34:13 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:23251 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1161066AbWI3BeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:34:11 -0400
Date: Fri, 29 Sep 2006 18:33:48 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
Message-ID: <20060930013348.GA10905@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929182008.fee2a229.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 06:20:08PM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 20:01:54 -0400
> > 
> > Here's the traceback I got:
> > 
> > slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
> > [<c0103ad2>] dump_trace+0x64/0x1cd
> > [<c0103c4d>] show_trace_log_lvl+0x12/0x25
> > [<c010415f>] show_trace+0xd/0x10
> > [<c01041fc>] dump_stack+0x19/0x1b
> > [<c014c796>] __slab_error+0x17/0x1c
> > [<c014cdac>] cache_free_debugcheck+0xaf/0x230
> > [<c014d43e>] kfree+0x59/0x8c
> > [<c02dc04a>] ioctl_standard_call+0x1da/0x218
> > [<c02dc275>] wireless_process_ioctl+0x55/0x312
> > [<c02d3750>] dev_ioctl+0x45f/0x49a
> > [<c02c92aa>] sock_ioctl+0x1b3/0x1c6
> > [<c0160322>] do_ioctl+0x22/0x67
> > [<c01605a5>] vfs_ioctl+0x23e/0x251
> > [<c01605ff>] sys_ioctl+0x47/0x64
> > [<c0102cd3>] syscall_call+0x7/0xb
> > DWARF2 unwinder stuck at syscall_call+0x7/0xb

	Hum... Not clear what's happening. I'll look more into it on
monday.

> > A quick strace of gkrellm finds these likely ioctl's causing the problem:
> > 
> > % grep ioctl /tmp/foo2 | sort -u | more
> > ioctl(13, SIOCGIWESSID, 0xbfbcdb9c)     = 0

	That's most likely the one. I need to check the source code.

> Yes.  The main thing which those WE-21 patches do is to shorten the size of
> various buffers which are used in wireless ioctls.

	Only for ESSID, it reduce it by one char, and remove the final
'\0'. But, kernel wise, it should not matter.

> > Since I'm using an orinoco-based card, these 2 look like the most likely
> > candidates.  WE-21 was merged between -mm1 and -mm2, which is why -mm1 was
> > stable for me.

	I'm using Orinoco, I've not seen that with iwconfig.
	I'll look into that...

	Jean


