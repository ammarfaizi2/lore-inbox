Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756794AbWKVUDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbWKVUDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbWKVUDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:03:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:14506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756794AbWKVUDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:03:39 -0500
Date: Wed, 22 Nov 2006 12:02:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH] Add do_not_call_when_idle option to timer and
 workqueue
Message-Id: <20061122120229.7218802d.akpm@osdl.org>
In-Reply-To: <20061122091324.A29862@unix-os.sc.intel.com>
References: <20061121162845.A24791@unix-os.sc.intel.com>
	<20061121181114.b9d923bd.akpm@osdl.org>
	<20061122091324.A29862@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 09:13:24 -0800
Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:

> On Tue, Nov 21, 2006 at 06:11:14PM -0800, Andrew Morton wrote:
> > On Tue, 21 Nov 2006 16:28:45 -0800
> > Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
> > 
> > > 
> > >  struct timer_list {
> > >  	struct list_head entry;
> > >  	unsigned long expires;
> > > @@ -16,6 +18,7 @@
> > >  	unsigned long data;
> > >  
> > >  	struct tvec_t_base_s *base;
> > > +	int	flags;
> > >  #ifdef CONFIG_TIMER_STATS
> > 
> > Adding a new field to the timer_list is somewhat of a hit - this is going
> > to make an awful lot of data structures a bit larger.  Some of which we
> > allocate a large number of.
> > 
> > I think we could justfy getting nasty and using the LSB of
> > timer_list.function for this..
> 
> That is a clever idea... Is that going to work in all architectures with all
> compiler flags?

Don't know.  Possibly not.  Other options are list.next, list.prev and
base.  None of them are pleasant.
