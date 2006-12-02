Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162835AbWLBIy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162835AbWLBIy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 03:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162841AbWLBIy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 03:54:26 -0500
Received: from smtpa2.aruba.it ([62.149.128.211]:15304 "HELO smtpa1.aruba.it")
	by vger.kernel.org with SMTP id S1162835AbWLBIyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 03:54:25 -0500
Subject: Re: [Bug 7505] Linux-2.6.19 fails to boot on AMD64 machine
From: Stefano Takekawa <take@libero.it>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Galanin <agalanin@mera.ru>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, benh@kernel.crashing.org,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Zhang Yanmin <yanmin.zhang@intel.com>,
       bugme-daemon@kernel-bugs.osdl.org
In-Reply-To: <m1odqohak7.fsf@ebiederm.dsl.xmission.com>
References: <200611302111.kAULBugP011242@fire-2.osdl.org>
	 <m1odqohak7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 09:54:37 +0100
Message-Id: <1165049677.12073.9.camel@proton.twominds.it>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtpa1.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Il giorno gio, 30/11/2006 alle 14.46 -0700, Eric W. Biederman ha
> scritto:
> bugme-daemon@bugzilla.kernel.org writes:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7505
> 
> > one. I think this was a better bisection and I got this
> 
> > Bisecting: 1 revisions left to test after this
> > [d71374dafbba7ec3f67371d3b7e9f6310a588808] PCI: fix race with pci_walk_bus and
> > pci_destroy_dev
> > d71374dafbba7ec3f67371d3b7e9f6310a588808 is first bad commit
> > commit d71374dafbba7ec3f67371d3b7e9f6310a588808
> > Author: Zhang Yanmin <yanmin.zhang@intel.com>
> > Date:   Fri Jun 2 12:35:43 2006 +0800
> > 
> >     [PATCH] PCI: fix race with pci_walk_bus and pci_destroy_dev
> > 
> >     pci_walk_bus has a race with pci_destroy_dev. When cb is called
> >     in pci_walk_bus, pci_destroy_dev might unlink the dev pointed by next.
> >     Later on in the next loop, pointer next becomes NULL and cause
> >     kernel panic.
> > 
> >     Below patch against 2.6.17-rc4 fixes it by changing pci_bus_lock (spin_lock)
> >     to pci_bus_sem (rw_semaphore).
> > 
> >     Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > :040000 040000 570ec0423dac5f57a4b7db859e4f502fab422b4d
> > 3fbe35bcc512418894e9ae3862f44363b8b0ab4e M      drivers
> > 
> 
> Let's try and discussing this someplace where people are watching.  Bugzilla
> seems to be a horrible medium for tracking down bugs.
> 
> Does reverting the above commit allow later kernels to boot?  Or do you
> still get the impossible oops?
> 
> Eric

I tried to revert the commit:

$ git revert d71374dafbba7ec3f67371d3b7e9f6310a588808
First trying simple merge strategy to revert.
Simple revert fails; trying Automatic revert.
Auto-merging drivers/pci/bus.c
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/pci/bus.c
Auto-merging drivers/pci/pci.h
Auto-merging drivers/pci/probe.c
Auto-merging drivers/pci/remove.c
Auto-merging drivers/pci/search.c
fatal: merge program failed
Automatic revert failed.  After resolving the conflicts,
mark the corrected paths with 'git-update-index <paths>'
and commit the result.

I don't know how to go on. Could someone help me?

(I'm leaving tomorrow, I'll be back in 4 days.)

-- 
Stefano Takekawa <take@libero.it>

