Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUGLWkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUGLWkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUGLWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:40:43 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:36751 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S264002AbUGLWk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:40:29 -0400
Message-ID: <40F31348.70807@tlinx.org>
Date: Mon, 12 Jul 2004 15:40:08 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       Jan Knutar <jk-lkml@sci.fi>, L A Walsh <lkml@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org> <20040712212020.GA22372@taniwha.stupidest.org>
In-Reply-To: <20040712212020.GA22372@taniwha.stupidest.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<aside>
Chris, I'd never say you were full of shit or lied in any circumstance.
Mistakes are human -- not being "full of shit" or "lying".  Get over it.
Don't inflate error.  Seems to be related to pervasive belief that people
have to be either all good or all bad or all perfect, or flawed, or all 
white
hat or black hat, God or imperfect and to be "good" in programming field
one must be perfect and never be _known_ to make a mistake (like some
who portray others as dangerous or fools because they may hold knowledge of
that name-callers' faults).  The ones who pose the real danger are those
who censor others because the "masses" can't handle the truth.  Anyway
it's unuseful to demean yourself or others.  </aside>

If it is of any help (I doubt it, it perplexes me)...the files I've
written out with vim and have returned "nulls" have been files that were
written out 2-3 _DAYS_ earlier -- often with more recent write having
been saved fine. 

I've also seen sections in log files where blocks would return zero in the
middle of a log.  Obviously blocks before and after successfully made it to
disk, but in _RARE_ circumstances (crashes and unplanned shutdowns are 
already
rare enough, so it's a rare bug that only shows up on a 'rare' 
occasion...:-).

Almost (shot in the dark), like some code that was supposed to zero 
unused but allocated
datablocks got pointed at the wrong blocks, since these files are 
readable as having
been written (yes may all be out of membuffs) and are often recoverable 
from the day's
backup. 

If it was a file I just edited and then it crashed, that I could 
understand more than
having files I haven't touched for a few days be zapped.

-l



Chris Wedgwood wrote:

>On Sat, Jul 10, 2004 at 12:19:14PM -0700, Chris Wedgwood wrote:
>
>  
>
>>It would be nice for some people to prevent log-replay zeroing files
>>but then something would have to be able to determine whether or not
>>these blocks were newly allocated (and this might contain
>>confidential data and need to be zeroed) or previously part of the
>>file in which case we probably would like them left alone.
>>    
>>
>
>I told lies.
>
>  
>
>>I don't know any of the code well enough to know how easy this is or
>>even if I'm telling the truth :) Hopefully someone who does can
>>speak up on this.
>>    
>>
>
>I knew I was completely full of shit.
>
>
>XFS does *not* zero files, it simply returns zeros for unwritten
>extents.  If you open an existing file and scribble all over it, you
>might see the old data during a crash, or the new data if it was
>flushed.  You shouldn't see zero's though.
>
>What does happen though, is that dotfiles are truncated and rewritten,
>if the data blocks aren't flushed you will get zeros back because the
>extents were unwritten.  This is really the only sensible thing to do
>given the circumstances.
>
>My guess is that with other fs' (when journaling metadata only) the
>blocks allocated for the newly written data are *usually* the same as
>the recently freed blocks from the truncate so things appear to work
>but in reality it's probably mostly luck.  XFS could behave the same
>way, but sooner or later you will still loose when you get crap back
>instead of old data.
>
>Some applications just need to be fixed.
>
>
>   --cw
>  
>
