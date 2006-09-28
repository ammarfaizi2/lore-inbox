Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWI1FE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWI1FE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 01:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWI1FE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 01:04:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751601AbWI1FE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 01:04:57 -0400
Date: Wed, 27 Sep 2006 22:04:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
Message-Id: <20060927220451.05310cf5.akpm@osdl.org>
In-Reply-To: <451B5587.2050601@garzik.org>
References: <20060928005830.GA25694@havoc.gtf.org>
	<20060927183507.5ef244f3.akpm@osdl.org>
	<451B29FA.7020502@garzik.org>
	<20060927203417.f07674de.akpm@osdl.org>
	<451B4D58.9070401@garzik.org>
	<20060927213628.ef12b1ed.akpm@osdl.org>
	<20060927214428.9e5c0e79.akpm@osdl.org>
	<451B5587.2050601@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 00:54:31 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > On Wed, 27 Sep 2006 21:36:28 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> >> device_for_each_child() 
> > 
> > All that being said, device_for_each_child() is rather broken by design. 
> > It walks a list of items applying a function to them and bales out on
> > first-error.
> 
> Or, like scsi_sysfs.c, it stops when it meets the first match.  Which is 
> a common thing to do.

That code is flakey.  Trace through all the called functions, see all the
errors which get ignored.

> 
> > There's no way in which the caller can know which items have been operated
> > on, nor which items have yet to be operated on, nor which item experienced
> > the failure.  Any caller which is serious about error recovery presumably
> > won't use it, unless the callback function happens to be something which
> > makes no state changes.
> 
> A simple integer return error doesn't tell you all that information 
> either.  The actor must obviously store that additional information 
> somewhere, if it cares.

Yup.

> But whatever.  I give up.

That's the spirit ;)

> I'm going back to working on the libata 
> warnings each build spits out (iomap).

Thanks.
