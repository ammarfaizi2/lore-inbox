Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVILM1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVILM1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVILM1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:27:10 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:26235 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750782AbVILM1J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:27:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eHeUo5pKZCuz27eTZ+NR7k/7tpTTap0Hz5eH0XlaMb1nT3fIRZotACd7T05YDcedIYyP2u7/dAgCnYdUN52Rfn1gKuRv0+8vBUlFTvidJ87gxHqEIhCISVU3CgMSJdMhRSLztrX7rpp254K5coQC3PCJNDkN9+S4ByaQ5CZ0Y2Q=
Message-ID: <2c1942a7050912052759c7f730@mail.gmail.com>
Date: Mon, 12 Sep 2005 15:27:00 +0300
From: Levent Serinol <lserinol@gmail.com>
Reply-To: lserinol@gmail.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] per process I/O statistics for userspace
Cc: Andrew Morton <akpm@osdl.org>, jlan@engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with following patch, userspace processes/utilities will be able to
access per process I/O statistics. for example, top like utilites can
use this information.


--- linux-2.6.13/fs/proc/array.c.org    2005-08-29 02:41:01.000000000 +0300
+++ linux-2.6.13/fs/proc/array.c        2005-09-12 10:22:55.000000000 +0300
@@ -408,7 +408,7 @@ static int do_task_stat(struct task_stru

        res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu %llu\n",
                task->pid,
                tcomm,
                state,
@@ -453,7 +453,9 @@ static int do_task_stat(struct task_stru
                task->exit_signal,
                task_cpu(task),
                task->rt_priority,
-               task->policy);
+               task->policy,
+               task->rchar,
+               task->wchar);
        if(mm)
                mmput(mm);
        return res;
--
Signed-off-by: Levent Serinol <lserinol@gmail.com>
