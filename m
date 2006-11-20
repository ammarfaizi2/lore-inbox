Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966711AbWKTW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966711AbWKTW7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966877AbWKTW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:59:30 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:27079 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966711AbWKTW73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:59:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigelc@bur.st
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Date: Mon, 20 Nov 2006 23:55:49 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200611160912.51226.rjw@sisk.pl> <1164061586.15714.1.camel@nigel.suspend2.net> <1164062390.15714.5.camel@nigel.suspend2.net>
In-Reply-To: <1164062390.15714.5.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202355.50487.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20 November 2006 23:39, Nigel Cunningham wrote:
> (Sorry to reply again)

(No big deal)

> On Tue, 2006-11-21 at 09:26 +1100, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2006-11-20 at 23:18 +0100, Rafael J. Wysocki wrote:
> > > I think I/O can only be submitted from the process context.  Thus if we freeze
> > > all (and I mean _all_) threads that are used by filesystems, including worker
> > > threads, we should effectively prevent fs-related I/O from being submitted
> > > after tasks have been frozen.
> > 
> > I know that will work. It's what I used to do before the switch to bdev
> > freezing. I guess I need to look again at why I made the switch. Perhaps
> > it was just because you guys gave freezing kthreads a bad wrap as too
> > invasive or something. Bdev freezing is certainly fewer lines of code.
> 
> No, it looks like I wrongly believed that XFS was submitting I/O off a
> timer, so that freezing kthreads wasn't enough. In that case, it looks
> like freezing kthreads should be a good solution.

Okay, so let's implement it. :-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
