Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752421AbWKAVT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbWKAVT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWKAVT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:19:56 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:11147 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1752421AbWKAVTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:19:55 -0500
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061101123603.GA7195@atrey.karlin.mff.cuni.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <20061024204239.GA15689@infradead.org>
	 <1162294689.19737.22.camel@nigel.suspend2.net>
	 <20061101123603.GA7195@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 08:19:52 +1100
Message-Id: <1162415992.5737.8.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-11-01 at 13:36 +0100, Pavel Machek wrote:
> > Hi.
> > 
> > On Tue, 2006-10-24 at 21:42 +0100, Christoph Hellwig wrote:
> > > On Mon, Oct 23, 2006 at 02:14:17PM +1000, Nigel Cunningham wrote:
> > > > Switch from bitmaps to using extents to record what swap is allocated;
> > > > they make more efficient use of memory, particularly where the allocated
> > > > storage is small and the swap space is large.
> > > >     
> > > > This is also part of the ground work for implementing support for
> > > > supporting multiple swap devices.
> > > 
> > > In addition to the very useful comments from Rafael there's some observations
> > > of my own:
> > > 
> > >  - there's an awful lot of opencoded list manipulation, any chance you
> > >    could use list.h instead?
> > 
> > Further to this, I gave using list.h a go. Unfortunately it doesn't look
> > to me like it is a good idea: in adding a range, I'm comparing the new
> > range to the maximum of one extent and the minimum of the next, so
> > finding the minimum of the next extent becomes a lot uglier than it
> > currently is. Currently it's just ->next->minimum, but with list.h, I'd
> > need container_of(current->list.next)->minimum. Or am I missing
> > something?
> 
> That does not look that scary... just do it.

It currently makes more sense to me to stick with what I already have
because it's simpler and more readable.

Regards,

Nigel

