Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVDNR4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDNR4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDNR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:56:35 -0400
Received: from orb.pobox.com ([207.8.226.5]:49109 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261577AbVDNR41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:56:27 -0400
Date: Thu, 14 Apr 2005 12:56:23 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] generate hotplug events for cpu online
Message-ID: <20050414175623.GB12960@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We already do kobject_hotplug for cpu offline; this adds a
kobject_hotplug call for the online case.  This is being requested by
developers of an application which wants to be notified about both
kinds of events.


Signed-off-by: Nathan Lynch <ntl@pobox.com>


Index: linux-2.6.12-rc2-mm3/drivers/base/cpu.c
===================================================================
--- linux-2.6.12-rc2-mm3.orig/drivers/base/cpu.c	2005-03-02 01:37:53.000000000 -0600
+++ linux-2.6.12-rc2-mm3/drivers/base/cpu.c	2005-04-14 10:56:29.000000000 -0500
@@ -37,6 +37,8 @@ static ssize_t store_online(struct sys_d
 		break;
 	case '1':
 		ret = cpu_up(cpu->sysdev.id);
+		if (!ret)
+			kobject_hotplug(&dev->kobj, KOBJ_ONLINE);
 		break;
 	default:
 		ret = -EINVAL;
