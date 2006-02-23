Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWBWPyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWBWPyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWBWPyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:54:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52630 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751430AbWBWPyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:54:07 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/23] proc cleanup.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 08:52:59 -0700
Message-ID: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When working on pid namespaces I keep tripping over /proc.
It's hard coded inode numbers and the amount of cruft
accumulated over the years makes it hard to deal with.

So to put /proc out of my misery here is a series of patches that
removes the worst of the warts.

The first patch which introduces task_refs is used later to address
one of the worst faults how much low kernel memory it allows
an unprivileged process to pin.  There are other patches to cleanup
the permission checking, to cleanup how /proc interacts with the rest
of the kernel, and to patches to simply clean /proc up.

At least some of the cleans up go back to cruft that was introduced
in 2.2.  That was a challenge to track down and understand the
thinking at the time because even the historic git archive I have
doesn't go back that far :(

Ultimately the biggest cleanup is that this patchset removes 
the hard coded inode numbers from /proc.  There are still a few
theoretical issues about non-unique inode numbers but the /proc code
doesn't care, and it is no worse than the current situation with the
file descriptor inode numbers.  I would have loved to have made the
inode number the address of the inode data structure in the kernel but
I can't because on alpha __kernel_ino_t is an unsigned int!  Oh well,
the current situation keeps the inode numbers small and readable, and
32bit.

Eric
