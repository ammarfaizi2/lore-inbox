Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTI2WyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTI2WyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:54:04 -0400
Received: from hockin.org ([66.35.79.110]:2571 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263009AbTI2WyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:54:01 -0400
Date: Mon, 29 Sep 2003 15:43:43 -0700
From: Tim Hockin <thockin@hockin.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20030929154343.A13742@hockin.org>
References: <mailman.1064857032.26219.linux-kernel2news@redhat.com> <200309292229.h8TMTWw32486@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309292229.h8TMTWw32486@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Sep 29, 2003 at 06:29:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 06:29:32PM -0400, Pete Zaitcev wrote:
> >> This version drops the internal groups array (it's so often shared
> >> that it's not worth it, and the logic becomes a bit neater), and does
> >> vmalloc fallback in case someone has massive number of groups.
> > 
> > Why?
> 
> > The vmalloc space is limited, and the code just gets uglier.
> 
> Tim was going to write a version that segments groups into
> smaller arrays. I reckon it was too difficult?

I posted it once or twice then got busy.  It's an array of pages.  Rusty has
it, but didn't believe me when I said Linus wouldn't let vmalloc() fly.

> > Have you been looking at glibc sources lately, or why do you believe that 
> > we should encourage insane usage?
> 
> We have some customers who run insane number of groups,
> with their own patches. This practice is popular in the
> Beowulf crowd for some reason. I should note this is not
> very mainstream.

I'd be ok with the simplest "kmalloc or too bad" version, but our customers
wouldn't.

My version uses a struct group_info which has an array of pages.  The groups
are sorted and bsearched, instead of linear.  The perfomance is quite good.
An older version against 2.6.0-test1 or something is attached.  If this
method will fly, I'll take some of Rusty's good ideas and finish this
version of it..

Linus?
