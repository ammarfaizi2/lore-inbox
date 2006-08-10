Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWHJMNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWHJMNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWHJMNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:13:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:47316 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1161200AbWHJMNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:13:38 -0400
Date: Thu, 10 Aug 2006 16:12:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: [take7 0/1] kevent: generic event handling mechanism.
Message-ID: <20060810121250.GA28665@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru> <11551105602734@2ka.mipt.ru> <20060809152127.481fb346.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060809152127.481fb346.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 10 Aug 2006 16:12:51 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Generic event handling mechanism.

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
 * fully removed AIO stuff from patchset

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



-- 
	Evgeniy Polyakov
