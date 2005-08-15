Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVHOW5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVHOW5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVHOW5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:57:52 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:58380 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751095AbVHOW5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:57:52 -0400
Date: Mon, 15 Aug 2005 15:58:09 -0700
From: zach@vmware.com
Message-Id: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, zach@vmware.com
Subject: [PATCH 0/6] i386 virtualization patches, Set 3
X-OriginalArrivalTime: 15 Aug 2005 22:57:51.0272 (UTC) FILETIME=[C3690280:01C5A1EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This round attempts to conclude all of the LDT related cleanup with some
finally nice looking LDT code, fixes for the UML build, a bugfix for
really rather nasty kprobes problems, and the basic framework for an LDT
test suite.  It is really rather unfortunate that this code is so
difficult to test, even with DOSemu and Wine, there are still very nasty
corner cases here - anyone want an iret to 16-bit stack test?.

I was going to attempt to clean up the math-emu code to make it use the
nice new segment and descriptor table accessors, but it quickly became
apparent that this would be a long, tedious, error prone process that
would eventually result in the death of a large section of my brain.
In addition, it is not very fun to test this on the actual hardware it
is designed to run on (although I did manage to track down a 386 with
detachable i387 coprocessor, the owner is not sure it still boots).
Someday it would be nice to have an audit of this code; it appears to
be riddled with bugs relating to segmentation, for example it assumes
LDT segments on overrides, does not use the mm->context semaphore to
protect LDT access, and generally looks scarily out of date in both
function and appearance.

I also have a makeover for the pgtable.h code.  Splitting operations that
write hardware page tables into the sub-arch layer was very ugly,
hopefully this is a much cleaner approach.  There really must be a way
for a paravirtualized hypervisor to hook the page table updates, and this
appears to be the cleanest solution so far.

This patch set is based on 2.6.13-rc6 -mm1 broken out series.  It applies
and builds i386, x86_64, and um-i386 on 2.6.13-rc5.  I've tested PAE and
non-PAE SMP kernels and am working on an LDT test suite.  Depends on
the i386 cleanups, sub-arch movement, and LDT cleanups I've already sent
out.

--
Zachary Amsden <zach@vmware.com>
Whee!  Actually deliver the signal.
