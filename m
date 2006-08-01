Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWHAJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWHAJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWHAJKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:10:25 -0400
Received: from dea.vocord.ru ([217.67.177.50]:28587 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1751372AbWHAJKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:10:22 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: [take2 0/4] kevent: introduction.
In-Reply-To: <20060731103322.GA1898@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Tue, 1 Aug 2006 13:34:04 +0400
Message-Id: <11544248443344@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I send this patchset for comments and review, it still contains AIO and 
aio_sendfile() implementation on top of get_block() abstraction, which was
decided to postpone for a while (it is simpler right now to generate patchset as a whole,
when kevent will be ready for merge, I will generate patchset without AIO stuff).
It does not contain mapped buffer implementation, since it's design is not 100% 
completed, I will present that implementation in the third patchset.

Changes from previous patchset:
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


