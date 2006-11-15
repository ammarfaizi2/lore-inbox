Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966031AbWKOHok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966031AbWKOHok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966049AbWKOHok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:44:40 -0500
Received: from brick.kernel.dk ([62.242.22.158]:56421 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S966031AbWKOHoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:44:39 -0500
Date: Wed, 15 Nov 2006 08:47:21 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: linux-aio@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       bcrl@kvack.org, zach.brown@oracle.com
Subject: Re: linux io_submit syscall duration
Message-ID: <20061115074720.GH23770@kernel.dk>
References: <5d96567b0611142339k23e78cc6u19b64052be5cd360@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d96567b0611142339k23e78cc6u19b64052be5cd360@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15 2006, Raz Ben-Jehuda(caro) wrote:
> Bnejamin hello.
> 
> My name is raz and i have encountered a problem with  io_submit.
> The maximum duration of a single io_submit operation when
> heavily stressing the system with large number of big (1MB) ios,
> reaches several hundereds ms.
> 
> I have been profiling it and it seems that the problem is the
> file->f_op->aio_read operation,
> a call that is made in fs/aio.c when coming from:
> sys_io_submit -->
>   io_submit_one -->
> 	  aio_run_iocb -->
>   		 *retry
> 
> 
> The test is initiating several hundered 1MB IOs over a single block device.
> 
> I understand that the assumption made was aio_read is asynchronous and no
> delay will occure, but isn't possible to do it in the workqueue context ?

This was discussed no more than a week ago on this list, please search the
archives for the thread.

-- 
Jens Axboe

