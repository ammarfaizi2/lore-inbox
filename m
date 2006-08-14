Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWHNF5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWHNF5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWHNF5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:57:11 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:8168 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1751650AbWHNF5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:57:09 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: [take8 0/2] kevent: Generic event handling mechanism.
In-Reply-To: <20060731103322.GA1898@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 14 Aug 2006 10:20:04 +0400
Message-Id: <11555364033186@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generic event handling mechanism.

Changes from 'take7' patchset:
 * new mmap interface (not tested, waiting for other changes to be acked)
	- use nopage() method to dynamically substitue pages
	- allocate new page for events only when new added kevent requres it
	- do not use ugly index dereferencing, use structure instead
	- reduced amount of data in the ring (id and flags), 
		maximum 12 pages on x86 per kevent fd

Changes from 'take6' patchset:
 * a lot of comments!
 * do not use list poisoning for detection of the fact, that entry is in the list
 * return number of ready kevents even if copy*user() fails
 * strict check for number of kevents in syscall
 * use ARRAY_SIZE for array size calculation
 * changed superblock magic number
 * use SLAB_PANIC instead of direct panic() call
 * changed -E* return values
 * a lot of small cleanups and indent fixes

Changes from 'take5' patchset:
 * removed compilation warnings about unused wariables when lockdep is not turned on
 * do not use internal socket structures, use appropriate (exported) wrappers instead
 * removed default 1 second timeout
 * removed AIO stuff from patchset

Changes from 'take4' patchset:
 * use miscdevice instead of chardevice
 * comments fixes

Changes from 'take3' patchset:
 * removed serializing mutex from kevent_user_wait()
 * moved storage list processing to RCU
 * removed lockdep screaming - all storage locks are initialized in the same function, so it was learned 
	to differentiate between various cases
 * remove kevent from storage if is marked as broken after callback
 * fixed a typo in mmaped buffer implementation which would end up in wrong index calcualtion 

Changes from 'take2' patchset:
 * split kevent_finish_user() to locked and unlocked variants
 * do not use KEVENT_STAT ifdefs, use inline functions instead
 * use array of callbacks of each type instead of each kevent callback initialization
 * changed name of ukevent guarding lock
 * use only one kevent lock in kevent_user for all hash buckets instead of per-bucket locks
 * do not use kevent_user_ctl structure instead provide needed arguments as syscall parameters
 * various indent cleanups
 * added optimisation, which is aimed to help when a lot of kevents are being copied from userspace
 * mapped buffer (initial) implementation (no userspace yet)

Changes from 'take1' patchset:
 - rebased against 2.6.18-git tree
 - removed ioctl controlling
 - added new syscall kevent_get_events(int fd, unsigned int min_nr, unsigned int max_nr,
			unsigned int timeout, void __user *buf, unsigned flags)
 - use old syscall kevent_ctl for creation/removing, modification and initial kevent 
	initialization
 - use mutuxes instead of semaphores
 - added file descriptor check and return error if provided descriptor does not match
	kevent file operations
 - various indent fixes
 - removed aio_sendfile() declarations.

Thank you.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>


