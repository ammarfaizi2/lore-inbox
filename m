Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946447AbWJ0OiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946447AbWJ0OiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbWJ0OiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:38:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:62699 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752229AbWJ0OiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:38:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Chinner <dgc@sgi.com>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Fri, 27 Oct 2006 16:37:21 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610261111.30486.rjw@sisk.pl> <20061027013802.GQ8394166@melbourne.sgi.com>
In-Reply-To: <20061027013802.GQ8394166@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610271637.21863.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 October 2006 03:38, David Chinner wrote:
> On Thu, Oct 26, 2006 at 11:11:29AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 26 October 2006 10:57, David Chinner wrote:
> > > On Thu, Oct 26, 2006 at 06:18:29PM +1000, Nigel Cunningham wrote:
> > > > As you have them at the moment, the threads seem to be freezing fine.
> > > > The issue I've seen in the past related not to threads but to timer
> > > > based activity. Admittedly it was 2.6.14 when I last looked at it, but
> > > > there used to be a possibility for XFS to submit I/O from a timer when
> > > > the threads are frozen but the bdev isn't frozen. Has that changed?
> > > 
> > > I didn't think we've ever done that - periodic or delayed operations
> > > are passed off to the kernel threads to execute. A stack trace
> > > (if you still have it) would be really help here.
> > > 
> > > Hmmm - we have a couple of per-cpu work queues as well that are
> > > used on I/O completion and that can, in some circumstances,
> > > trigger new transactions. If we are only flush metadata, then
> > > I don't think that any more I/o will be issued, but I could be
> > > wrong (maze of twisty passages).
> > 
> > Well, I think this exactly is the problem, because worker_threads run with
> > PF_NOFREEZE set (as I've just said in another message).
> 
> Ok, so freezing the filesystem is the only way you can prevent
> this as the workqueues are flushed as part of quiescing the filesystem.

Yes, I think so.

Now at last I know what the problem actually is and why we need the freezing
of filesystems, so thanks for helping me understand that. :-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
