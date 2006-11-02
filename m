Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWKBRsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWKBRsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWKBRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:48:50 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:27601 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1750837AbWKBRst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:48:49 -0500
Date: Thu, 2 Nov 2006 20:48:28 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Graf <tgraf@suug.ch>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix Documentation/accounting/getdelays.c buf size
Message-ID: <20061102174828.GA151@oleg>
References: <20061101182512.GA444@oleg> <45490402.1090706@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45490402.1090706@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

getdelays reports a "fatal reply error, errno 258". We don't have enough room
for multi-threaded exit (PID + TGID).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/Documentation/accounting/getdelays.c~	2006-10-22 18:23:57.000000000 +0400
+++ STATS/Documentation/accounting/getdelays.c	2006-11-02 20:25:22.000000000 +0300
@@ -49,7 +49,7 @@ __u64 stime, utime;
 	}
 
 /* Maximum size of response requested or message sent */
-#define MAX_MSG_SIZE	256
+#define MAX_MSG_SIZE	1024
 /* Maximum number of cpus expected to be specified in a cpumask */
 #define MAX_CPUS	32
 /* Maximum length of pathname to log file */

