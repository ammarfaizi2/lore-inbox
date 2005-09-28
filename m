Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVI1Hxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVI1Hxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVI1Hxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:53:36 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:34227 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030210AbVI1Hxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:53:36 -0400
Date: Wed, 28 Sep 2005 16:53:31 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
In-Reply-To: <20050928000839.1d659bfb.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
	<20050928062146.6038E70041@sv1.valinux.co.jp>
	<20050928000839.1d659bfb.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050928075331.0408A70041@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 00:08:39 -0700
Jackson-san wrote:
> > If we split the cpus {2, 3} into {2} and {3} by creating CPUSET 2a 
> > and CPUSET 2b, the guarantee assigned to CPUSET 1a might not be
> > satisfied.  For example, the maximum cpu resource usage of tasks 
> > in CPUSET 2a should essentially be 50% because tasks in CPUSET 2a
> > can only use the half number of cpus. 
> 
> Ah, yes, this could be difficult and not worth doing.
> 
> It might help if I stated more of what I mean, which I didn't before.
> 
> I intended that all tasks in the combination of cpusets 1a, 2a, and 2b
> would collectively be allowed what ever percentage of cpu cycles the
> meter_cpu_* files in cpuset 1a prescribed.  I did not intend to suggest
> any particular balance between these tasks in 1a, 2a and 2b would be
> enforced.  In particular, I did not expect for anything like a 50%
> split between the tasks in 2a and 2b to be enforced.   For the purposes
> of your cpu controller, just treat the entire set of tasks in all
> three of these cpusets as one pool, governed by one meter_cpu_*
> setting, just as if all these tasks were in cpuset 1a, and as if
> cpusets 2a and 2b didn't exist.

This seems good for me.
I'd like to make sure that tasks in CPUSET 2a and CPUSET 2b actually
have the cpumask of CPUSET 1a.  Is this correct?

If it's correct, a small hack to cpuset_cpus_allowed() would only be 
needed to do this.

> This might be easier to do - I don't know.

This is quite easier.  Thanks for your clarifying the idea.

-- 
KUROSAWA, Takahiro
