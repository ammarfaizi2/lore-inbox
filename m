Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTJJJIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTJJJIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:08:32 -0400
Received: from holomorphy.com ([66.224.33.161]:3457 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262726AbTJJJI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:08:29 -0400
Date: Fri, 10 Oct 2003 02:11:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3
Message-ID: <20031010091134.GA682@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
	"Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 09:54:12AM +0200, Frederick, Fabian wrote:
> 2.7 "thoughts"
> Thanks to Gabor, Stuart, Stephan and others
> Don't hesitate to send me more or comment.

Ugh, this is all crackpot wishlist gunk.

How about some goodies backed with real working code, like:

* O(1) proc_pid_statm()
	-- originally by bcrl for 2.4, fwd port maintained by wli
* O(lg(n)) proc_pid_readdir()/proc_task_readdir()
	-- original O(1) proc_pid_readdir() by manfred, rewritten by
	-- wli to use rbtrees for O(lg(n)) seeks into the relevant
	-- lists (walking over empty buckets had overhead)
* 4KB ia32 kernel stacks + irqstacks
	-- original by bcrl, fwd port maintained by dhansen for a
	-- substantial amount of time, now maintained by wli
* ia32 leaf pagetable node cache
	-- wli
* node-local per_cpu areas for ia32 NUMA
	-- wli
* highpmd, analogue of highpte for pmd's
	-- wli. Gets pmd's on node-local mem on ia32 NUMA, and
	-- alleviates a lot of lowmem pressure under heavy
	-- multiprogramming levels on PAE.

Some benchmarks of a patchset including these (and several other things)
are at http://home.earthlink.net/~rwhron/kernel/wli.html, and some ports
of the patch set are at ftp://ftp.kernel.org/people/wli/kernels/

Whatever fantasy may be worth, working code is worth a lot more. I'll
refrain from mentioning prototype-quality patches I'm hacking on atm.


-- wli
