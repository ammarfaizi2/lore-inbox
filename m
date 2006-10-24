Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWJXWT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWJXWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWJXWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:19:28 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41382 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161252AbWJXWT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:19:27 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       xfs@oss.sgi.com
In-Reply-To: <20061024144446.GD11034@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:19:26 +1000
Message-Id: <1161728366.22729.28.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

On Wed, 2006-10-25 at 00:44 +1000, David Chinner wrote:
> On Mon, Oct 23, 2006 at 12:36:53PM +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > > XFS can continue to submit I/O from a timer routine, even after
> > > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > > be an issue for current swsusp code,
> > 
> > So it doesn't look like we need the patch _now_.
> > 
> > > but is definitely an issue for Suspend2, where the pages being written could
> > > be overwritten by Suspend2's atomic copy.
> > 
> > And IMO that's a good reason why we shouldn't use RCU pages for storing the
> > image.  XFS is one known example that breaks things if we do so and
> > there may be more such things that we don't know of.  The fact that they
> > haven't appeared in testing so far doesn't mean they don't exist and
> > moreover some things like that may appear in the future.
> 
> Could you please tell us which XFS bits are broken so we can get
> them fixed?  The XFS daemons should all be checking if they are
> supposed to freeze (i.e. they call try_to_freeze() after they wake
> up due to timer expiry) so I thought they were doing the right
> thing.

The problem (in my experience) isn't the threads but a timer that
submits I/O even when the threads are frozen. It stops when the bdev is
frozen. The last report I've seen was before I added bdev freezing to
suspend2, which was 2.6.14, so you guys may have fixed it since then.

I can seek to get a trace if you like.

Regards,

Nigel

