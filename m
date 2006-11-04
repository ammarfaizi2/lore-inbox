Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWKDKxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWKDKxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWKDKxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:53:06 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:48601 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965291AbWKDKxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:53:03 -0500
Date: Sat, 4 Nov 2006 11:53:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: dean gaudet <dean@arctic.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061104105302.GB16991@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 November 2006 11:00:58 -0800, dean gaudet wrote:
> 
> it seems to me that you only need to be able to represent a range of the 
> most recent 65536 crashes... and could have an online process which goes 
> about "refreshing" old objects to move them forward to the most recent 
> crash state.  as long as you know the minimm on-disk crash count you can 
> use it as an offset.

You really don't want to go down that path.  Doubling the storage size
will double the work necessary to move old objects - hard to imagine a
design that scales worse.

CPU schedulers, btw, take this approach.  But they cheat, as they know
the maximum lifetime of their objects (in-flight instructions, rename
registers,...) is bounded to n.  Old objects are refreshed for free.
http://www.chip-architect.com/news/2003_09_21_Detailed_Architecture_of_AMDs_64bit_Core.html

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
