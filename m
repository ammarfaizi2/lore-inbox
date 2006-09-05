Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWIECXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWIECXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWIECXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:23:00 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25997 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965092AbWIECXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:23:00 -0400
Date: Tue, 5 Sep 2006 11:26:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       saito.tadashi@soft.fujitsu.com, ak@suse.de, oleg@tv-sign.ru,
       jdelvare@suse.de
Subject: Re: [PATCH] proc: readdir race fix.
Message-Id: <20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 17:13:10 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:
Hi, Hit OOM-Killer, because of memory leak of task struct.

patch is attached.
-Kame

task struct should be put always.

 fs/proc/base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-psfix/fs/proc/base.c
===================================================================
--- linux-2.6.18-psfix.orig/fs/proc/base.c	2006-09-05 10:42:40.000000000 +0900
+++ linux-2.6.18-psfix/fs/proc/base.c	2006-09-05 11:11:42.000000000 +0900
@@ -2193,8 +2193,8 @@
 		filp->f_pos = tgid + TGID_OFFSET;
 		len = snprintf(buf, sizeof(buf), "%d", tgid);
 		ino = fake_ino(tgid, PROC_TGID_INO);
+		put_task_struct(task);
 		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
-			put_task_struct(task);
 			goto out;
 		}
 	}

