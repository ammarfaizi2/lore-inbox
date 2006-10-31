Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965540AbWJaLiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965540AbWJaLiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965541AbWJaLiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:38:14 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:7401 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965540AbWJaLiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:38:13 -0500
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061024204239.GA15689@infradead.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <20061024204239.GA15689@infradead.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 22:38:08 +1100
Message-Id: <1162294689.19737.22.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 21:42 +0100, Christoph Hellwig wrote:
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

Further to this, I gave using list.h a go. Unfortunately it doesn't look
to me like it is a good idea: in adding a range, I'm comparing the new
range to the maximum of one extent and the minimum of the next, so
finding the minimum of the next extent becomes a lot uglier than it
currently is. Currently it's just ->next->minimum, but with list.h, I'd
need container_of(current->list.next)->minimum. Or am I missing
something?

Regards,

Nigel

