Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVLaIe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVLaIe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 03:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVLaIe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 03:34:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23232 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751179AbVLaIe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 03:34:26 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.58.0512310154190.5977@gandalf.stny.rr.com>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20051230154647.5a38227e.akpm@osdl.org>
	 <Pine.LNX.4.58.0512310154190.5977@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 09:34:21 +0100
Message-Id: <1136018061.2901.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 01:58 -0500, Steven Rostedt wrote:
> On Fri, 30 Dec 2005, Andrew Morton wrote:
> 
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > +static DEFINE_SPINLOCK(remove_proc_lock);
> > >
> >
> > I'll take a closer look at this next week.
> >
> > The official way of protecting the contents of a directory from concurrent
> > lookup or modification is to take its i_sem.  But procfs is totally weird
> > and that approach may well not be practical here.  We'd certainly prefer
> > not to rely upon lock_kernel().
> >
> 
> Yeah, I thought about using the sem (or mutex ;) but remove_proc_entry is
> used so darn much around the kernel, I wasn't sure it's not used in irq
> context. 

it can't be; "anything-VFS" like this can sleep if the file is busy etc
etc.


