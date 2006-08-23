Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbWHWWmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWHWWmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWHWWmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:42:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47766 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965266AbWHWWmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:42:32 -0400
Date: Wed, 23 Aug 2006 15:39:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: akpm@osdl.org, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060823153952.066e9a58.pj@sgi.com>
In-Reply-To: <20060823221114.GF11309@localdomain>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060822050401.GB11309@localdomain>
	<20060821221437.255808fa.pj@sgi.com>
	<20060823221114.GF11309@localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> How about this? 

The code likely works, and the locking seems ok at first blush.
And this patch seems to match just what I asked for ;).

But the more I think about this, the less I like this direction.

Your patch, and what I initially asked for, impose a policy and create
a side affect.  When you bring a cpu online, the top cpuset changes as
a side affect, in order to impose a policy that the top cpuset tracks
what is online.

The kernel should avoid such side affects and avoid imposing policy.

It should be user code that imposes the policy that the top cpuset
tracks what is online.

The kernel gets things going with reasonable basic defaults at system
boot, then adapts to whatever user space mandates from then on.

Kernels should provide generic, orthogonal mechanisms.

Let user space figure out what it wants to do with them.

It is not a kernel bug that the top cpuset doesn't track what is
online.  It would be a kernel bug if the top cpuset didn't allow just
exactly whatever cpus the user space code told it to allow.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
