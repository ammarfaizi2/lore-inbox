Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVJFEkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVJFEkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 00:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVJFEkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 00:40:18 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:63938 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S1751222AbVJFEkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 00:40:16 -0400
Date: Thu, 6 Oct 2005 14:40:15 +1000
From: David McCullough <davidm@snapgear.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: dhowells@redhat.com
Subject: [PATCH] 2.6.13 - output of /proc/maps on nommu systems is incomplete
Message-ID: <20051006044015.GA31458@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Simple patch against 2.6.13 for /proc/maps on nommu systems.
Currently you do not get all the map entries because the start
function doesn't index into the list using the value of "pos".

Cheers,
Davidm

Signed-off-by: David McCullough <davidm@snapgear.com>

Index: fs/proc/nommu.c
===================================================================
RCS file: /cvs/sw/linux-2.6.x/fs/proc/nommu.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 nommu.c
--- fs/proc/nommu.c	3 Mar 2005 00:45:41 -0000	1.1.1.1
+++ fs/proc/nommu.c	6 Oct 2005 04:25:30 -0000
@@ -91,6 +91,7 @@ static void *nommu_vma_list_start(struct
 			next = _rb;
 			break;
 		}
+		pos--;
 	}
 
 	return next;
-- 
David McCullough, davidm@cyberguard.com.au, Custom Embedded Solutions + Security
Ph:+61 734352815 Fx:+61 738913630 http://www.uCdot.org http://www.cyberguard.com
