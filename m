Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbTDVJJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTDVJJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:09:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1664 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263020AbTDVJJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:09:34 -0400
Date: Tue, 22 Apr 2003 10:21:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Heiko.Rabe@InVision.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistent usage of
Message-ID: <20030422092138.GS10374@parcelfarce.linux.theplanet.co.uk>
References: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 10:11:11AM +0200, Heiko.Rabe@InVision.de wrote:
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
> 
> Calling the function foo() works proper in none SMP kernels. I assume, the

... only because spinlocks are no-op on UP.

> spinlocks internaly will be initialized as
> recursive semaphore as default. So it is possible to aquire it more than
> once by the same thread.

Spinlocks are *not* recursive.  The code above is a bug - it's just that
on non-SMP it doesn't get caught.

Spinlock is a mutex, not a recursive sempahore.
