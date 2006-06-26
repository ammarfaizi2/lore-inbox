Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932970AbWFZTib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbWFZTib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbWFZTib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:38:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932971AbWFZTia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:38:30 -0400
Date: Mon, 26 Jun 2006 12:38:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay accounting taskstats interface send tgid
 once
Message-Id: <20060626123819.b5b9a156.akpm@osdl.org>
In-Reply-To: <44A02FB0.6000505@sgi.com>
References: <44A02331.8020903@watson.ibm.com>
	<44A02FB0.6000505@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 12:04:16 -0700
Jay Lan <jlan@sgi.com> wrote:

> Is this patch supposed to go on top of all other patches? Or is it
> supposed to replace any? I had failure applying this patch on top
> of all previously applied.

It would have got tangled up with the task-watchers patches.

ahem.  Documentation/SubmitChecklist, item 2:

In file included from kernel/exit.c:29:
include/linux/taskstats_kern.h: In function 'taskstats_exit_send':
include/linux/taskstats_kern.h:80: error: parameter name omitted
In file included from include/linux/delayacct.h:21,
                 from kernel/fork.c:47:
include/linux/taskstats_kern.h: In function 'taskstats_exit_send':
include/linux/taskstats_kern.h:80: error: parameter name omitted
make[1]: *** [kernel/exit.o] Error 1
make: *** [kernel/exit.o] Error 2
make: *** Waiting for unfinished jobs....
make[1]: *** [kernel/fork.o] Error 1
make: *** [kernel/fork.o] Error 2

diff -puN include/linux/taskstats_kern.h~delay-accounting-taskstats-interface-send-tgid-once-fixes include/linux/taskstats_kern.h
--- a/include/linux/taskstats_kern.h~delay-accounting-taskstats-interface-send-tgid-once-fixes
+++ a/include/linux/taskstats_kern.h
@@ -77,7 +77,8 @@ static inline void taskstats_exit_alloc(
 static inline void taskstats_exit_free(struct taskstats *ptidstats)
 {}
 static inline void taskstats_exit_send(struct task_struct *tsk,
-				       struct taskstats *tidstats, int)
+				       struct taskstats *tidstats,
+				       int group_dead)
 {}
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {}
_

http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 contains the current
-mm rollup up to and including this patch.  It's against 2.6.17.

