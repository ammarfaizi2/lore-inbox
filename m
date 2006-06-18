Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWFRQ5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWFRQ5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFRQ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:57:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33470 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932250AbWFRQ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:57:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 18:57:03 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 0/6] ieee1394: nodemgr: misc API conversions
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44944D8A.6090808@s5r6.in-berlin.de>
Message-ID: <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.876) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches clean up and convert API usages in
ieee1394/nodemgr.c.  Parts of this patch series supersede the previously
posted variants of "[PATCH] kthread conversion: convert ieee1394 from
kernel_thread".

1/6 ieee1394: nodemgr: remove unnecessary includes
2/6 ieee1394: do not spawn a kernel_thread for user-initiated bus rescan
3/6 ieee1394: make module parameter ignore_drivers writable
4/6 ieee1394: nodemgr: switch to kthread API
5/6 ieee1394: nodemgr: replace reset semaphore
6/6 ieee1394: convert nodemgr_serialize semaphore to mutex

 drivers/ieee1394/nodemgr.c |  151 +++++++++++--------------------------
 1 files changed, 47 insertions(+), 104 deletions(-)

In case someone actually puts these patches to test and finds a lockup
or something more serious, please check if it isn't this older bug:
http://bugzilla.kernel.org/show_bug.cgi?id=6706
Two things which I could not test are behaviour on actual SMP machines
and the try_to_freeze() business.

Patch 3/6 is not an API conversion but is loosely related to patch 2/6.

After this patchset, all usages of the kernel_thread API are removed
from the ieee1394 subsystem.  Two usages of semaphores are replaced.
The following semaphores are still remaining in drivers/ieee1394:

dv1394.c:                video->sem       (simple mutex-type semaphore)
highlevel.c:             hl_drivers_sem   (RW semaphore)
ieee1394_transactions.c: tp->count        (counting semaphore)
nodemgr.c:               subsys.rwsem     (driver core's RW semaphores)
raw1394.c:               fi->complete_sem (completion semaphore)
-- 
Stefan Richter
-=====-=-==- -==- =--=-
http://arcgraph.de/sr/

