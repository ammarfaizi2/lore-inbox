Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVDVE4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVDVE4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVDVE4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 00:56:34 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6892 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261945AbVDVE4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 00:56:32 -0400
Subject: Re: [patch] inotify for 2.6.12-rc3.
From: Robert Love <rml@novell.com>
To: linux-kernel@vger.kernel.org
Cc: Mr Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <1114060434.6913.26.camel@jenny.boston.ximian.com>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 00:57:14 -0400
Message-Id: <1114145834.6973.97.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 01:13 -0400, Robert Love wrote:

> Live from linux.conf.au, below is inotify against 2.6.12-rc3.

Mark the open inotify device as nonseekable, so lseek() and such do not
work.

Signed-off-by: Robert Love <rml@novell.com>

 fs/inotify.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urN linux-2.6.12-rc3-inotify/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.12-rc3-inotify/fs/inotify.c	2005-04-22 00:54:25.000000000 -0400
+++ linux/fs/inotify.c	2005-04-22 00:50:36.000000000 -0400
@@ -743,6 +743,8 @@
 
 	file->private_data = dev;
 
+	nonseekable_open(inode, file);
+
 	return 0;
 out_err:
 	free_uid(user);


