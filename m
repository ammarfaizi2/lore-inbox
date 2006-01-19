Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWASFkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWASFkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWASFka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:40:30 -0500
Received: from main.gmane.org ([80.91.229.2]:8900 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932542AbWASFka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:40:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed Swierk <eswierk@cs.stanford.edu>
Subject: VFS: file-max limit reached when running on a virtual machine
Date: Thu, 19 Jan 2006 04:19:24 +0000 (UTC)
Message-ID: <loom.20060119T045624-92@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 209.3.10.88 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051201 Fedora/1.5-1.1.fc4.nr Firefox/1.5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the error "VFS: file-max limit 50905 reached" on kernels 2.6.14 and
2.6.15, running on a qemu virtual machine configured with 512 MB of memory.  The
error occurs when I build a relatively large C++ program (the Boost library) on
the VM (which is otherwise idle).  It does not occur on kernels 2.6.11 or 2.6.13.

I understand that changes have been made recently to the way the kernel manages
file descriptors in order to improve real-time performance.

A thread back in October discussing these changes (subject: "VFS: file-max limit
50044 reached") seems to indicate that bad things can happen if certain
callbacks don't get called at regular intervals.  This situation seems quite
likely in a virtual machine environment where the frequency of timer interrupts
might vary by orders of magnitude depending on the workload of the host machine.

I have attempted a few workarounds, to no avail:

* increasing file-max (echo 100000 >/proc/sys/fs/file-max)
* setting clock=pit kernel parameter
* setting rcupdate.maxbatch=1000000 kernel parameter

Is there some other way to make the kernel less sensitive to ill-behaved
hardware timers, as it was pre-2.6.14, assuming that I am willing to sacrifice
real-time performance?

Any help would be appreciated.


