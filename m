Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUJPBAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUJPBAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 21:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUJPBAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 21:00:06 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:5630 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268470AbUJPBAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 21:00:01 -0400
Message-ID: <4170728B.7060709@nortelnetworks.com>
Date: Fri, 15 Oct 2004 18:59:55 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <MDEHLPKNGKAHNMBLJOLKAEKCPAAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEKCPAAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	The CAVEAT is that 'select', like every other status information function
> provided by the kernel, does not guarantee anything about the future. Just
> like 'stat' does not guarantee that the file size will still be the same
> later when you call 'read'.

This is not a very good counterexample.  If I'm the only one accessing a file, 
then the file size should not just change all by itself.

As you say, select is level triggered.  However, the very definition of select 
returning a file descriptor as readable is that a subsequent read will not 
block.  This seems very straightforward.  Maybe it's not the best from a 
performance point of view, but it's very straightforward.

So if we change the semantics slightly to say that select returning readable 
really means a subsequent *blocking* read will not block, then apps that use 
blocking sockets will get proper semantics, and apps using nonblocking reads 
will get full performance.

As it stands, it's fairly straightforward to do a DOS and hang various apps with 
a single corrupt packet each.  This is suboptimal.

Chris
