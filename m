Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264974AbUFAK3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUFAK3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 06:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbUFAK3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 06:29:38 -0400
Received: from [213.146.154.40] ([213.146.154.40]:32735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264974AbUFAK3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 06:29:36 -0400
Date: Tue, 1 Jun 2004 11:29:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601102928.GA16718@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, mikpe@csd.uu.se,
	linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - merged perfctr.  No documentation though :(

+/* tid is the actual task/thread id (népid, stored as ->pid),
+   pid/tgid is that 2.6 thread group id crap (stored as ->tgid) */
+asmlinkage long sys_vperfctr_open(int tid, int creat)
+{
+       struct file *filp;
+       struct task_struct *tsk;
+       struct vperfctr *perfctr;
+       int err;
+       int fd;
+
+       if (!vperfctr_fs_init_done())
+               return -ENODEV;
+       filp = vperfctr_get_filp();
+       if (!filp)
+               return -ENOMEM;
+       err = fd = get_unused_fd();

This really, really screams "I want to be a special file", so the interface
still doesn't look okay.  Probably in /proc/pid. 
