Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWHCAZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWHCAZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWHCAZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:51 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:44505 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750872AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:10 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/8] Basic infrastructure patches for a paravirtualized kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This series of patches lays the basic ground work for the
paravirtualized kernel patches coming later on.  I think this lot is
ready for the rough-and-tumble world of the -mm tree.

The main change from the last posting is that all the page-table
related patches have been moved out, and will be posted separately.

Also, the off-by-one in reserving the top of address space has been
fixed.

For the most part, these patches do nothing or very little.  The
patches should be self explanatory, but the overview is:

Helper functions for later use:
	2/8: Implement always-locked bit ops...
	8/8: Put .note.* sections into a PT_NOTE segment in vmlinux

Cleanups:
	1/8: Remove locally-defined ldt structure in favour of standard type
	3/8: Allow a kernel to not be in ring 0
	5/8: Roll all the cpuid asm into one __cpuid call

Hooks:
	4/8: Replace sensitive instructions with macros
	6/8: Make __FIXADDR_TOP variable to allow it to make space...
	7/8: Add a bootparameter to reserve high linear address...

8/8 "Put .note.* sections into a PT_NOTE segment in vmlinux" is mostly
here to shake out problems early.  It slightly changes the way the
vmlinux image is linked together, and it uses the somewhat esoteric
PHDRS command in vmlinux.lds.  I want to make sure that this doesn't
provoke any problems in the various binutils people are using.

Thanks,
	J

