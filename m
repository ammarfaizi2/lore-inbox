Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUIXUZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUIXUZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbUIXUZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:25:09 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4054 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269122AbUIXUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:24:55 -0400
Message-ID: <4154828F.90407@nortelnetworks.com>
Date: Fri, 24 Sep 2004 14:24:47 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <41547C16.4070301@pobox.com>
In-Reply-To: <41547C16.4070301@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> How feasible is it to create an mlock(1) utility, that would allow 
> priveleged users to execute a daemon such that none of the memory the 
> daemon allocates will ever be swapped out?
> 
> ntp daemon does mlock(2) internally, for example, but IMHO this is 
> really a policy decision that could be moved out of the app.
> 
> Unfortunately I am VM-ignorant as always ;-)

I think you should be able to do this if you make a suid binary that

calls mlockall(MCL_CURRENT|MCL_FUTURE)
drops capabilities
exec()s the desired app


Note that fork()'d children are not locked, and that the apps may segfault if 
they try to write to newly allocated memory and there is no more left.  It will 
still be possible to segfault on newly allocated stack as well.  However, once 
the app aquires memory, it will not be paged out.

Chris
