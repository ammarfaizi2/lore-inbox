Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUHCAn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUHCAn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUHCAhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:37:21 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:732 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S264726AbUHCAfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:35:16 -0400
Date: Mon, 2 Aug 2004 20:34:58 -0400 (EDT)
From: Song Jiang <sjiang@CS.WM.EDU>
To: Con Kolivas <kernel@kolivas.org>
cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       <fchen@CS.WM.EDU>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] token based thrashing control
In-Reply-To: <410DCEBC.8030600@kolivas.org>
Message-ID: <Pine.LNX.4.44.0408022018080.8702-100000@va.cs.wm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When there is memory competition among multiple processes,
Which process grabs the token first is important.
A process with its memory demand exceeding the total
ram gets the token first and finally has to give it up 
due to a time-out would have little performance gain from token,
It could also hurt others. Ideally we could make small processes
more easily grab the token first and enjoy the benifis from
token. That is, we want to protect those that are deserved to be
protected. Can we take the rss or other available memory demand
information for each process into the consideration of whether 
a token should be taken, or given up and how long a token is held.  
  Song

On Mon, 2 Aug 2004, Con Kolivas wrote:

> Con Kolivas wrote:
> > Rik van Riel wrote:
> > 
> >> On Mon, 2 Aug 2004, Con Kolivas wrote:
> >>
> >>
> >>> We have some results that need interpreting with contest.
> >>> mem_load:
> >>> Kernel    [runs]    Time    CPU%    Loads    LCPU%    Ratio
> >>> 2.6.8-rc2      4    78    146.2    94.5    4.7    1.30
> >>> 2.6.8-rc2t     4    318    40.9    95.2    1.3    5.13
> >>>
> >>> The "load" with mem_load is basically trying to allocate 110% of free 
> >>> ram, so the number of "loads" although similar is not a true 
> >>> indication of how much ram was handed out to mem_load. What is 
> >>> interesting is that since mem_load runs continuously and constantly 
> >>> asks for too much ram it seems to be receiving the token most 
> >>> frequently in preference to the cc processes which are short lived. 
> >>> I'd say it is quite hard to say convincingly that this is bad because 
> >>> the point of this patch is to prevent swap thrash.
> >>
> >>
> >>
> >> It may be worth trying with a shorter token timeout
> >> time - maybe even keeping the long ineligibility ?
> > 
> > 
> > Give them a "refractory" bit which is set if they take the token? Next 
> > time they try to take the token unset the refractory bit instead of 
> > taking the token.
> 
> Or take that concept even further; Give them an absolute refractory 
> period where they cannot take the token again and a relative refractory 
> bit which can only be reset after the refractory period is over.
> 
> Con
> 

