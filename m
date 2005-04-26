Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVDZEf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDZEf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVDZEf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:35:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:32448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbVDZEeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:34:18 -0400
Date: Mon, 25 Apr 2005 21:33:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: roland@topspin.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425213315.27db35db.akpm@osdl.org>
In-Reply-To: <426DB7B2.7000409@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com>
	<20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com>
	<20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com>
	<20050425173757.1dbab90b.akpm@osdl.org>
	<426DA58F.3020508@ammasso.com>
	<20050425201629.11d9118f.akpm@osdl.org>
	<426DB7B2.7000409@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Andrew Morton wrote:
> 
> > I'm referring to an application which uses your syscalls to obtain pinned
> > memory and uses munlock() so that it may then use your syscalls to obtain
> > evem more pinned memory.  With the objective of taking the machine down.
> 
> I'm in favor of having drivers call do_mlock() and do_munlock() on behalf of the 
> application.  All we need to do is export those functions, and my driver can call them. 
> However, that still doesn't prevent an app from calling munlock().

Precisely.  That's why I suggested that we have an alternative vma->vm_flag
bit which behaves in a similar manner to VM_LOCKED (say, VM_LOCKED_KERNEL),
only userspace cannot alter it.

> But I don't understand the distinction between having the driver call do_mlock() vs. the 
> application calling mlock().  Won't we still have the same problems?  A malicious app can 
> just call our driver instead of calling mlock() or munlock(). The driver won't know the 
> difference between an authorized app and an unauthorized one.

The driver will set VM_LOCKED_KERNEL, not VM_LOCKED.

> Besides, isn't the whole point behind RLIMIT_MEMLOCK to limit how much one process can lock?

Sure.  The internal setting of VM_LOCKED_KERNEL should still use
RLIMIT_MEMLOCK accounting.


