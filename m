Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbTA0X20>; Mon, 27 Jan 2003 18:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTA0X20>; Mon, 27 Jan 2003 18:28:26 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:29064
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S264625AbTA0X2Z>; Mon, 27 Jan 2003 18:28:25 -0500
Message-ID: <3E323EC8.10907@tupshin.com>
Date: Fri, 24 Jan 2003 23:37:44 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3-ac4 oops in kmem_cache_destroy
References: <20030125062513.GA10351@middle.of.nowhere>
In-Reply-To: <20030125062513.GA10351@middle.of.nowhere>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Widely reported...this previously posted (sorry don't remember who) 
patch fixes it for me and others.

-Tupshin


--- 2.4.21-pre3-ac4/kernel/fork.c       Mon Jan 13 18:56:12 2003
+++ linux/kernel/fork.c Sun Jan 19 13:39:37 2003
@@ -688,6 +688,8 @@
        p->lock_depth = -1;             /* -1 = no lock */
        p->start_time = jiffies;

+       INIT_LIST_HEAD(&p->local_pages);
+
        retval = -ENOMEM;
        /* copy all the process information */
        if (copy_files(clone_flags, p))


