Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUIPP5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUIPP5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUIPP45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:56:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19937 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268130AbUIPPqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:46:20 -0400
Date: Thu, 16 Sep 2004 08:45:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Stelian Pop <stelian@popies.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040916084549.4c2b59f5.pj@sgi.com>
In-Reply-To: <20040916140936.GC3146@crusoe.alcove-fr>
References: <20040913135253.GA3118@crusoe.alcove-fr>
	<20040915153013.32e797c8.akpm@osdl.org>
	<20040916064320.GA9886@deep-space-9.dsnet>
	<20040916000438.46d91e94.akpm@osdl.org>
	<20040916104535.GA3146@crusoe.alcove-fr>
	<20040916065750.106fc170.pj@sgi.com>
	<20040916140936.GC3146@crusoe.alcove-fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you read my second patch ?

  Not closely enough ... ;).  Yes - your removal of 'len' does
  indeed seem to have addressed Andrews key initial comment.

> 'size' field instead of an 'end'

  The start, end, put, get names in that *.pdf might be a
  bit quicker to read.

  I suspect that more readers would come away with the right
  understanding, first time, if you struct was (taken roughly
  from the *.pdf, using an 'end' one bigger than *.pdf uses):

	/* kfifo is empty, not full, when head == tail */
	struct kfifo {
	    unsigned char *start;	/* [start, end) */
	    unsigned char *end;
	    unsigned char *head;	/* next input char goes in here */
	    unsigned char *tail;	/* next output char comes from here */
	    spinlock_t lock;
	};

  then your structure:

	struct kfifo {
	    unsigned int head;
	    unsigned int tail;
	    unsigned int size;
	    spinlock_t lock;
	    unsigned char *buffer;
	};

  Differences include names, all pointers, ordering of struct elements,
  and comments.  Perhaps some of these differences will look better to
  you than others.

> I wonder if replacing the kfifo_get/kfifo_put implementations with
> something like:

  Quite possibly.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
