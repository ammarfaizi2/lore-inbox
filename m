Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUHZTSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUHZTSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUHZTO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:14:29 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6109 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269369AbUHZTKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:10:45 -0400
Subject: ANNOUNCE: 2.6.9-rc1-mm1-mhp1
From: Dave Hansen <haveblue@us.ibm.com>
To: lhms <lhms-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093547430.2984.184.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 12:10:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh no, not another kernel tree!

I promise I won't make a regular habit of posting this to LKML, but I
figured I'd do it at least once just in case anybody here cares.  We
have most of our discussions on lhms-devel@lists.sourceforge.net

The main aim of this patch set (other than having the longest possible
version name) is to give the memory hotplug developers a common base to
work from.  It is hopefully split up in such a way that it is easy to
replace an implementation in the middle of the stack without disturbing
too much other stuff.

All of the A?-*.patch files are things that I hope to get merged in
the near future.  Some have been sent out for review already, some
haven't.  Review of or comments on anything in the set would be greatly
appreciated.  Please ignore the debugging patch as much as possible :)

The patches are here for now:
	http://sprucegoose.sr71.net/patches/
But, that's not permanent and may change at some time in the future. 

They're alphabetically applied, but there's also a series file.  

---------------------------

Changes since 2.6.8.1-mm3-mhp1:

merged into -mm:
        A0-virts_are_voidstar.patch
        A1-noalign-virt_to_page-args.patch
        A2-fetch_pgd_into_ul.patch
        A3-early_printk-cast-VGABASE.patch
        A4-include-page.h-virt_to_page.patch
        A5-sysenter-types.patch

New:
        C7-nonlinear-consts.patch
        K2-swap_cleanup
        K3-swap_mem_hotplug
        
K{2,3} are some of the first hooks in to the swap code to support memory
removal.  The first patch just moves some code around, and the second
one creates an special case of the inactive_list for pages under
removal.  These still need a bit of cleaning up, but they appear to do
some good.  Time will tell whether the swap code will be sufficient, or
we need a more drastic approach.  

On my 4G machine, I can boot with mem=2G, and add memory back after
booting.  For right now, this only works in 128MB sections, but to add
the memory from 2G up to 2G+128MB, you just do this:

	echo 0x80000000 > /sys/devices/system/memory/probe

You'll get hotplug events via /sbin/hotplug, and then you can

	echo online > /sys/devices/system/memory/memoryXX/status

to actually make the memory available.  You'll know what XX is because
of the hotplug events.  You can then do this:

	echo offline > /sys/devices/system/memory/memoryXX/status

But, that doesn't really do very much right now other than mark all the
pages in that particular memory section as slated for removal and trying
to allocate all of them. 

-- Dave

