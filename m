Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUI3RuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUI3RuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269374AbUI3RuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:50:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34013 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269373AbUI3RuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:50:03 -0400
Date: Thu, 30 Sep 2004 10:48:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040930104808.291d9ddc.pj@sgi.com>
In-Reply-To: <1096563193.26742.152.camel@orca.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
	<20040928120830.7c5c10be.akpm@osdl.org>
	<41599456.6040102@nortelnetworks.com>
	<1096390398.4911.30.camel@betsy.boston.ximian.com>
	<1096392771.26742.96.camel@orca.madrabbit.org>
	<1096403685.30123.14.camel@vertex>
	<20040929211533.5e62988a.akpm@osdl.org>
	<1096508073.16832.17.camel@localhost>
	<20040929200525.4e7bb489.pj@sgi.com>
	<1096558180.26742.133.camel@orca.madrabbit.org>
	<20040930092744.5eb5ea10.pj@sgi.com>
	<1096563193.26742.152.camel@orca.madrabbit.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray wrote:
> However, dnotify has shown that forcing userspace to cache the
> entire contents of all the directories it wishes to watch doesn't scale
> well.

The dnotify cache isn't just an optional performance tweak, caching
inode to name.  It's an essential tracking of much of the stat
information of any file of interest, in order to have _any_ way of
detecting which file changed.

The inotify cache could just have the last few most recently used
entries or some such - it's just a space vs time performance tradeoff.

So passing back an inode number doesn't come close to reintroducing
the forced tracking of all the interesting stat data of every file.

> dnotify already forces an O(N) workload per directory onto
> userspace, and that has shown itself to not work well.

Just because there exists an O(N) solution that has been shown to fail
doesn't mean all O(N) solutions fail.  If the constants change enough,
then the actual numbers (how many changes per minute, how many compute
cycles and memory bytes, what's the likely cache hit rate for a given
size cache, ...) need to be re-examined.  I see no evidence of that
re-examination -- am I missing something?

> getdents(2) seems to work somehow.

Yeah ... but we had to walk up hill, both ways, through 9 foot snow
drifts, for years, summer and winter, to get there ;).

> the kernel *has* that information already, ...

Frustrating, isn't it.  The information is right there, and we're trying
to keep you from getting to it.

Whatever ...

> Off to do honest work,

Good idea.  Good luck with this.  I rest my case, such as it be.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
