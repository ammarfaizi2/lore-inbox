Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVITEaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVITEaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVITEaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:30:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964878AbVITEaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:30:08 -0400
Date: Mon, 19 Sep 2005 21:30:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <20050920042456.GC7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509192128070.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
 <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
 <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
 <20050920042456.GC7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Al Viro wrote:
>  
> Uhh...  I still don't understand which behaviour do you want.
> 
> 	* removal of this link, postponed to indefinite future (until we
> do not have any users of that dentry) [ new behaviour ]
> 	* moment when the last link is gone _and_ nobody uses any dentries
> pointing to object, with information taken from the last one still in use
> [ old behaviour ]

Old behaviour (well, "old" is relative) is apparently the expected one.

But the old behaviour had a bug: we _also_ call dentry_iput() for
non-deletes. 

		Linus
