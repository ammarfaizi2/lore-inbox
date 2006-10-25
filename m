Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422865AbWJYB4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422865AbWJYB4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 21:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWJYB4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 21:56:05 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:24503 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1422865AbWJYB4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 21:56:02 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 24 Oct 2006 21:54:34 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: so what's so special about sema_init() for alpha?
Message-ID: <Pine.LNX.4.64.0610242150460.28319@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i'm still curious as to why the implementation for sema_init() for
the alpha can't be simplified as (allegedly) could all of the other
architecture sema_init() calls.

  the relevant code from that semaphore.h is:

===========
static inline void sema_init(struct semaphore *sem, int val)
{
        /*
         * Logically,
         *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
         * except that gcc produces better initializing by parts yet.
         */

        atomic_set(&sem->count, val);
        init_waitqueue_head(&sem->wait);
}
============

  ok, so what means "produces better initializing"?  would a direct
call to __SEMAPHORE_INITIALIZER() work or not?  i'm just curious.  if
it really makes a difference in this one case, i can always resubmit a
patch that simplifies all of the other cases except for this one.

rday
