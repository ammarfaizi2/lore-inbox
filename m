Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTEZXVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTEZXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:21:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15824
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262298AbTEZXVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:21:33 -0400
Date: Tue, 27 May 2003 01:34:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: davem@redhat.com, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030526233446.GZ3767@dualathlon.random>
References: <60830000.1053575867@[10.10.2.4]> <Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com> <20030522.154410.104047403.davem@redhat.com> <20030526222406.GU3767@dualathlon.random> <20030526162616.6ceacaba.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526162616.6ceacaba.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 04:26:16PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  	if (IRQ_ALLOWED(phys_id, allowed_mask) && idle_cpu(phys_id))
> >  		return cpu;
> 
> How hard would it be to make this HT-aware?
> 
> 	idle_cpu(phys_id) && idle_cpu_siblings(phys_id)
> 
> or whatever.

yeah! that was the obvious next step. as fast path the additional && is
sure good. Maybe that's enough after all, and we might search only for
fully idle cpus, however I wouldn't dislike to search for a fallback
(partially) logical idle cpu if none physical cpu is (fully) idle.

Andrea
