Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUCXQwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbUCXQwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:52:18 -0500
Received: from gamemakers.de ([217.160.141.117]:16857 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S263771AbUCXQwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:52:17 -0500
Message-ID: <4061BD2E.2060900@gamemakers.de>
Date: Wed, 24 Mar 2004 17:54:06 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
References: <4061986E.6020208@gamemakers.de>	 <1080142815.8108.90.camel@localhost.localdomain> <1080146269.23224.5.camel@vertex>
In-Reply-To: <1080146269.23224.5.camel@vertex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:

[snip]
> Maybe adding a rate limiter on these write events would be a better
> idea, live updates are usefull for the desktop. Also with a netlink
> socket I think the overhead of many events would drop siginificantly.
> 
You could always merge read/write events if you get too many of them. 
E.g. write [10,11] + write [11,12] => write [10,12]. But I never had 
event buffer overflows with my tests. And a buffer of a few kbytes per 
file system for fam won't be that bad, so I am not sure wether it is 
nessecary to do something as complicated as rate limiting or merging.

> Also a couple other items I think need to be on the list of features,
> 
> * Some way to not have an open file descriptor for each directory you
> are monitoring. This causes so many problems when unmounting, and this
> is really the most noticable problem for the user.
> 
You can monitor a whole tree with a single file descriptor. But you need 
at least one open fd per file system, so it would indeed be a problem 
when unmounting.

> * Better event vocabulary, we should fire events for all VFS ops. I
> think right now it is limited to delete,create,written to. It would be
> good to tell the listener exactly what happened, moved,renamed, etc.
> 
I had this for a short time, but I threw it away since I wanted to 
concentrate on the event dispatch infrastructure first. It would not be 
a big problem to add this again.
