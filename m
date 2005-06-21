Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVFUING@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVFUING (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVFUILi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:11:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261657AbVFUGzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:55:21 -0400
Date: Mon, 20 Jun 2005 23:54:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: -mm -> 2.6.13 merge status
Message-Id: <20050620235458.5b437274.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This summarises my current thinking on various patches which are presently
in -mm.  I cover large things and small-but-controversial things.  Anything
which isn't covered here (and that's a lot of material) is probably a "will
merge", unless it obviously isn't.

(If you reply to this email it would be a good idea to alter the Subject:
to reflect which feature you are discussing)



git-ocfs

    The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
    review.

sparsemem

    OK by me for a merge.  Need to poke arch maintainers first, check that
    they've looked at it sufficiently closely.

vm-early-zone-reclaim

    Needs some convincing benchmark numbers to back it up.  Otherwise OK.

avoiding-mmap-fragmentation

    Tricky.  Addresses vm area fragmentation issues due to recent
    optimisations to the free-area lookup code.  Will merge.

periodically-drain-non-local-pagesets

    Will merge

pcibus_to_node and users

    Will merge

CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ Kconfigurable.

    Will merge (will switch default to 1000 Hz later if that seems necessary)

dmi-*.patch

    Will merge.  I have a comment "The below break x440".  Maybe it got
    fixed.  We'll doubtless hear if not.

xen-*.patch

    These are little cleanups and abstractions which make a Xen merge
    easier.  May as well merge them.

CPU hotplug for x86 and x86_64

    Not really useful on current hardware, but these provide
    infrastructure which some power management patches need, and it seems
    sensible to make the reference architecture support hotplug.  Will merge.

swsusp-on-SMP

    Will merge.

cfq version 3

    Not sure.  Jens seems to be setting up a few git trees.  On hold.

RCUification of the key management code

    Don't know - dhowells seemed diffident last time we discussed this.

timers-fixes-improvements.patch

    SMP speedups for the core timer code.  It was bumpy, but this seems
    stable now.  Will merge.

kprobes-*

    Will merge

rapidio-*

    Will merge.

namespace*.patch

    Awaiting viro ack.

xtensa architecture

    Is xtensa now, or will it be in the future a sufficiently popular
    architecture to justify the cost of having this code in the tree?

    Heaven knows.  Will merge.

dlm-*.patch: Red Hat distributed lock manager

    Hard.  Right now it seems that no in-kernel projects will use this and
    only one out-of-kernel project will use it.  Shelve the problem until
    after Kernel Summit, where some light may be shed.

    Opinions are sought...

connector.patch

    Nice idea IMO, but there are still questions around the
    implementation.  More dialogue needed ;)

connector-add-a-fork-connector.patch

    OK, but needs connector.

inotify

    There are still concerns about the userspace API and internal
    implementation details.  More slogging needed.

pcmcia-*.patch

    Makes the pcmcia layer generate hotplug events and deprecates cardmgr.
    Will merge.

NUMA-aware slab allocator

    Seems stable now, but it needs some ifdef reduction work before
    merging, please.

CPU scheduler

    Will merge some of these patches.  We're still discussing which ones.

perfctr

    Not yet, but getting closer.  The PPC64 guys still need to sort out a
    few interface issues with Mikael.  We might be able to fit this into
    2.6.13 if people get a move on.

cachefs

    This is a ton of code which knows rather a lot about pagecache
    internals.  It allows the AFS client to cache file contents on a local
    blockdev.

    I don't think it's a justified addition for only AFS and I'd prefer to
    see it proven for NFS as well.

    Issues around add-page-becoming-writable-notification.patch need to
    be resolved.

cachefs-for-nfs

    A recent addition.  Needs review from NFS developers and considerably
    more testing.

    These things aren't looking likely for 2.6.13.

kexec and kdump

    I guess we should merge these.

    I'm still concerned that the various device shutdown problems will
    mean that the success rate for crashing kernels is not high enough for
    kdump to be considered a success.  In which case in six months time we'll
    hear rumours about vendors shipping wholly different crashdump
    implementations, which would be quite bad.

    But I think this has gone as far as it can go in -mm, so it's a bit of
    a punt.

reiser4

    Merge it, I guess.

    The patches still contain all the reiser4-specific namespace
    enhancements, only it is disabled, so it is effectively dead code.  Maybe
    we should ask that it actually be removed?

v9fs

    I'm not sure that this has a sufficiently high
    usefulness-to-maintenance-cost ratio.

fuse

    This is useful, but there are, AFAIK, two issues:

    - We're still deadlocked over some permission-checking hacks in there

    - It has an NFS server implementation which only works if the
      to-be-served file happens to be in dcache.

      It has been said that a userspace NFS server can be used to get
      full NFS server functionality with FUSE.  I think the half-assed kernel
      implementation should be done away with.

execute-in-place

    Will merge.  Have the embedded guys commented on the usefulness of
    this for execute-out-of-ROM?



