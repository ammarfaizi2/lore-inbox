Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWJXU7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWJXU7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWJXU7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:59:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:33740 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965194AbWJXU7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:59:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Date: Tue, 24 Oct 2006 22:58:33 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <20061024204239.GA15689@infradead.org>
In-Reply-To: <20061024204239.GA15689@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610242258.34352.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 October 2006 22:42, Christoph Hellwig wrote:
> On Mon, Oct 23, 2006 at 02:14:17PM +1000, Nigel Cunningham wrote:
> > Switch from bitmaps to using extents to record what swap is allocated;
> > they make more efficient use of memory, particularly where the allocated
> > storage is small and the swap space is large.
> >     
> > This is also part of the ground work for implementing support for
> > supporting multiple swap devices.
> 
> In addition to the very useful comments from Rafael there's some observations
> of my own:
> 
>  - there's an awful lot of opencoded list manipulation, any chance you
>    could use list.h instead?
>  - what unit are the extent values in?  The usage of unsigned long rings
>    warning bells for me, shouldn't this be something like pgoff_t or
>    sector_t depending on what you describe with it?

These are swap offsets as returned by swp_offset().
