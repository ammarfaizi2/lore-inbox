Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSGVEx0>; Mon, 22 Jul 2002 00:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSGVEx0>; Mon, 22 Jul 2002 00:53:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316217AbSGVExZ>;
	Mon, 22 Jul 2002 00:53:25 -0400
Message-ID: <3D3B925D.624986EE@zip.com.au>
Date: Sun, 21 Jul 2002 22:04:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
References: <Pine.LNX.4.44L.0207201740580.12241-100000@imladris.surriel.com> <Pine.LNX.4.44.0207201351160.1552-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 20 Jul 2002, Rik van Riel wrote:
> >
> > OK, I'll try to forward-port Ed's code to do that from 2.4 to 2.5
> > this weekend...
> 
> Side note: while I absolutely think that is the right thing to do, that's
> also the much more "interesting" change. As a result, I'd be happier if it
> went through channels (ie probably Andrew) and had some wider testing
> first at least in the form of a CFT on linux-kernel.
> 

I'd suggest that we avoid putting any additional changes into
the VM until we have solutions available for:

2: Make it work with pte-highmem  (Bill Irwin is signed up for this)

4: Move the pte_chains into highmem too (Bill, I guess)

6: maybe GC the pte_chain backing pages. (Seems unavoidable.  Rik?)


Especially pte_chains in highmem.  Failure to fix this well
is a showstopper for rmap on large ia32 machines, which makes
it a showstopper full stop.

If we can get something in place which works acceptably on Martin
Bligh's machines, and we can see that the gains of rmap (whatever
they are ;)) are worth the as-yet uncoded pains then let's move on.
But until then, adding new stuff to the VM just makes a `patch -R'
harder to do.

-
