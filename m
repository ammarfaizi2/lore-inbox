Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311086AbSCHU3D>; Fri, 8 Mar 2002 15:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311082AbSCHU2z>; Fri, 8 Mar 2002 15:28:55 -0500
Received: from austin.openmic.com ([216.143.252.250]:7691 "EHLO
	austin.openmic.com") by vger.kernel.org with ESMTP
	id <S311084AbSCHU2t>; Fri, 8 Mar 2002 15:28:49 -0500
Message-ID: <3C891EA4.6090102@greshamstorage.com>
Date: Fri, 08 Mar 2002 14:27:16 -0600
From: "Jonathan A. George" <JGeorge@greshamstorage.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020226
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <20020308021909.L29587@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>  Old method:
> - diff linux-vanilla linux-dj >dj.diff
> - grepdiff reiser dj.diff | xargs -n1 filterdiff dj.diff -i >reiser.diff
> - copy this file to reiser-1.diff reiser-2.diff with the intention
>   of making each diff have only one 'theme'
> - vi reiser1.diff, chop out unneeded bits
> - repeat for all remaining files
> - check they all apply on top of Linus' latest.
> (If during any of the steps above, Linus puts out a new pre that
>  touches any of the files these patches do, resync, and go back to step #1)
>
>The new method:
> - bk pull
> - bk citool
> - tag reiserfs files in cset
> - hide bits in this delta that don't apply to this csets 'theme' [1]
> - Once I have the grouped together cset, I generate a diff.
> If during any of these steps Linus changes any of these files, I
> bk pull, and with luck, bk does the nasty bits for me, and fires up
> the conflict resolution tool if needbe.
>
This is a great example Dave, and is exactly the kind of feedback that 
free SCM tool developers need.  This is my current list of features CVS 
doesn't have which are important for kernel developers (or me).

1.    Storage of select inode metadata (i.e. link, pipe, dir, owner, ...)
2.    Ability to rename files
3.    Atomic patch set tagging (i.e. global tag patched files)
4.    Advanced merge conflict tool (i.e. tkdiff/gvimdiff like features)
5.    Remote branch repository support
6.    Multi-branch merging and tracking (i.e. merge once)

The first three have been on my personal hit list for a while.  A good 
implementation of 5 & 6 are probably the toughest to do properly, but 
also seem like key elements for kernel developers due to the importance 
of multiple trees.  I'm not really worried about the performance of CVS 
since any problems here can probably be solved by adding some 
administrative meta data for caching and some tweaks to the back end.  
However, it sounds as if Arch and PRCS are pretty interesting, and I 
hope that a couple of people take a look at them to see how close it is 
to suitable.  My respect for BK is certainly been enhanced by this 
discussion, but I still would prefer a free (or failing that GPL) 
license. ;-)

Comments?

--Jonathan--

