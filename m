Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbTGLSYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268256AbTGLSYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:24:25 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:57547 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S268255AbTGLSYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:24:23 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Alexander Viro <viro@math.psu.edu>
In-Reply-To: <3F0F5453.2060203@cyberone.com.au>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
	 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>
	 <3F0F5453.2060203@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1058035059.13317.100.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Jul 2003 14:37:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 20:20, Nick Piggin wrote:

> >Seems that way.  With the 2.4.21 code, a read might easily get a
> >request, but then spend forever waiting for a huge queue of merged
> >writes to get to disk.
> >
> 
> But it is the job of the io scheduler to prevent this, isn't it?
> 

Yes, but the 2.4.21 code doesn't do it.

> >
> >I believe the new way provides better overall read performance in the
> >presence of lots of writes.
> >
> >
> 
> I don't know how that can be, considering writers will consume
> basically limitless requests. What am I missing?

There is a limit on the total amount of IO in flight (4MB by default,
reads/writes combined).  We can make this a harder limit by disallowing
merges on any requests present at the time of an unplug.  Perhaps I'm
not reading your question correctly?

-chris


