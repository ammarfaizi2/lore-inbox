Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTDNQBR (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTDNQBR (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:01:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3230 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263518AbTDNQBQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:01:16 -0400
Date: Mon, 14 Apr 2003 09:15:08 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre7 ide request races
Message-ID: <20030414161508.GA1460@beaverton.ibm.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@digeo.com>, alan@lxorguk.ukuu.org.uk,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <20030414093418.GQ9776@suse.de> <20030414030751.7bf17b04.akpm@digeo.com> <20030414101747.GR9776@suse.de> <20030414032339.27079dd8.akpm@digeo.com> <20030414102723.GS9776@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414102723.GS9776@suse.de>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Mon, Apr 14 2003, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > How would that solve the problem? The request could be gone even before
> > > end_that_request_last() is run, that is the issue.
> > 
> > In that case I didn't understand your description of the bug even the tiniest
> > little bit.
> > 
> > That request is sitting in the kernel stack of some process which is sleeping
> > in wait_for_completion().  Hence it is safe memory until someone runs
> > complete() against the completion struct.
> 
> Sorry you are right, that should fix the problem as well! Your fix is
> probably the better one for 2.4, less intrusive. I'll kill the stack
> requests in 2.5 then.

In 2.5 will you include the 2.4 end_that_request_last fix proposed in
this thread along with removal of requests on the stack?

-andmike
--
Michael Anderson
andmike@us.ibm.com

