Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUCDVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUCDVy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:54:27 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:52143 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261940AbUCDVy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:54:26 -0500
Date: Thu, 4 Mar 2004 22:54:14 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arthur Corliss <corliss@digitalmages.com>
cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
Message-ID: <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do the userspace commands that parse the acct files
> > know how to deal with this format change ?
> 
> Well, that's the ugly part.  I had to munge glibc's sys/acct.h to reflect the
> same changes as well to get the gnu tools to read the file correctly (the
> accounting file does need to be started fresh with this struct, btw).

In a first step, we could map all high uids onto one 'reserved' uid to
avoid requiring new userspace tools.
This is along the lines what I did when jiffies became 64 bits - just map 
larger times onto the maximum time representable with 32 bits.

We didn't even exploit the fact that 34 bit times would be representable 
in the current format, because existing userspace tools would probably 
break then.
At the time I did that change, it seemed to be common consensus that too
few people cared about accurate BSD accounting to require new userspace 
tools.

btw: if you actually push an incompatible change, could we do something 
about large times as well?

Tim
