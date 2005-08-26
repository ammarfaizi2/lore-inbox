Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVHZRE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVHZRE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbVHZREF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:04:05 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16627 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965136AbVHZRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:03:57 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, george@mvista.com, rml@novell.com,
       akpm@osdl.org, johannes@sipsolutions.net
Content-Type: text/plain
Organization: 
Message-Id: <1125075832.2783.99.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Aug 2005 13:03:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I'm answering this from my home email. I have not heard from my
co-workers in Florida yet, and I imagine that they are busy cleaning up
after hurricane Katrina and waiting for the power to come back on.

It looks like we have an "off by one" problem with idr_get_new_above()
which may be part of the inotify problem.  I'm not sure if the problem
is the behavior or the name & comments.  The start_id parameter is the
starting point for the idr allocation search, and if it is available, it
will be allocated.  If you pass in the last id allocated as the start_id
and it has already been freed (by an idr_remove call), it will be
allocated again.  The obvious fix would be to increment start_id
in idr_get_new_above().

I would be glad to spend some time looking at the inotify problem
assuming that fixing the off-by-one problem above doesn't solve
it.  I have not used inotify and would need pointers to the user
space header files and library.

Jim








