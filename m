Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUB0CLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUB0CLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:11:09 -0500
Received: from holomorphy.com ([199.26.172.102]:38414 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261659AbUB0CLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:11:04 -0500
Date: Thu, 26 Feb 2004 18:11:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jochen Roemling <jochen@roemling.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040227021101.GV693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net> <403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com> <403E9E54.6030404@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E9E54.6030404@roemling.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>Check /proc/sys/vm/nr_hugepages and /proc/sys/kernel/shmmax also.

On Fri, Feb 27, 2004 at 02:33:08AM +0100, Jochen Roemling wrote:
> cat /proc/sys/vm/nr_hugepages
> 64

256MB limit there.


On Fri, Feb 27, 2004 at 02:33:08AM +0100, Jochen Roemling wrote:
> cat /proc/sys/kernel/shmmax
> 33554432

32MB limit there.


On Fri, Feb 27, 2004 at 02:33:08AM +0100, Jochen Roemling wrote:
> cat /proc/meminfo | grep Huge
> HugePages_Total:    64
> HugePages_Free:     62
> Hugepagesize:     4096 kB
> but again: root can, users cannot, so sizes won't matter, would they?

It's capable(CAP_IPC_LOCK) || in_group_p(0), not current->uid == 0.
It will barf if you ask for more than either one of those limits. It
will also barf if you ask for an amount not a multiple of the hugepage
size. Please show the test program's code and strace the test program
to determine what response it's getting.


-- wli
