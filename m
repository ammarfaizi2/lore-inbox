Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWINTFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWINTFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWINTFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:05:50 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:23704 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1751035AbWINTFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:05:49 -0400
Date: Thu, 14 Sep 2006 12:05:48 -0700
To: linux-kernel@vger.kernel.org
Subject: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060914190548.GI4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912223258.GM4612@chain.digitalkingdom.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 03:32:58PM -0700,  wrote:
> 
> Please cc me on replies, as I'm not on the list.

Nevermind; I'm watching the thread at
http://lkml.org/lkml/2006/9/12/300

> I have some moderately old hosts that hang on boot, very early on,
> with any kernel newer than 2.6.3.  Important basic facts about the
> box are dual opteron 244s, 16gb of RAM, and it's a 64-bit build of
> the kernel.

This isn't just me.  All the Debian kernels hang too.  I've tried
all of the following:

Linux version 2.6.8-12-amd64-generic (buildd@bester) (gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:12:05 UTC 2006

Linux version 2.6.8-12-amd64-k8 (buildd@bester) (gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:39:03 UTC 2006

Linux version 2.6.8-12-amd64-k8-smp (buildd@bester) (gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 SMP Mon Jul 17 00:17:20 UTC 2006

The boot messages differ only in trivial ways, and they all end
with:

- ----------

NET: Registered protocol family 16
CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
RIP 10:<ffffffff8023a44c> {pci_conf1_read+0xac/0xe0}
TSC d189cea ADDR fdfc000cfe
CPU 0: Machine Check Exception:                7 Bank 0: b40000000000083b
RIP 10:<ffffffff8023a44c> {pci_conf1_read+0xac/0xe0}
TSC 0
Kernel panic: Uncorrected machine check


- ----------

This happens on 4 different machine!  The only way to get them to
boot to a kernel later than 2.6.3 is "nomce".

I assert that an MCE on multiple machines that have been running
successfully on 2.6.2 for *years* is bad kernel behaviour; we have
no reason to believe that 4 different machines that happen to have
identical hardware have all developed the same hardware failure at
the same time.

Is there anything I can do here besides nomce?

Boot messages on Debian kernels from the primary host:

    amd64 generic:
    http://teddyb.org/~rlpowell/media/regular/lkml/amd64-generic-boot.txt

    amd64 k8:
    http://teddyb.org/~rlpowell/media/regular/lkml/amd64-k8-boot.txt

    amd64 k8 smp:
    http://teddyb.org/~rlpowell/media/regular/lkml/amd64-k8-smp-boot.txt

Boot messages from two other hosts booting Debian's 2.6.8-11 amd64
generic kernel; these hosts are used for massive report jobs in
production on a 2.6.2 kernel, so we *know* they work:

    http://teddyb.org/~rlpowell/media/regular/lkml/prodbing3-boot.txt

    http://teddyb.org/~rlpowell/media/regular/lkml/prodbing4-boot.txt

-Robin
