Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUCSXgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUCSXgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:36:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:36559 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263148AbUCSXc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:26 -0500
Subject: Re: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <10797391312346@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:12 -0800
Message-Id: <10797391322645@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.5, 2004/03/19 14:07:09-08:00, willy@debian.org

[PATCH] PCI: insert_resource can succeed and return an error

If we start again, we can return an error even if we were successful.
Reset the result to 0 before beginning again.  Why don't we use a
tailcall here?


 kernel/resource.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/kernel/resource.c b/kernel/resource.c
--- a/kernel/resource.c	Fri Mar 19 15:21:16 2004
+++ b/kernel/resource.c	Fri Mar 19 15:21:16 2004
@@ -335,6 +335,7 @@
 	/* existing resource overlaps end of new resource */
 	if (next->end > new->end) {
 		parent = next;
+		result = 0;
 		goto begin;
 	}
 

