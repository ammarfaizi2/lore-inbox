Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031519AbWK3Vrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031519AbWK3Vrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967935AbWK3Vrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:47:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37295 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S967934AbWK3Vru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:47:50 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: agalanin@mera.ru (Alexander Galanin), take@libero.it
Cc: <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       benh@kernel.crashing.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Zhang Yanmin <yanmin.zhang@intel.com>
Subject: Re: [Bug 7505] Linux-2.6.19 fails to boot on AMD64 machine
References: <200611302111.kAULBugP011242@fire-2.osdl.org>
Date: Thu, 30 Nov 2006 14:46:48 -0700
In-Reply-To: <200611302111.kAULBugP011242@fire-2.osdl.org>
	(bugme-daemon@bugzilla.kernel.org's message of "Thu, 30 Nov 2006
	13:11:56 -0800")
Message-ID: <m1odqohak7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bugme-daemon@bugzilla.kernel.org writes:

> http://bugzilla.kernel.org/show_bug.cgi?id=7505

> one. I think this was a better bisection and I got this

> Bisecting: 1 revisions left to test after this
> [d71374dafbba7ec3f67371d3b7e9f6310a588808] PCI: fix race with pci_walk_bus and
> pci_destroy_dev
> d71374dafbba7ec3f67371d3b7e9f6310a588808 is first bad commit
> commit d71374dafbba7ec3f67371d3b7e9f6310a588808
> Author: Zhang Yanmin <yanmin.zhang@intel.com>
> Date:   Fri Jun 2 12:35:43 2006 +0800
> 
>     [PATCH] PCI: fix race with pci_walk_bus and pci_destroy_dev
> 
>     pci_walk_bus has a race with pci_destroy_dev. When cb is called
>     in pci_walk_bus, pci_destroy_dev might unlink the dev pointed by next.
>     Later on in the next loop, pointer next becomes NULL and cause
>     kernel panic.
> 
>     Below patch against 2.6.17-rc4 fixes it by changing pci_bus_lock (spin_lock)
>     to pci_bus_sem (rw_semaphore).
> 
>     Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> :040000 040000 570ec0423dac5f57a4b7db859e4f502fab422b4d
> 3fbe35bcc512418894e9ae3862f44363b8b0ab4e M      drivers
> 

Let's try and discussing this someplace where people are watching.  Bugzilla
seems to be a horrible medium for tracking down bugs.

Does reverting the above commit allow later kernels to boot?  Or do you
still get the impossible oops?

Eric
