Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVFGR03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVFGR03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVFGR03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:26:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:9948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261936AbVFGR00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:26:26 -0400
Date: Tue, 7 Jun 2005 10:28:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050607171108.GA28817@harddisk-recovery.nl>
Message-ID: <Pine.LNX.4.58.0506071022400.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050607130535.GD16602@harddisk-recovery.com> <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
 <20050607171108.GA28817@harddisk-recovery.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Jun 2005, Erik Mouw wrote:
> 
> Well, it's nice to know which repos you pulled from for a particular
> release, that makes it easier to figure out what's wrong if/when
> something breaks.

Well, the thing is, you don't actually get a full list - you at best get a
_partial_ list of the merges I do. In fact, it's almost always a proper 
subset, with (wild wag) 10% of the merges never showing up.

If a repo has already merged with me on the far end, my merge will be just 
a "fast-forward to what they did", which won't show up as a separate 
commit.

Similarly, if somebody is on a different time-zone from me and just
happens to do his work while I'm sleeping, and I pull the tree first thing
in the morning, there won't be any overlapping development and again it's
just a fast-forward. So no merges at _all_ may be showing on either side
in that case.. 

This very much does happen, exactly because we have a "merge often" 

> Isn't the easy fix to put the long changelog information on a single
> line?

Sure. It's just a shell script that generates the message:

	merge_name=$(echo "$1" | sed 's:\.git/*$::')
	if [ "$2" ]
	then
	   merge_name="'$2' branch from
	
	        $merge_name"
	   merge_head="refs/heads/$2"
	fi

but the reason I do it on multiple lines is that that looks better in the 
long format, I think.

But maybe the short format is the one I should prioritize, since that's
the one that also shows up in the summary line for the graphical tools
(webgit and gitk).

		Linus
