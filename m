Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVDHNBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVDHNBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVDHNBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:01:35 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:64417 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262808AbVDHNAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:00:37 -0400
Date: Fri, 8 Apr 2005 15:00:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>
Subject: stack checking (was: Re: RFC: turn kmalloc+memset(,0,) into kcalloc)
Message-ID: <20050408130031.GB2292@wohnheim.fh-wedel.de>
References: <4252BC37.8030306@grupopie.com> <20050407214747.GD4325@stusta.de> <42567B3E.8010403@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42567B3E.8010403@grupopie.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 April 2005 13:38:22 +0100, Paulo Marques wrote:
> Adrian Bunk wrote:
> 
> >E.g. read my "Stack usage tasks" email. The benefits would only be 
> >present for people using GNU gcc 3.4 or SuSE gcc 3.3 on i386, but this 
> >is a reasonable subset of the kernel users - and it brings them a
> >2% kernel size improvement.
> 
> I've read that thread, but it seems that it is at a dead end right now, 
> since we don't have a good tool to find out which functions are abusing 
> the stack with unit-at-a-time.
> 
> Is there some way to even limit the search, like using a stack usage log 
> from a compilation without unit-at-a-time, and going over the hotspots 
> to check for problems?
> 
> If we can get a list, even if it contains a lot of false positives, I 
> would more than happy to help out...

The situation is bad, but not that bad.

As a starter, you can compile the kernel with gcc 3.4 and run "make
checkstack" on it.  No call graph information in there, but getting
all functions on the list below 2k would help.

Next step would be a small hack to my private tool to read stack
consumption from gcc 3.4 and call graph from gcc 3.1.  Obviously you
get tons of "these five functions in the call graph are actually a
single one in the real binary".  Quick and dirty.

Then someone (doesn't have to be me) should spend some time to port
the callgraph extraction code from 3.1 to 3.4 or 4.0.  Before the
unit-at-a-time thing came up, I wanted to port things to sparse.  But
sparse would suffer from the same problem of not inlining functions
identically to the real compiler, so current gcc appears to be a
better target.

Step 1 is possible right now, step 2 might take a while (i'm on
vacation) and step 3 may not happen this year anymore, unless someone
else wants to start hacking on it.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
