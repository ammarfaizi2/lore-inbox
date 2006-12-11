Return-Path: <linux-kernel-owner+w=401wt.eu-S936938AbWLKQHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936938AbWLKQHG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936947AbWLKQHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:07:06 -0500
Received: from brick.kernel.dk ([62.242.22.158]:9598 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936938AbWLKQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:07:05 -0500
Date: Mon, 11 Dec 2006 17:08:17 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
Subject: Re: [PATCH] cfq: wrong sync writes detection
Message-ID: <20061211160817.GS4576@kernel.dk>
References: <200612111545.kBBFjJEl012709@vass.7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612111545.kBBFjJEl012709@vass.7ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11 2006, Vasily Tarasov wrote:
> CFQ I/O scheduler does the following actions to
> find out whether the request is sync:
> 
> rw = rq_data_dir(rq); => possible values for rw are 0 or 1
> 
> static inline pid_t cfq_queue_pid(struct task_struct *task, int rw)
> {
>         if (rw == READ || rw == WRITE_SYNC) => second condition is always false
>                 return task->pid;
> 
>         return CFQ_KEY_ASYNC;
> }
> 
> The following patch fixes the bug by adding sync parameter,
> wich is obtained through bio_sync macros.

Good catch! Applied.

-- 
Jens Axboe

