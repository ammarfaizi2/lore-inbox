Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263279AbVCJWbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbVCJWbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVCJWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:31:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5389 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263279AbVCJW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:29:39 -0500
Date: Thu, 10 Mar 2005 22:29:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org
Subject: Netfilter ipt_hashlimit
Message-ID: <20050310222934.C1044@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	netfilter@lists.netfilter.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With current-ish Linus 2.6 BK, I'm seeing this:

net/ipv4/netfilter/ipt_hashlimit.c:96: warning: type defaults to `int' in declaration of `DECLARE_LOCK'
net/ipv4/netfilter/ipt_hashlimit.c:96: warning: parameter names (without types) in function declaration
net/ipv4/netfilter/ipt_hashlimit.c: In function `htable_create':
net/ipv4/netfilter/ipt_hashlimit.c:237: warning: implicit declaration of function `LOCK_BH'
net/ipv4/netfilter/ipt_hashlimit.c:237: error: `hashlimit_lock' undeclared (first use in this function)
net/ipv4/netfilter/ipt_hashlimit.c:237: error: (Each undeclared identifier is reported only once/home/rmk/bk/linux-2.6-rmk/net/ipv4/netfilter/ipt_hashlimit.c:237: error: for each function it appears in.)
net/ipv4/netfilter/ipt_hashlimit.c:239: warning: implicit declaration of function `UNLOCK_BH'
net/ipv4/netfilter/ipt_hashlimit.c: In function `htable_find_get':
net/ipv4/netfilter/ipt_hashlimit.c:305: error: `hashlimit_lock' undeclared (first use in this function)
net/ipv4/netfilter/ipt_hashlimit.c: In function `htable_put':
net/ipv4/netfilter/ipt_hashlimit.c:321: error: `hashlimit_lock' undeclared (first use in this function)
net/ipv4/netfilter/ipt_hashlimit.c: At top level:
net/ipv4/netfilter/ipt_hashlimit.c:96: warning: `DECLARE_LOCK' declared `static' but never defined

Looks like ipt_hashlimit.c is missing an include?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
