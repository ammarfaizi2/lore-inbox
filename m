Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282966AbRLMBCH>; Wed, 12 Dec 2001 20:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRLMBB4>; Wed, 12 Dec 2001 20:01:56 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:38314 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S282966AbRLMBBq>;
	Wed, 12 Dec 2001 20:01:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: "David C. Hansen" <haveblue@us.ibm.com>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
Date: Wed, 12 Dec 2001 17:01:43 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C17F8B2.6080700@us.ibm.com>
In-Reply-To: <3C17F8B2.6080700@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16EKFr-000305-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 12, 2001 16:39, David C. Hansen wrote:
> Let's assume that the BKL is not held here, at least over the whole
> thing.  First, what do we need to do to keep the module from getting
> unloaded after the request_module() in get_blkfops()?
>
> We can add a semaphore which must be acquired before a module can be
> unloaded, and hold it over the area where the module must not be
> unloaded.  We could replace the unload_lock spinlock with a semaphore,
> which I'll call it unload_sem here.  It would look something like this:

Why not use a read-write semaphore? The sections that require the module to 
stay resident use a read lock, and module unloading aquires a write lock. In 
addition to containing the evil, evil BKL, you might actually get a tangiable 
scalability gain out of it. 

-Ryan
