Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUCUBWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 20:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUCUBWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 20:22:06 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:399 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263584AbUCUBWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 20:22:02 -0500
Date: Sun, 21 Mar 2004 02:21:51 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: [patch,rfc] BSD accounting format rework
In-Reply-To: <20040319191916.GQ1066@vestdata.no>
Message-ID: <Pine.LNX.4.53.0403210210240.24035@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.53.0403191424480.19032@gockel.physik3.uni-rostock.de>
 <20040319191916.GQ1066@vestdata.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Ragnar [iso-8859-15] Kjørstad wrote:

> Do you mind adding the session-id (sid) as well?

Well, I've used up all available space so it depends on whether we want to
change the size of struct acct.

> There is still a lot of information left in the kernel that we are not
> including in the log. I'm not proposing adding all that other stuff
> (except the sid, already mentioned), but maybe we can make it even
> easier to add them in the future:
> 
> One idea is to add the size of the structure to log. The start of the
> struct could be something like:
> struct acct_base {
> 	char flags;
> 	char ac_version;
> 	__u16 ac_size;
> }
> 
> This makes future extentions easier in two seperate ways:
> Userspace acct can recognize futuristic data structures. It will, of
> course, not be able to process them, but it can warn the user and then
> continue on to the next struct.
> 
> Also, it would make it possible to add new fields at the end of the
> structure _without_ bumping the version-number. (Like an extention to
> the same format). When userspace find a v2 struct bigger that it's
> "struct acct_v2" it can parse the first part of the data with struct
> acct_v2 and just ignore the rest. This makes it trivial to add new
> fields without breaking userspace.

Sounds good, but before forming an opinion about a variable struct acct
size, I'd like to look into the userspace tools to learn more about the
implications of it.
For one thing, it makes seeking in the accounting file impossible.

A solution to this might be to extend the struct to multiples of 64 bytes
and have special markers at the positions where ac_version might be looked 
for.


Tim
