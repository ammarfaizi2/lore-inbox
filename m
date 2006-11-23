Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757297AbWKWJr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297AbWKWJr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757298AbWKWJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:47:57 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:62400 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1757297AbWKWJr4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:47:56 -0500
Date: Thu, 23 Nov 2006 10:47:55 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-ID: <20061123104755.68561c66@frecb000686>
In-Reply-To: <20061123004053.76114a75.akpm@osdl.org>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<20061121170228.4412b572.akpm@osdl.org>
	<20061123092805.1408b0c6@frecb000686>
	<20061123004053.76114a75.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 10:54:57,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 10:54:59,
	Serialize complete at 23/11/2006 10:54:59
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 00:40:53 -0800
Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 23 Nov 2006 09:28:05 +0100
> Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
> > > > +	target = good_sigevent(&event);
> > > > +
> > > > +	if (unlikely(!target || (target->flags & PF_EXITING)))
> > > > +		goto out_unlock;
> > > > +
> > > > +	
> > > > +
> > > > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > > > +		/*
> > > > +		 * This reference will be dropped in really_put_req() when
> > > > +		 * we're done with the request.
> > > > +		 */
> > > > +		get_task_struct(target);
> > > > +	}
> > > 
> > > It worries me that this function can save away a task_struct* without
> > > having taken a reference against it.
> > > 
> > 
> >   OK. Does moving 'notify->target = target;' after the get_task_struct() will
> > do, or am I missing something more subtle?
> 
> Well it's your code - you tell me ;)
> 
> It is unsafe (and rather pointless) to be saving the address of some structure
> which can be freed at any time.

  Sorry, I expressed myself quite badly. What I wanted to know is whether you
are worried with the task been freed between saving its pointer and getting a
ref on it (which is trivial to fix) or you are thinking of something deeper.

  Thanks,

  Sébastien.
