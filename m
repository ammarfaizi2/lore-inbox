Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSIRP7q>; Wed, 18 Sep 2002 11:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSIRP7q>; Wed, 18 Sep 2002 11:59:46 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:36597 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267176AbSIRP7p>; Wed, 18 Sep 2002 11:59:45 -0400
Date: Wed, 18 Sep 2002 12:04:47 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async
Message-ID: <20020918120447.F6398@redhat.com>
References: <20020918075103.B6143@redhat.com> <200209181558.g8IFwNp14249@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209181558.g8IFwNp14249@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Sep 18, 2002 at 08:58:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 08:58:22AM -0700, Badari Pulavarty wrote:
> Thanks for looking at the patch. Patch needed few cleanups to get it
> working. Here is the status so far..
> 
> 1) I tested synchronous raw read/write. They perform almost same as
>    without this patch. I am looking at why I can't match the performance.
>    (I get 380MB/sec on 40 dd's on 40 disks without this patch.
>     I get 350MB/sec with this patch).

Hmm, we should try to improve that.  Have you tried profiling a long run?

> 2) wait_on_sync_kiocb() needed blk_run_queues() to make regular read/
>    write perform well.

That should be somewhat conditional, but for now it sounds like the right 
thing to do.

> 3) I am testing aio read/writes. I am using libaio.0.3.92. 
>    When I try aio_read/aio_write on raw device, I am get OOPS.
>    Can I use libaio.0.3.92 on 2.5 ? Are there any interface
>    changes I need to worry  between 2.4 and 2.5 ?

libaio 0.3.92 should work on 2.5.  Could you send me a copy of the 
decoded Oops?

		-ben
-- 
GMS rules.
