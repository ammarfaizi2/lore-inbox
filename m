Return-Path: <linux-kernel-owner+w=401wt.eu-S932837AbWLaFTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbWLaFTo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 00:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWLaFTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 00:19:44 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40324
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932805AbWLaFTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 00:19:42 -0500
Date: Sat, 30 Dec 2006 21:19:41 -0800 (PST)
Message-Id: <20061230.211941.74748799.davem@davemloft.net>
To: wmb@firmworks.com
Cc: devel@laptop.org, linux-kernel@vger.kernel.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <459714A6.4000406@firmworks.com>
References: <459714A6.4000406@firmworks.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Bradley <wmb@firmworks.com>
Date: Sat, 30 Dec 2006 15:38:46 -1000

> Request for comments.
> 
> This patch creates a virtual filesystem that represents an Open Firmware
> device tree.  It has been tested on an OLPC x86 system, but the code is
> not processor-specific (apart from its current location under arch/i386).
> 
> It requires an Open Firmware implementation that can stay resident during
> Linux startup.
> 
> It is similar in some respect to fs/proc/proc_devtree.c , but does not
> use procfs, nor does it require an intermediate layer of code to
> create a flattened representation of the device tree.
> 
> The patch applies cleanly against the current version of
> git://dev.laptop.org/olpc-2.6 . (commit 5b9429be6056864b938ff6f39e5df3cecbbfcf4b).
> 
> Please cc me (Mitch Bradley <wmb@firmworks.com>) on comments.

Can we please not have N different interfaces to the open-firmware
calls so that perhaps powerpc and Sparc have a chance of using this
code too?

On sparc and powerpc, we even build an in-kernel data structure of the
entire open-firmware device tree that code like your's could use if
you make a simple setup layer for i386 as well.  We have interfaces for
modifying property values at run time too.

I would strongly suggest looking at things like
arch/{sparc,sparc64,powerpc}/kernel/prom.c and
include/asm-{sparc,sparc64,powerpc}/prom.h and
arch/{sparc,sparc64,powerpc}/kernel/of_device.c and
include/asm-{sparc,sparc64,powerpc}/of_device.h
since we've already invested a lot of thought and
infrastructure into providing interfaces to this information
on powerpc and the two sparc platforms.

Thanks.
