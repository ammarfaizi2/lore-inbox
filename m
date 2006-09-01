Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWIAEiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWIAEiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWIAEiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:38:12 -0400
Received: from ns.suse.de ([195.135.220.2]:56025 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932090AbWIAEiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:11 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:02 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 000 of 19] knfsd: lockd improvements
Message-ID: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following 19 patches are reviewed and revised versions of
some of a series of patches that Olaf Kirch posted to the
nfs list a few weeks ago.

They are suitable for 2.6.19.

They have been in the SuSE kernel (in a few different forms)
for quite some time and so have received a fair amount of testing,
though some of the code here is inevitably quite new (it needs
to be just to keep up with the ever-changing kernel ;-)

Apart from a few issues that I have posted about on the 
nfs list, the only changes I have made are enhancing a few
change logs, modifying a couple of comments, removing some dead code,
and adding the odd module parameter to parallel a new sysctl.

This set does *not* include the in-kernel implementation of statd that
came at the end of Olaf's series.  I think that is a big enough change
that it deserves a separate posting, and I haven't finished my review
of it yet anyway :-)

The main item of functionality provided by this set of patches
it to enable lock to identify peer by name instead of by IP address.
This can be important for multi-homed machines.  This is an
option only and must be explicitly selected by a sysctl or
module parameter.  The default is to use IP addresses, which
is generally safer if no multi-homed hosts are present.

This functionality is spread over several patches (there is a fair
bit of infrastructure needed) and there are a lot of clean-ups and
a few minor bug fixes as well.

This patch set compiles and passes basic locking tests (both client
side and server side).
I haven't yet tested the various client-reboot and server-reboot
handling as they are a little harder to test.

If anyone out there is in a position to easily run the connectathon
locking tests on a kernel with these patches..... :-)

 [PATCH 001 of 19] knfsd: Hide use of lockd's h_monitored flag
 [PATCH 002 of 19] knfsd: Consolidate common code for statd->lockd notification
 [PATCH 003 of 19] knfsd: When looking up a lockd host, pass hostname & length
 [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
 [PATCH 005 of 19] knfsd: Misc minor fixes, indentation changes
 [PATCH 006 of 19] knfsd: lockd: Make nlm_host_rebooted use the nsm_handle
 [PATCH 007 of 19] knfsd: lockd: make the nsm upcalls use the nsm_handle
 [PATCH 008 of 19] knfsd: lockd: make the hash chains use a hlist_node
 [PATCH 009 of 19] knfsd: lockd: Change list of blocked list to list_node
 [PATCH 010 of 19] knfsd: Change nlm_file to use a hlist
 [PATCH 011 of 19] knfsd: lockd: make nlm_traverse_* more flexible
 [PATCH 012 of 19] knfsd: lockd: Add nlm_destroy_host
 [PATCH 013 of 19] knfsd: Simplify nlmsvc_invalidate_all
 [PATCH 014 of 19] knfsd: lockd: optionally use hostnames for identifying peers
 [PATCH 015 of 19] knfsd: make nlmclnt_next_cookie SMP safe
 [PATCH 016 of 19] knfsd: match GRANTED_RES replies using cookies
 [PATCH 017 of 19] knfsd: Export nsm_local_state to user space via sysctl
 [PATCH 018 of 19] knfsd: lockd: fix use of h_nextrebind
 [PATCH 019 of 19] knfsd: Register all RPC programs with portmapper by default
