Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUD0G7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUD0G7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUD0G7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:59:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:52445 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263850AbUD0G7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:59:37 -0400
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts
	on contended spinlocks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Owens <kaos@sgi.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1928.1083031191@kao2.melbourne.sgi.com>
References: <1928.1083031191@kao2.melbourne.sgi.com>
Content-Type: text/plain
Message-Id: <1083048850.11576.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 16:54:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#ifdef __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS
> +#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
> +#else
> +#define _raw_spin_lock_flags(lock, flags) do { (void)flags; _raw_spin_lock(lock); } while(0)
> +#endif

Looks good, except as paulus noted that using 0 for flags in the
_raw_spin_lock() case is wrong, since 0 is a valid flags value
for some archs that could mean anything... 

Ben.


