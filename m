Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUIPQFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUIPQFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUIPQER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:04:17 -0400
Received: from sd291.sivit.org ([194.146.225.122]:172 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268239AbUIPP6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:58:46 -0400
Date: Thu, 16 Sep 2004 17:59:25 +0200
From: Stelian Pop <stelian@popies.net>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916155925.GJ3146@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Paul Jackson <pj@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <20040916104535.GA3146@crusoe.alcove-fr> <20040916065750.106fc170.pj@sgi.com> <20040916140936.GC3146@crusoe.alcove-fr> <20040916084549.4c2b59f5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916084549.4c2b59f5.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 08:45:49AM -0700, Paul Jackson wrote:

> > 'size' field instead of an 'end'
> 
>   The start, end, put, get names in that *.pdf might be a
>   bit quicker to read.
> 
>   I suspect that more readers would come away with the right
>   understanding, first time, if you struct was (taken roughly
>   from the *.pdf, using an 'end' one bigger than *.pdf uses):
> 
> 	/* kfifo is empty, not full, when head == tail */
> 	struct kfifo {
> 	    unsigned char *start;	/* [start, end) */
> 	    unsigned char *end;
> 	    unsigned char *head;	/* next input char goes in here */
> 	    unsigned char *tail;	/* next output char comes from here */
> 	    spinlock_t lock;
> 	};
> 
>   then your structure:
> 
> 	struct kfifo {
> 	    unsigned int head;
> 	    unsigned int tail;
> 	    unsigned int size;
> 	    spinlock_t lock;
> 	    unsigned char *buffer;
> 	};
> 
>   Differences include names, all pointers,

Except that this implementation requires 'head' and 'tail' to be
constrained to be between 'start' and 'end', adding an if test instead
of arithmetic unsigned int wrap. 

> ordering of struct elements,

I could place buffer at the beginning of the struct, indeed.

>   and comments. 

And commenting the fields is of course a very good idea.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
