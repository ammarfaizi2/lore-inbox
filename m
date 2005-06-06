Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVFFRyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVFFRyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 13:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVFFRyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 13:54:32 -0400
Received: from fmr20.intel.com ([134.134.136.19]:50065 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261286AbVFFRy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 13:54:27 -0400
Message-Id: <20050606173652.059047000@csdlinux-2.jf.intel.com>
Date: Mon, 06 Jun 2005 10:36:52 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       systemtap@sources.redhat.com, rusty.lynch@intel.com,
       davidm@napali.hpl.hp.com, alen.brunelle@hp.com,
       anil.s.keshavamurthy@intel.com
Subject: [patch 0/3] Kprobes Ia64 more fixes....
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
	Based on the feedback obtained from the community, I have
have address the below issues in the Kprobes.

1) When patching the original instruction with the break instruction,
we need to preserve the original qualifying predicate for all instruction
except for some special instruction like
(qp) cmp.crel.ctype p1,p2=r1,r2
where ctype == unc, which always needs to be emulated irrespective of
original qp.

2) Fail register_kprobes() for unsupported instruction. Currently
Kprobes of some speculation chk instruction and mov r1=ip 
kind of instructions are not supported. Hence when user
tries to register kprobes on these instruction, fail register_kprobe()
instead of handling badly.

Comments welcome.

Thanks,
Anil Keshavamurthy
--

