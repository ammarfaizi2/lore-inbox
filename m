Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757476AbWK2VGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476AbWK2VGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758072AbWK2VGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:06:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757476AbWK2VGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:06:18 -0500
Date: Wed, 29 Nov 2006 13:05:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: ego@in.ibm.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-Id: <20061129130556.d20c726e.akpm@osdl.org>
In-Reply-To: <20061129152404.GA7082@in.ibm.com>
References: <20061129152404.GA7082@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 20:54:04 +0530
Gautham R Shenoy <ego@in.ibm.com> wrote:

> Ok, so to cut the long story short, 
> - While changing governor from anything to
> ondemand, locks are taken in the following order
> 
> policy->lock ===> dbs_mutex ===> workqueue_mutex.
> 
> - While offlining a cpu, locks are taken in the following order
> 
> cpu_add_remove_lock ==> sched_hotcpu_mutex ==> workqueue_mutex ==
> ==> cache_chain_mutex ==> policy->lock.

What functions are taking all these locks?  (ie: the callpath?)
