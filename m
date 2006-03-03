Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWCCEba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCCEba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWCCEba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:31:30 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:9613 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1750759AbWCCEb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:31:29 -0500
Date: Fri, 03 Mar 2006 13:31:25 +0900 (JST)
Message-Id: <20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
To: akpm@osdl.org
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       johnstul@us.ibm.com, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060302190408.1e754f12.akpm@osdl.org>
References: <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
	<20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 2 Mar 2006 19:04:08 -0800, Andrew Morton <akpm@osdl.org> said:
akpm> John, that timer stuff is so fundamental and hits on code which
akpm> has historically been so fragile that I'm not sure it's even
akpm> 2.6.17 material.  In which case we should sneak patches like the
akpm> above underneath it all.

akpm> Or we decide to take your work into 2.6.17, in which case the
akpm> above needs to be redone for that context.

I think most important part is update_times() cleanup (to avoid
jiffies/wall_jiffies mismatch) and it (and x86_64 part) seems not
conflict with john's work for now.

akpm> I'm not sure how to resolve this, really.  Worried.  Have you
akpm> socialised those changes with architecture maintainers?  If so,
akpm> what was the feedback?

I and Ralf talked a bit about the jiffies issue.  Making an union
containing jiffies and jiffies_64 looks good to avoid such an
optimization problem, but it would affect so many existing codes.

---
Atsushi Nemoto
