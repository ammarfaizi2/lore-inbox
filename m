Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTDVJNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTDVJNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:13:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8629 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263024AbTDVJNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:13:35 -0400
Date: Tue, 22 Apr 2003 11:25:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Heiko.Rabe@InVision.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistent usage of
Message-ID: <20030422092536.GH4911@suse.de>
References: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22 2003, Heiko.Rabe@InVision.de wrote:
> I found inconsistent behavoir between SMP oand none SMP kernels using spin
> locks inside driver programming
> As first an simple example:
> 
> static spinlock_t        qtlock               = SPIN_LOCK_UNLOCKED;
> 
> void foo()
> {
>      unsigned long  local_flags;
>      spin_lock_irqsave (&qtlock, local_flags);
>      spin_lock_irqsave (&qtlock, local_flags);
> }

[snip rant]

Check the spinlock implementation. All the above does in UP is
disable/save interrupts twice. The actual spinlock is a nop. As only one
processor can be executing inside the kernel in UP, you only need to
guard against interrupts.

-- 
Jens Axboe

