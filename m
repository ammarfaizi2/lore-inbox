Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316950AbSEWQfK>; Thu, 23 May 2002 12:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSEWQfK>; Thu, 23 May 2002 12:35:10 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:32485 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S316950AbSEWQfI>; Thu, 23 May 2002 12:35:08 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C057B48AE@orsmsx111.jf.intel.com>
From: "Gross, Mark" <mark.gross@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "'Erich Focht'" <focht@ess.nec.de>
Cc: mgross@unix-os.sc.intel.com, "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: RE: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ...
	.RE:    PATCH Multithreaded core dump support for the 2.5.14 (aO
Date: Thu, 23 May 2002 09:34:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand what lock problems software suspend has to worry about so
I cannot comment.

However; your design has ALL the processes getting suspended.  To use the
phantom run queue and migrate them all to it, even with semaphore locks,
makes good sense to me.

(spinlocks may need to be dealt with in the context of waiting for pending
i/o to complete, but that should be doable.)

I would consider creating special SoftwareSuspend processes, similar to the
migration_thread, that hold no locks themselves and move all the processes
to the phantom queue.  

These SofwareSuspend processes then would need to wait for some pending I/O,
and then they would "refrigerate" themselves.

This would allow the software suspend to work with RT processes and SMP
systems as well.  Further such a feature "could" enable a type of
warm-swapping of hardware to a large system.  

However; this is starting to feature creep the TCore design, but the
possibilities are worth considering.  On another thread please.

(W) 503-712-8218
MS: JF1-05
2111 N.E. 25th Ave.
Hillsboro, OR 97124


> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Thursday, May 23, 2002 3:07 AM
> To: Alan Cox
> Cc: mgross@unix-os.sc.intel.com; Vamsi Krishna S.; Gross Mark;
> linux-kernel@vger.kernel.org; r1vamsi@in.ibm.com
> Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel was
> ....RE: PATCH Multithreaded core dump support for the 2.5.14 (aO
> 
> 
> Hi!
> 
> > > I think that although my tcore_suspend_threads and 
> Pavel's freeze_processes 
> > > have similar results, I don't think using Pavel's 
> approach for the core dump 
> > > is a good idea.
> > 
> > Migrating a task to a specific processor is also remarkably 
> related. How does
> > it wash out if the suspend thread/freeze process stuff 
> works by migrating
> > all the processes to a CPU that doesnt exist ?
> 
> That does not solve locks problem.
> 								
> 	Pavel
> -- 
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
> 
