Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWB0WmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWB0WmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWB0Wb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:27 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52608 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751760AbWB0WbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:06 -0500
Message-Id: <20060227223350.609924000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Andi Kleen <ak@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/39] [PATCH] sys_mbind sanity checking
Content-Disposition: inline; filename=sys_mbind-sanity-checking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Make sure maxnodes is safe size before calculating nlongs in
get_nodes().

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
[chrisw: fix units, pointed out by Andi]
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 mm/mempolicy.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.15.4.orig/mm/mempolicy.c
+++ linux-2.6.15.4/mm/mempolicy.c
@@ -524,6 +524,8 @@ static int get_nodes(nodemask_t *nodes, 
 	nodes_clear(*nodes);
 	if (maxnode == 0 || !nmask)
 		return 0;
+	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
+		return -EINVAL;
 
 	nlongs = BITS_TO_LONGS(maxnode);
 	if ((maxnode % BITS_PER_LONG) == 0)

--
