Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267063AbSIRPyH>; Wed, 18 Sep 2002 11:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267095AbSIRPyH>; Wed, 18 Sep 2002 11:54:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:48314 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267063AbSIRPyG>; Wed, 18 Sep 2002 11:54:06 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209181558.g8IFwNp14249@eng2.beaverton.ibm.com>
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Wed, 18 Sep 2002 08:58:22 -0700 (PDT)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
In-Reply-To: <20020918075103.B6143@redhat.com> from "Benjamin LaHaise" at Sep 18, 2002 06:51:03 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Sep 17, 2002 at 02:03:02PM -0700, Badari Pulavarty wrote:
> > Hi Ben,
> > 
> > Here is a 2.5.35 patch to make DIO async. Basically, DIO does not
> > wait for io completion. Waiting will be done at the higher level
> > (same way generic_file_read does).
> 
> This looks pretty good.  Andrew Morton has had a look over it too and 
> agrees that it should go in after a bit of testing.  Does someone want 
> to try comparing throughput of dio based aio vs normal read/write?  It 
> would be interesting to see what kind of an effect pipelining aios makes 
> and if there are any performance niggles we need to squash.  Cheer,
> 
> 		-ben

Thanks for looking at the patch. Patch needed few cleanups to get it
working. Here is the status so far..

1) I tested synchronous raw read/write. They perform almost same as
   without this patch. I am looking at why I can't match the performance.
   (I get 380MB/sec on 40 dd's on 40 disks without this patch.
    I get 350MB/sec with this patch).

2) wait_on_sync_kiocb() needed blk_run_queues() to make regular read/
   write perform well.

3) I am testing aio read/writes. I am using libaio.0.3.92. 
   When I try aio_read/aio_write on raw device, I am get OOPS.
   Can I use libaio.0.3.92 on 2.5 ? Are there any interface
   changes I need to worry  between 2.4 and 2.5 ?

Once I get aio read/writes working, I will provide you the performance
numbers.

Thanks,
Badari

