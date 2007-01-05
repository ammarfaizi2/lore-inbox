Return-Path: <linux-kernel-owner+w=401wt.eu-S1422665AbXAESsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbXAESsH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbXAESrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:47:42 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34874 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422665AbXAESrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:41 -0500
Message-Id: <200701051842.l05IgDS5004612@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/9] UML - Use LIST_HEAD where possible
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of list_head declarations can be improved through the use of 
LIST_HEAD().

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/mconsole_kern.c |    2 +-
 arch/um/drivers/port_kern.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_kern.c	2007-01-01 13:27:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c	2007-01-01 13:30:00.000000000 -0500
@@ -371,7 +371,7 @@ struct unplugged_pages {
 
 static DECLARE_MUTEX(plug_mem_mutex);
 static unsigned long long unplugged_pages_count = 0;
-static struct list_head unplugged_pages = LIST_HEAD_INIT(unplugged_pages);
+static LIST_HEAD(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
 
 static int mem_config(char *str, char **error_out)
Index: linux-2.6.18-mm/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_kern.c	2007-01-01 13:29:38.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/port_kern.c	2007-01-01 13:30:00.000000000 -0500
@@ -130,7 +130,7 @@ static int port_accept(struct port_list 
 }
 
 static DECLARE_MUTEX(ports_sem);
-static struct list_head ports = LIST_HEAD_INIT(ports);
+static LIST_HEAD(ports);
 
 void port_work_proc(struct work_struct *unused)
 {

