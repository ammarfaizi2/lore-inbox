Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWCUSMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWCUSMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWCUSMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:12:14 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:18050 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964931AbWCUSMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:12:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: kernel@kolivas.org
Subject: Re: [PATCH][3/3] mm: swsusp post resume aggressive swap prefetch
Date: Tue, 21 Mar 2006 19:11:01 +0100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200234.01472.kernel@kolivas.org> <200603210022.32985.rjw@sisk.pl> <1142901862.441f4c66c748e@vds.kolivas.org>
In-Reply-To: <1142901862.441f4c66c748e@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211911.01829.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 01:44, kernel@kolivas.org wrote:
> Quoting "Rafael J. Wysocki" <rjw@sisk.pl>:
> > Sorry, I was wrong.  After resume the image pages in the swap are visible as
> > free, because we allocate them after we have created the image (ie. the
> > image
> > contains the system state in which these pages are free).
> > 
> > Well, this means I really don't know what happens and what causes the
> > slowdown.  It certainly is related to the aggressive prefetch hook in
> > swsusp_suspend().  [It seems to search the whole swap, but it doesn't
> > actually prefetch anything.  Strange.]
> 
> Are you looking at swap still in use? Swap prefetch keeps a copy of prefetched
> pages on backing store as well as in ram so the swap space will not be freed on
> prefetching.

It looks like I have to debug it a bit more.  Unfortunately I've been having
a lot of work to do recently, so it'll take some time.
 
> > > If so, is there a way to differentiate the two so we only aggressively
> > > prefetch on kernel resume - is that what you meant by doing it in the
> > > other file? 
> > 
> > Basically, yes.  swsusp.c and snapshot.c contain common functions,
> > disk.c and swap.c contain the code used by the built-in swsusp only,
> > and user.c contains the userland interface.  If you want something to
> > be run by the built-in swsusp only, place it in disk.c.
> > 
> > Still in this particular case it won't matter, I'm afraid.
> 
> I don't understand what you mean by it won't matter?

Well, sorry.  Of course it will matter.  What I wanted to say is that in this case
tbe built-in swsusp would be affected as well as the userland suspend, because
the hook was in a function used by both.

Greetings,
Rafael
