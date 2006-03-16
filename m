Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWCPET2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWCPET2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbWCPET2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:19:28 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28896 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752055AbWCPET1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:19:27 -0500
Date: Thu, 16 Mar 2006 13:17:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines
 for_each_possible_cpu
Message-Id: <20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4418DEEA.2000008@yahoo.com.au>
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
	<4418DEEA.2000008@yahoo.com.au>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 14:43:38 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> The only places where things might care is arch bootup code, but
> the cpu interface is such that the arch code is expected to _hide_
> any weird details from these generic interfaces.
> 
Please see i386 patch. it contains BUG fix.
cpu_msrs[i].coutners are allocated by for_each_online_cpu().
and free it by for_each_possible_cpus() without no pointer check.

I think this kind of confusion will be seen again in future.
--Kame
--
 static void free_msrs(void)
 {
        int i;
-       for_each_cpu(i) {
-               kfree(cpu_msrs[i].counters);
+       for_each_possible_cpu(i) {
+               if (cpu_msrs[i].counters)
+                       kfree(cpu_msrs[i].counters);
                cpu_msrs[i].counters = NULL;
-               kfree(cpu_msrs[i].controls);
+               if (cpu_msrs[i].controls)
+                       kfree(cpu_msrs[i].controls);
                cpu_msrs[i].controls = NULL;
        }
 }
--
