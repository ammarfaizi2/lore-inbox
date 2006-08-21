Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWHUJ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWHUJ4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWHUJ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:56:54 -0400
Received: from dea.vocord.ru ([217.67.177.50]:32477 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1751823AbWHUJ4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:56:52 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [take12 0/3] kevent: Generic event handling mechanism.
In-Reply-To: <12345678912345.GA1898@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 21 Aug 2006 14:19:47 +0400
Message-Id: <11561555871530@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generic event handling mechanism.

Changes from 'take11' patchset:
 * include missing headers into patchset
 * some trivial code cleanups (use goto instead if if/else games and so on)
 * some whitespace cleanups
 * check for ready_callback() callback before main loop which should save us some ticks

Changes from 'take10' patchset:
 * removed non-existent prototypes
 * added helper function for kevent_registered_callbacks
 * fixed 80 lines comments issues
 * added shared between userspace and kernelspace header instead of embedd them in one
 * core restructuring to remove forward declarations
 * s o m e w h i t e s p a c e c o d y n g s t y l e c l e a n u p
 * use vm_insert_page() instead of remap_pfn_range()

Changes from 'take9' patchset:
 * fixed ->nopage method

Changes from 'take8' patchset:
 * fixed mmap release bug
 * use module_init() instead of late_initcall()
 * use better structures for timer notifications

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


