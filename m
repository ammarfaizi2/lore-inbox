Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933275AbWKWImN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275AbWKWImN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933271AbWKWImN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:42:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933269AbWKWImM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:42:12 -0500
Date: Thu, 23 Nov 2006 00:40:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?U+liYXN0aWVuIER1Z3Xp?= <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-Id: <20061123004053.76114a75.akpm@osdl.org>
In-Reply-To: <20061123092805.1408b0c6@frecb000686>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<20061121170228.4412b572.akpm@osdl.org>
	<20061123092805.1408b0c6@frecb000686>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 09:28:05 +0100
Sébastien Dugué <sebastien.dugue@bull.net> wrote:

> > > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > > +		/*
> > > +		 * This reference will be dropped in really_put_req() when
> > > +		 * we're done with the request.
> > > +		 */
> > > +		get_task_struct(target);
> > > +	}
> > 
> > It worries me that this function can save away a task_struct* without
> > having taken a reference against it.
> > 
> 
>   OK. Does moving 'notify->target = target;' after the get_task_struct() will
> do, or am I missing something more subtle?

Well it's your code - you tell me ;)

It is unsafe (and rather pointless) to be saving the address of some structure
which can be freed at any time.
