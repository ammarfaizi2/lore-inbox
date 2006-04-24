Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWDXSZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWDXSZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDXSZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:25:51 -0400
Received: from mail1.inittab.de ([194.150.191.147]:60433 "EHLO
	mail1.inittab.de") by vger.kernel.org with ESMTP id S1751102AbWDXSZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:25:50 -0400
Date: Mon, 24 Apr 2006 20:25:48 +0200
From: Norbert Tretkowski <norbert@tretkowski.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.9 alpha compile error
Message-ID: <20060424182547.GA6218@kyllikki.home.inittab.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200604241608.13153.list-lkml@net4u.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604241608.13153.list-lkml@net4u.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ernst Herzberg wrote:
> arch/alpha/kernel/setup.c: In function `register_cpus':
> arch/alpha/kernel/setup.c:486: warning: implicit declaration of function `for_each_possible_cpu'
> arch/alpha/kernel/setup.c:486: error: syntax error before '{' token
> arch/alpha/kernel/setup.c:488: error: `p' undeclared (first use in this function)
> arch/alpha/kernel/setup.c:488: error: (Each undeclared identifier is reported only once
> arch/alpha/kernel/setup.c:488: error: for each function it appears in.)
> arch/alpha/kernel/setup.c: At top level:
> arch/alpha/kernel/setup.c:492: error: syntax error before "return"

From: Andrew Morton <akpm@osdl.org>

Backport for_each_possible_cpu() into 2.6.16.  Fixes the alpha build, and any
future occurrences.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/cpumask.h |    1 +
 1 files changed, 1 insertion(+)

--- a/include/linux/cpumask.h   2006-04-24 19:28:56.000000000 +0200
+++ b/include/linux/cpumask.h   2006-04-24 19:29:21.000000000 +0200
@@ -408,6 +408,7 @@
 })
 
 #define for_each_cpu(cpu)        for_each_cpu_mask((cpu), cpu_possible_map)
+#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)
 #define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
