Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUEQUQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUEQUQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUEQUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:16:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45072 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261416AbUEQUQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:16:42 -0400
Date: Mon, 17 May 2004 21:16:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rob Landley <rob@landley.net>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>, <vonbrand@inf.utfsm.cl>,
       <nickpiggin@yahoo.com.au>, <jgarzik@pobox.com>,
       <brettspamacct@fastclick.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <200405121252.14006.rob@landley.net>
Message-ID: <Pine.LNX.4.44.0405172114470.2804-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Rob Landley wrote:
> On Friday 07 May 2004 11:57, Pavel Machek wrote:
> > Hi!
> >
> > > > Perhaps what we really want is "swap_back_in" script? That way you
> > > > could do "updatedb; swap_back_in" in cron and be happy.
> > >
> > > swapoff -a; swapon -a
> >
> > Good point... it will not bring back executable pages, through.
> >
> > 								Pavel
> 
> What would the above do if there wasn't enough memory to swap everything back 
> in?  (Presumably, the swapoff would fail?)

Repeating my earlier reply to a similar question...

On 2.4 it certainly would be a problem (hang with others OOM-killed).

On 2.6 it shouldn't be a problem: the swapoff may fail upfront if
there's way too little memory, or it may get itself OOM-killed if
it runs out on the way, but it ought not to upset other tasks.

But of course, Pavel is right that it does nothing for file backed.

Hugh

