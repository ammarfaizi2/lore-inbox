Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUAAXcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAAXcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:32:06 -0500
Received: from dp.samba.org ([66.70.73.150]:3544 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261807AbUAAXcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:32:04 -0500
Date: Fri, 2 Jan 2004 10:28:15 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: davidm@napali.hpl.hp.com
Subject: FIXADDR_USER_* may not be constant
Message-ID: <20040101232815.GQ28023@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Another patch made it in that assumes FIXADDR_USER_* is constant:

> [PATCH] Put fixmaps into /proc/pid/maps via a pseudo-vma
> 
> From: David Mosberger <davidm@napali.hpl.hp.com>
> 
> This patch makes /proc/PID/maps report the range from FIXADDR_USER_START to
> FIXADDR_USER_END as a final pseudo-vma.  This is consistent with the notion
> that reading /proc/PID/maps tells you about every page containing data that
> the process can in fact access, and with things such as ptrace allowing
> access to this memory.  Without this, userland tools that want to look at all
> of a process's accessible pages need special-case knowledge about things such
> as the vsyscall DSO page.  With this change, existing code that iterates over
> the /proc/PID/maps lines will cover those pages like any other.  For example,
> this lets gdb's "gcore" command synthesize a core file from a live process
> that contains the vsyscall DSO page as a real core dump would, using its
> existing generic iterator code and no new special cases.

On ppc64 I want the 32bit and 64bit FIXADDR area to be at different
places. It would seem ia64 have the same problem supporting x86 properly.

Anton
