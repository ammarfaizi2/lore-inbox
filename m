Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290830AbSARV3c>; Fri, 18 Jan 2002 16:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290835AbSARV3T>; Fri, 18 Jan 2002 16:29:19 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:17027 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S290840AbSARV2f>; Fri, 18 Jan 2002 16:28:35 -0500
Date: Fri, 18 Jan 2002 15:28:33 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Doug Alcorn <lathi@seapine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020118152833.A30386@asooo.flowerfire.com>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>; from lathi@seapine.com on Fri, Jan 18, 2002 at 04:11:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually a long-standing UNIXism that is pretty heavily relied-
upon -- for example, opening a temporary file then unlinking it before
use "guarantees" that the file will not stick around in case the app
crashes before it can properly close and unlink.

One nasty side-effect is space allocation -- after unlinking a file and
writing to it, you can fill the disk without the file showing up in 'ls'
or 'du', etc.  Hard to debug.  Stronghold on Solaris used to do this
with log files -- HUP did not discard the old FDs.

-- 
Ken.
brownfld@irridia.com

On Fri, Jan 18, 2002 at 04:11:26PM -0500, Doug Alcorn wrote:
| 
| I had a weird situation with my application where the user deleted all
| the database files while the app was still reading and writing to the
| opened file descriptor.  What was weird to me was that the app didn't
| complain.  It just went merrily about it's business as if nothing were
| wrong.  Of course, after the app shut down all it's data was lost.
| 
| Since I didn't expect this behavior I wrote a simple little program to
| test it[1].  Sure enough, you can rm a file that has opened file
| descriptors and no errors are generated.  Interestingly, sun solaris
| does the same thing.  Since this is the case, I thought this might be
| a feature instead of a bug (ms-win doesn't allow the rm).  So, my
| question is where is this behavior defined?  Is it a kernel issue?
| Does POSIX define this behavior?  Is it a libc issue?  
| 
| I tried to google this, but couldn't think of the right terms to
| describe it.  As I'm not on lkm, I would appreciate a CC: to
| <doug@lathi.net>.
| -- 
|  (__) Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
|  oo / PGP 02B3 1E26 BCF2 9AAF 93F1  61D7 450C B264 3E63 D543
|  |_/  If you're a capitalist and you have the best goods and they're
|       free, you don't have to proselytize, you just have to wait. 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
