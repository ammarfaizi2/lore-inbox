Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268286AbUIQC3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268286AbUIQC3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 22:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUIQC3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 22:29:39 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9935 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268286AbUIQC3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 22:29:37 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095377752.23913.3.camel@localhost.localdomain>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
	 <1095377752.23913.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 16 Sep 2004 22:29:36 -0400
Message-Id: <1095388176.20763.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 00:35 +0100, Alan Cox wrote:

> How many of the races matter. There seem to be several different
> problems here and mixing them up might be a mistake. 
> 
> 1.	I absolutely need to get the right file at the right moment, please
> mass me a descriptor to the file as the user closes it so I always get
> it right (indexer, virus checker)
> 
> 2.	If something happens bug me and I'll have a look (eg file manager)

I think we want a solution that works well for both cases.

E.g., we have a few different needs:

	- Stuff like Spotlight-esque automatic Indexers.
	- File manager notifications
	- Other GUI notifications (desktop, menus, etc.)
	- To prevent polling (e.g. /proc/mtab)
	- Existing dnotify users

dnotify is pretty lame for any of the above situations.  Even for
something as trivial as watching the current open directory in Nautilus,
look at the hoops we have to just through with FAM.

And dnotify utterly falls apart on removable media or for any "large"
sort of job, e.g. indexing.

	Robert Love


