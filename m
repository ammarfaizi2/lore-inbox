Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUD0MFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUD0MFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUD0MFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:05:39 -0400
Received: from pr-117-210.ains.net.au ([202.147.117.210]:51398 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S264022AbUD0MFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:05:38 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on contended spinlocks 
In-reply-to: Your message of "Tue, 27 Apr 2004 21:36:48 +1000."
             <16526.17872.872703.799153@cargo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Apr 2004 22:05:25 +1000
Message-ID: <2300.1083067525@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 21:36:48 +1000, 
Paul Mackerras <paulus@samba.org> wrote:
>I was just thinking yesterday that it would be good to reenable
>interrupts during spin_lock_irq on ppc64.  I am hacking on the
>spinlocks for ppc64 at the moment and this looks like something worth
>adding.
>
>Why not keep _raw_spin_lock as it is and only use _raw_spin_lock_flags
>in the spin_lock_irq{,save} case?

Using both _raw_spin_lock and _raw_spin_lock_flags doubles the amount
of code to maintain.

Architectures like ia64 that use a common out of line contention path
need a common interface for all spinlocks, for the cases with and
without irq{,save}.

You can test __builtin_constant_p(flags) and fold out the case of the
flags being a known 'no flags available' value to get separate
contended paths if that is really what you want.  But for architectures
that want a common path for all contended locks, you have to start with
common code.

