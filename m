Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVIIIkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVIIIkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVIIIkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:40:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58059 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932541AbVIIIkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:40:20 -0400
Date: Fri, 9 Sep 2005 01:39:36 -0700
From: Paul Jackson <pj@sgi.com>
To: magnus.damm@gmail.com
Cc: kurosawa@valinux.co.jp, dino@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050909013936.468da5ba.pj@sgi.com>
In-Reply-To: <aec7e5c3050909005273a0d12b@mail.gmail.com>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	<20050908002323.181fd7d5.pj@sgi.com>
	<20050908081819.2EA4E70031@sv1.valinux.co.jp>
	<20050908050232.3681cf0c.pj@sgi.com>
	<20050909013804.1B64B70037@sv1.valinux.co.jp>
	<aec7e5c305090821126cea6b57@mail.gmail.com>
	<20050908225539.0bc1acf6.pj@sgi.com>
	<aec7e5c3050909005273a0d12b@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus wrote:
> Non-overlapping subsets of cpu or memory nodes basically mean that
> children of a cpuset only clear bits in the bitmap, never sets them.

X is a subset of Y if every element of X is also in Y.

My phrase "a subset of the CPUs" really just meant "some set of CPUs"
on the system.  A subset of all CPUs is a set of some CPUs, perhaps
empty, perhaps including them all, perhaps in between.

The phrase "non-overlapping" mean that the several subsets had no
overlap - no CPU was in more than one of the subsets.

Ditto ... for Memory Nodes.

To be honest, I don't think in terms of bits.  The bitmaps, cpumasks
and nodemasks are just ways of representing sets.  I also uses various
lists and arrays to represent sets of CPUs and sets of Memory Nodes,
depending on what's convenient.

My math background, before getting into computers, was in Set Theory.


> a place to store per-bit (node/cpu) guarantee count

I do not understand this snippet.


> I think one major problem is how the guarantee should be divided
> between all subcpusets that share one bit

That's why I said 'non-overlapping'.  That means no shared bits (no
shared CPUs or Memory Nodes).


> "resource control domains"

These were whatever sets of CPUs or Memory Nodes had resource
control functions.  Both Takahiro-san's subcpusets and my cpusets
with meter attributes were examples of such.  No doubt CKRM has
such too, though I've forgotten too much of CKRM to say what.


> This boolean file, do you mean one of your "meter" files or something
> else?

Look under /dev/cpuset (after mounting it: mount -t cpuset cpuset /dev/cpuset).
You will seem that some of the files, such as the files named:
	mem_exclusive
	cpu_exclusive
	notify_on_release

always contain either the string "0\n" or "1\n".  These are boolean files.
They are file representations of boolean values (True or False).

A cpuset with resource metering attributes needed:
 1) one boolean file, to mark that it had such metering attributes.
 2) several meter specific files, holding various parameter settings,
    such as what percentage of the CPUs allowed in this cpuset may
    be used by the tasks in this cpuset.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
