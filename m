Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUCDWdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUCDWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:33:31 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:44229 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S261990AbUCDWd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:33:29 -0500
Date: Thu, 4 Mar 2004 13:33:21 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Tim Schmielau wrote:

> In a first step, we could map all high uids onto one 'reserved' uid to
> avoid requiring new userspace tools.
> This is along the lines what I did when jiffies became 64 bits - just map
> larger times onto the maximum time representable with 32 bits.
>
> We didn't even exploit the fact that 34 bit times would be representable
> in the current format, because existing userspace tools would probably
> break then.
> At the time I did that change, it seemed to be common consensus that too
> few people cared about accurate BSD accounting to require new userspace
> tools.

First off:  there are no changes needed the current defacto accounting tools
on Linux (the GNU package).  As long as they can reference the correct size of
the struct (as defined in acct.h) they work just fine.  The GNU package
doesn't look like it's been updated since '98, and it works just fine with the
right header.  I mentioned that I did update glibc's sys/acct.h because it
uses that in preference over the kernel header.  Minor issue, but something
I'm looking at.

Second:  I don't want new userspace tools, either, but I do want the ones
I've got to work, which is what they don't do when it reports the lower bits
of the uid field on high uids.  In other words, the tools are *already*
broken.  I realise that I'm probably a corner case in that most admins will
never assign high uids, but that really doesn't make me feel better about
broken tools.  ;-)

> btw: if you actually push an incompatible change, could we do something
> about large times as well?

If the numbers we're logging are meaningless, then hell, yes, let's fix them
all!

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
