Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWBVWuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWBVWuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWBVWuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:50:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751028AbWBVWuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:50:52 -0500
Date: Wed, 22 Feb 2006 14:52:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [PATCH] refine for_each_pgdat() [1/4] refine for_each_pgdat
Message-Id: <20060222145256.7b84f444.akpm@osdl.org>
In-Reply-To: <20060222200402.e1145286.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060222200402.e1145286.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> This patch makes for_each_pgdat() use node_online_map.
> 
> Now, online nodes are managed by node_online_map. But 
> for_each_pgdat() uses pgdat_link to traverse all nodes(pgdat).
> This means management structure is duplicated.
> 
> I think using node_online_map for for_each_pgdat() is simple and
> sane implementation rather than pgdat_link.

We have a bit of a mess here.

for_each_pgdat() iterates over online nodes.

for_each_cpu() iterates over possible CPUs.

It's confusing and asymmetric.  If you have time, it would be nice to later
remove for_each_pgdat() and for_each_cpu() from the kernel altogether, use
for_each_online_cpu(), for_each_possible_cpu(), for_each_online_node(),
for_each_possible_node().
