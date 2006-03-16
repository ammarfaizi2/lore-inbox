Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWCPD6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWCPD6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWCPD6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:58:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932615AbWCPD6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:58:16 -0500
Date: Wed, 15 Mar 2006 19:55:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines
 for_each_possible_cpu
Message-Id: <20060315195537.0a039f64.akpm@osdl.org>
In-Reply-To: <4418DEEA.2000008@yahoo.com.au>
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
	<4418DEEA.2000008@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> KAMEZAWA Hiroyuki wrote:
> > Now,
> > for_each_cpu() is for-loop cpu over cpu_possible_map.
> > for_each_online_cpu is for-loop cpu over cpu_online_map.
> > .....for_each_cpu() looks bad name.
> > 
> > This patch renames for_each_cpu() as for_each_possible_cpu().
> > 
> > I also wrote patches to replace all for_each_cpu with for_each_possible_cpu.
> > please confirm....
> > 
> > BTW, when HOTPLUC_CPU is not suppoted, using for_each_possible_cpu()
> > should be avoided, I think.
> > 
> > all patches are against 2.6.16-rc6-mm1.
> > 
> 
> for_each_cpu() effectively is for_each_possible_cpu() as far as
> generic code is concerned. In other words, nobody would ever expect
> for_each_cpu to return an _impossible_ CPU, thus you are just
> adding a redundant element to the name.

We've had various screwups and confusions with these things.  I think the
new naming is good - it makes developers _think_ before they use it. 
Instead of "I want to touch all the CPUs, gee that looks right" they'll
have to stop and decide whether they want to access the online, possible or
present ones and then they'll (hopefully) have a little think about what
happens when CPUs migrate between those states.

