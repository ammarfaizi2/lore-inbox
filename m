Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUIMUEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUIMUEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIMUEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:04:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:36823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268919AbUIMUDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:03:38 -0400
Date: Mon, 13 Sep 2004 13:01:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-Id: <20040913130107.5230138b.akpm@osdl.org>
In-Reply-To: <4145BACE.8090005@sw.ru>
References: <20040913015003.5406abae.akpm@osdl.org>
	<4145BACE.8090005@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Hello Andrew,
> 
> Please replace patch next_thread-bug-fixes.patch in -mm5 tree with the 
> last diff-next_thread I sent to you.

I was planning on replacing it with Ingo's patch.

--- linux/fs/proc/array.c.orig
+++ linux/fs/proc/array.c
@@ -356,7 +356,7 @@ static int do_task_stat(struct task_stru
  			stime = task->signal->stime;
  		}
  	}
-	if (whole) {
+	if (whole && task->sighand) {

Is there some reason why your patch is better?  If so, please do a full
resend.

> And it looks like thread loop in do_task_stat() doesn't require siglock 
> lock, so you can add the patch attached to reduce lock area.

hm, OK.
