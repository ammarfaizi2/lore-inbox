Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWELNMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWELNMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWELNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:12:40 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49846 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751271AbWELNMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:12:39 -0400
Subject: Re: [RFC][PATCH RT 1/2] futex_requeue-optimize
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
In-Reply-To: <20060512111256.GA27481@elte.hu>
References: <20060510112701.7ea3a749@frecb000686>
	 <20060511091541.05160b2c.akpm@osdl.org> <20060512063220.GA630@elte.hu>
	 <1147421427.3969.60.camel@frecb000686>
	 <1147432419.3969.70.camel@frecb000686>  <20060512111256.GA27481@elte.hu>
Date: Fri, 12 May 2006 15:16:56 +0200
Message-Id: <1147439816.3969.81.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 15:15:37,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 15:15:39,
	Serialize complete at 12/05/2006 15:15:39
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 13:12 +0200, Ingo Molnar wrote:
> * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
> > On Fri, 2006-05-12 at 10:10 +0200, Sébastien Dugué wrote:
> > > On Fri, 2006-05-12 at 08:32 +0200, Ingo Molnar wrote:
> > > > * Andrew Morton <akpm@osdl.org> wrote:
> > > > 
> > > > > Should the futex code be using hlist_heads for that hashtable?
> > > > 
> > > > yeah. That would save 1K of .data on 32-bit platforms, 2K on 64-bit 
> > > > platforms.
> > > 
> > >   I'll try to look into this.
> > > 
> > 
> >   Well, moving the hash bucket list to an hlist may save a few bytes 
> > on .data, but all the insertions are done at the tail on this list 
> > which would not be easily done using hlists.
> > 
> >   Any thoughts?
> 
> just queue to the head. This is a hash-list, ordering has only 
> performance effects.
> 

  Queuing to the head would mean that tasks are woken up in LIFO order
(i.e. the last task put to sleep will be the first to be woken up).
  I'm not sure that's what people would expect, or am I missing
something here?

  Sébastien.

