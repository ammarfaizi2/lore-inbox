Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUCSVTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUCSVTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:19:09 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:51957 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261832AbUCSVTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:19:06 -0500
Date: Fri, 19 Mar 2004 15:14:57 -0600
From: Robin Holt <holt@sgi.com>
To: Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: [patch,rfc] BSD accounting format rework
Message-ID: <20040319211457.GA19662@lnx-holt>
References: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de> <Pine.LNX.4.53.0403191424480.19032@gockel.physik3.uni-rostock.de> <20040319191916.GQ1066@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319191916.GQ1066@vestdata.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

How about breaking the ac_version structure down as two nibbles?  One
half being the major version and the other half being a minor version.
The major version, when changed, means the structure is no longer compatible.
The minor version can be changed when existing fields are not modified
in either form or function.

Robin
