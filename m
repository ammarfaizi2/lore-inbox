Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUFQTgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUFQTgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUFQTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:36:13 -0400
Received: from fmr05.intel.com ([134.134.136.6]:59832 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262766AbUFQTfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:35:52 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: ganzinger@mvista.com, George Anzinger <george@mvista.com>,
       Mark Gross <mgross@linux.jf.intel.com>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Thu, 17 Jun 2004 12:35:39 -0700
User-Agent: KMail/1.5.4
Cc: ganzinger@mvista.com, Arjan van de Ven <arjanv@redhat.com>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <40C7BE29.9010600@am.sony.com> <200406150904.01447.mgross@linux.intel.com> <40D0CAB5.6010000@mvista.com>
In-Reply-To: <40D0CAB5.6010000@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406171235.39799.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 June 2004 15:33, George Anzinger wrote:
> > Details...  Thats a hard thing to come by when in a high level design
> > discussion.  
> >
> > Its too bad the conversion_bits export got shot down.  Perhaps it was
> > because you where exporting a data structure that made implicit
> > assumptions rather than a more object based interface, with function
> > pointers to conversion functions, and private data?
>
> The functions, of course, were also exported.  But this is exported from
> the arch side of things and not the base.  They need to provide the
> conversion functions, the bits just being somthing that is needed if they
> export inline code, where as, if they export the functions, they don't need
> the bits (i.e. they are private).  I rather like to export inline code as
> it is about twice as fast (I would guess).

I think if in-lines are exported through more than one level of indirection 
through include files then the code is hard to grok.

>
> > Regardless of doing an object based implementation of your design or not,
> > if we could loose the #ifdefs and implicit ifdefs (i.e. IF_HIGH_RES) from
> > the code (especially posix-timers.c) that would be really a good thing.
> >
> > I do still like the object based design concept ;)
>
> I am afraid I am too old :(   I rather think I understand object based code
> while not finding it very "warm".   I have never written anything large
> that way and find myself objecting in the name of performance, but then, as
> I said, I may be too old.

Object based code good for some things, and not for others.  I think it could 
be a good match this code, but I bet it can be done well other ways as too.

I think without exporting abstractions (even just prototypes) that are common 
across architectures, timebases and interrupt source you will get into #ifdef 
hell with this code.


--mgross

