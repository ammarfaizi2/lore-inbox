Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWBVR4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWBVR4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWBVR4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:56:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12207 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161164AbWBVR4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:56:12 -0500
Date: Wed, 22 Feb 2006 17:56:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Yu <cyu021@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel thread removal
Message-ID: <20060222175610.GB21080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Yu <cyu021@gmail.com>, linux-kernel@vger.kernel.org
References: <60bb95410602220900n440564d7xb459d47c8ca30997@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bb95410602220900n440564d7xb459d47c8ca30997@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 01:00:34AM +0800, James Yu wrote:
> How do I remove a kernel thread in kernel mode ?
> I write a C-function in one of the Linux source files and create a
> kernel thread by invoking kernel_thread() to run the function, like:
> "kernel_thread(a1, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);"
> Function a1 simply invokes printk() to output some message on console.
> I invoke do_exit(0); at the end of a1, but a1's task_struct still
> exists in in task_struct list after its execution.
> How do I remove it a1's task_struct upon its completion? I thought
> explicitly invoke do_exit() ensures the removal of task_struct?

Please use the kthread_ api.  See include/linux/kthread.h and kernel/kthread.c
for details, or grep for kthread_ to find users.
