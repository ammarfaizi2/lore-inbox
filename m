Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTEIQxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTEIQxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:53:34 -0400
Received: from watch.techsource.com ([209.208.48.130]:7374 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263298AbTEIQxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:53:33 -0400
Message-ID: <3EBBE10C.4060900@techsource.com>
Date: Fri, 09 May 2003 13:10:36 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: A way to shrink process impact on kernel memory usage?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the things that's been worked on to reduce kernel memory usage 
for processes is to shrink the kernel stack from 8k to 4k.  I mean, it's 
not like you could shrink it to 6k, right?  Well, why not?  Why not 
allocate an 8k space and put various process-related data structures at 
the beginning of it?  Sure, a stack overflow could corrupt that data, 
but a stack overflow would be disasterous anyhow.

I'm sure that, in addition to the memory allocated by kmalloc, some data 
structures are also allocated to track it so that you can know what to 
free when you use kfree, right?  Well, combining a few things this way 
would save a few bytes there too.

Also, if you're really worried about overflow, or you want a guard page 
or whatever, then put the data structures at the end and set the initial 
stack pointer appropriately.

Someone complained about a process structure already being too bloated. 
  Unless it's several K in size already, you can bloat it up all you 
please this way.

Another advantage is that you could make the datastructures growable. 
The stack grows down, and the data grows up.  As long as they don't 
meet, all is well.

