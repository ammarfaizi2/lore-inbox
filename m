Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUEVREH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUEVREH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 13:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUEVREH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 13:04:07 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:12736 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261375AbUEVRED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 13:04:03 -0400
Subject: Expected sys_msync() behaviour?
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1085245436.610.23.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 22 May 2004 19:03:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at a bugzilla filed because of sys_msync() returning ok even if
you specify a addr + len that goes over bss section or MAP_PRIVATE's.

http://bugzilla.kernel.org/show_bug.cgi?id=2728
(my patch should return -ENOMEM instead of -EINVAL according
to specification link below).


This brings up a question on the expected behaviour of sys_msync().
Should it only sync a single vma? 

Should it traverse several vma's until the the ending address has been
reached? In that case it should skip anything not MAP_SHARED, but that
also makes the system call quite random as it doesn't sync a flat memory
region.

Personally I think that it should sync a single vma, or parts of it, not
search around or "accidently" touch other mappings which aren't
intended, this should be the work of the user space program.

So before syncing it should check that the region is backed by a
MAP_SHARED file which is writeable and then sync it, yes?

The Open Group Base Specifications Issue 6:
http://www.opengroup.org/onlinepubs/009695399/functions/msync.html

Alex

