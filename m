Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310633AbSCHBT3>; Thu, 7 Mar 2002 20:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310634AbSCHBTU>; Thu, 7 Mar 2002 20:19:20 -0500
Received: from ns.suse.de ([213.95.15.193]:19465 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310633AbSCHBTM>;
	Thu, 7 Mar 2002 20:19:12 -0500
Date: Fri, 8 Mar 2002 02:19:09 +0100
From: Dave Jones <davej@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020308021909.L29587@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	"Jonathan A. George" <JGeorge@greshamstorage.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Mar 07, 2002 at 08:59:47PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 08:59:47PM -0300, Rik van Riel wrote:

 > 3) graphical 2-way merging tool like bitkeeper has
 >    (this might not seem essential to people who have
 >    never used it, but it has saved me many many hours)

 For me, this is the 'killer feature' of bk, and is my sole reason
 for spending the last few days beating up Larry to make some minor-ish
 improvements.

 Say for example I want to push Linus reiserfs bits from my tree.

 Old method:
 - diff linux-vanilla linux-dj >dj.diff
 - grepdiff reiser dj.diff | xargs -n1 filterdiff dj.diff -i >reiser.diff
 - copy this file to reiser-1.diff reiser-2.diff with the intention
   of making each diff have only one 'theme'
 - vi reiser1.diff, chop out unneeded bits
 - repeat for all remaining files
 - check they all apply on top of Linus' latest.
 (If during any of the steps above, Linus puts out a new pre that
  touches any of the files these patches do, resync, and go back to step #1)

This, takes a long time. And for some of the more compilicated bits,
it's a pita to do.

The new method:
 - bk pull
 - bk citool
 - tag reiserfs files in cset
 - hide bits in this delta that don't apply to this csets 'theme' [1]
 - Once I have the grouped together cset, I generate a diff.
 If during any of these steps Linus changes any of these files, I
 bk pull, and with luck, bk does the nasty bits for me, and fires up
 the conflict resolution tool if needbe.

 The above steps look about equal in number, but in speed of operation
 for this work, bk wins hands down.
 
 I'm not aware of anything other than bk that has the functionality
 of citool and fmtool combined.  My usage pattern above doesn't fit
 the usual approach, as suggested in Jeff's minihowto, where I'd
 have multiple 'themed' trees for each cset I'd want to push Linus'
 way. With a 6MB diff, I'd need to grow a lot of themes, and fortunatly,
 bk can be quite easily bent into shape to fit my lazy needs.

 I'm going to be trying it out for the next round of merging with Linus
 (which is partly the reason I've not pushed anything his way recently)
 As soon as I'm done moving house this weekend, I'll be having quite a
 long play with bk, to see how much quicker and easier my life becomes.

 And the usual Larry disclaimer applies. I'll try it, and if it doesn't
 work out, I'll go back to my old way of working.
 
 Regards,
 Dave.

[1] This is what Larry has been working on for me the last few days
    For the most part, it's done, just needs some niggles working out.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
