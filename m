Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbRGKHQL>; Wed, 11 Jul 2001 03:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbRGKHQC>; Wed, 11 Jul 2001 03:16:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47364 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267213AbRGKHPr>;
	Wed, 11 Jul 2001 03:15:47 -0400
Date: Wed, 11 Jul 2001 09:15:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Anderson <mike.anderson@us.ibm.com>
Cc: Dipankar Sarma <dipankar@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711091522.B17314@suse.de>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710160512.A25632@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10 2001, Mike Anderson wrote:
> The call to do_aic7xxx_isr appears that you are running the aic7xxx_old.c
> code. This driver is using the io_request_lock to protect internal data.
> The newer aic driver has its own lock. This is related to previous
> comments by Jens and Eric about lower level use of this lock.

Yes

>  I would like to know why the request_freelist is going empty? Having

Well, it's a limited resource so it's bound to go empty when under load.
In fact, if you have plenty of RAM this is what will end up starting I/O
on the queued buffers. With the batch freeing of request slots, this is
ok.

>  __get_request_wait being called alot would appear to be not optimal.

?? Care to explain your reasoning behind this statement.

-- 
Jens Axboe

