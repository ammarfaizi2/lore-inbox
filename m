Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTILVGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTILVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:06:48 -0400
Received: from hockin.org ([66.35.79.110]:12806 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261899AbTILVGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:06:46 -0400
Date: Fri, 12 Sep 2003 13:55:51 -0700
From: Tim Hockin <thockin@hockin.org>
To: Timothy Miller <miller@techsource.com>
Cc: root@chaos.analogic.com, James Clark <jimwclark@ntlworld.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030912135551.A23062@hockin.org>
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <Pine.LNX.4.53.0309041723090.9557@chaos> <3F5F8E90.4020701@techsource.com> <Pine.LNX.4.53.0309101640550.18999@chaos> <3F6231D7.6040702@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F6231D7.6040702@techsource.com>; from miller@techsource.com on Fri, Sep 12, 2003 at 04:51:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 04:51:35PM -0400, Timothy Miller wrote:
> Why?  Because there are some advantages to being able to say that this 
> one module can be dropped into any box running, for instance, 2.6.12 
> through 2.6.16, while the next module is used for 2.6.17 thru 2.6.22, etc.

There are a SLEW of options that make this hard.

CONFIG_SMP - spinlocks get compiled in or not

CONFIG_SPINLOCK_DEBUGGING - changes the size of a spinlock and the behavior
of spin_lock() and friend

All the HIGHMEM and various kernel/user split option - change the kernel
virtual addresses and offsets

And these are just a few.  The thing is, there isn't any way to catalog them
all, because at any point, someone can add a CONFIG_FOO_DEBUG which changes
the size of a struct foo and foo_op().  Then any module which uses a foo has
to ALSO have FOO_DEBUG on.  Modules and kernels must match up on ALL the
options (or at least, all the ones that cross the kernel-module boundary).

This actually bit me just last week.  I turn on spinlock debugging, and a
module Oopses.  I didn't recompile modules.

It sucks.  I agree.  Maybe there is an elegant way to checksum each
functional interface and each datatype and typedef and each argument to each
funtion and make it such that IFF they are all the same, the module will
load.  It's just not pretty.

-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

