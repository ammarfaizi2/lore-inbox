Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269598AbUICJwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269598AbUICJwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUICJtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:49:16 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:21435 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S269618AbUICJqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:46:00 -0400
Subject: Deadlock with Promise Driver, still in 2.6.9-rc1
From: NM Lists <mlists@paris.monnet.biz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 03 Sep 2004 11:47:36 +0200
Message-Id: <1094204856.18563.7.camel@nicathlon.monnet.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has already been reported I think, but here it is again. In some
bugzilla somewhere this has been incorrectly reported as a software Raid
vs. Promise driver incompatibility; in fact, it appears to be a problem
when both SATA channels are being used at the same time (which obviously
happens a lot with raid!)

How to trigger it:

# cat /dev/sda > /dev/null &
# hdparm -t /dev/sdb &
# hdparm -t /dev/sda &

Now any disk access to either disks is blocked, and in my case, incoming
mail (using qmail) starts piling up processes, and this ends up in lock
up.



