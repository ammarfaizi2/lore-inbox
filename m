Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753128AbWKCNr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbWKCNr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbWKCNr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:47:58 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:38067 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1753128AbWKCNr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:47:57 -0500
Date: Fri, 3 Nov 2006 14:48:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061103134802.GD11947@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz> <20061103101901.GA11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz> <20061103122126.GC11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 November 2006 14:31:46 +0100, Mikulas Patocka wrote:
> 
> Really it can batch any number of modifications into one transaction 
> (unless fsync or sync is called). Transaction is closed only on 
> fsync/sync, if 2 minutes pass (can be adjusted) or when the disk runs out 
> of space.

Interesting.  Let me pick an example and see where we're going from
there.  You have four directories, A, B, C and D, none of which is the
parent of another.  Two cross-directory renames happen:
$ mv A/foo B/
$ mv C/bar D/

This will cause four modifications, one to each of the directories.  I
would have assumed that the modifications to A and B receive one
transaction number n, C and D get a different one, n+1 if nothing else
is going on in between.

To commit the first rename, n is written into cct[entry->cc].  To
commit both, n+1 is written instead.  Committing the second
transaction without committing the first is not possible.

Now clearly we are disagreeing, so I must have misunderstood your
design somehow.  Can you see how?

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams
