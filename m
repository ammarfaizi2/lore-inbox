Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUCST2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbUCST2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:28:49 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:13235 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S263165AbUCST1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:27:43 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079704347.11057.130.camel@watt.suse.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>
	 <1079704347.11057.130.camel@watt.suse.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079724411.2576.178.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 19 Mar 2004 11:26:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 05:52, Chris Mason wrote:


> I am listening to Peter, Jens and I have spent a significant amount of
> time on this code.  We can go back and spend many more hours testing and
> debugging the 2.4 changes, or we can go forward with a very nice
> solution in 2.6.
> 
> I'm planning on going forward with 2.6

Chris, Hans

It is great to hear this is going to be fixed in 2.6, however it is
quite a pity we have a real mess with this in  2.4 series. 

Resuming what I've heard so far it looks like it depends on:

- If it is fsync/O_SYNC or O_DIRECT   (which user would expect to have
the same effect in this respect.
- It depends on kernel version. Some vendors have some fixes, while
others do not have them.
- It depends on hardware - if it has write cache on or off 
- It depends on type of write (if it changes mata data or not)
- Finally it depends on file system and even journal mount options

Just curious does at least Asynchronous IO have the same behavior as
standard IO ? 


All of these makes it extremely hard to explain what do users need in
order to get durability for their changes, while preserving performance.

Furthermore as it was broken for years I expect we'll have people which
developed things with fast fsync() in mind, who would start screaming
once we have real fsync() 

(see my mail about Apple actually disabling cache flush on fsync() due
to this reason) 




-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

