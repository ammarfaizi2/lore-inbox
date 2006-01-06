Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWAFVwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWAFVwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWAFVvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:51:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20371 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751948AbWAFVvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:51:23 -0500
Subject: [patch 2/4] fix input layer f_ops abuse
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1136583937.2940.90.camel@laptopd505.fenrus.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 22:47:53 +0100
Message-Id: <1136584073.2940.95.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

The input layer has an assignment to a live ->fops, just after creating the
fops as a duplicate of another one. Just move this assignment a few lines up to avoid
the race and the assignment to a live fops

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15/drivers/input/input.c
===================================================================
--- linux-2.6.15.orig/drivers/input/input.c
+++ linux-2.6.15/drivers/input/input.c
@@ -478,8 +478,8 @@ static int __init input_proc_init(void)
 
 	entry->owner = THIS_MODULE;
 	input_fileops = *entry->proc_fops;
+	input_fileops.poll = input_devices_poll;
 	entry->proc_fops = &input_fileops;
-	entry->proc_fops->poll = input_devices_poll;
 
 	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
 	if (!entry)


