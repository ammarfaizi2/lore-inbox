Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVHNM4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVHNM4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVHNM4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:56:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12468 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932517AbVHNM4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:56:35 -0400
Date: Sun, 14 Aug 2005 13:56:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Samer Sarhan <samersarhan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ahmed Mohamed Tarek <ahmadtarek@gmail.com>
Subject: Re: Changing thread_info->task, does it harm?
Message-ID: <20050814125634.GA18884@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Samer Sarhan <samersarhan@gmail.com>, linux-kernel@vger.kernel.org,
	Ahmed Mohamed Tarek <ahmadtarek@gmail.com>
References: <f03ab5ae05081405411da7f70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f03ab5ae05081405411da7f70@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 03:41:49PM +0300, Samer Sarhan wrote:
> Hi,
> I had a design problem of a Linux module (Linux 2.6.11) that lead me to do this:
> 
> int work_fn(void* data);
> task_t my_task;
> task_t* kthread = kthread_create(work_fn, NULL, "Task 1");
> // assume kthread create was successfully...
> my_task = *kthread;
> // change what current maceo points to...
> kthread->thread_info->task = &my_task;
> ...
> ...
> wake_up_process(&my_task);
> ...
> ..
> 
> well... is it dangerous to change what current macro points to through
> changing thread_info->task?

Yes.  It's totally broken.

