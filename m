Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVJFVRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVJFVRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVJFVRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:17:54 -0400
Received: from mail.weatherflow.com ([65.57.243.55]:61967 "EHLO
	weatherflow.com") by vger.kernel.org with ESMTP id S1750844AbVJFVRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:17:53 -0400
Message-ID: <43459458.9080808@weatherflow.com>
Date: Thu, 06 Oct 2005 17:17:12 -0400
From: Robert Derr <rderr@weatherflow.com>
User-Agent: Thunderbird 1.4 (Windows/20050908)
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: linux-kernel@vger.kernel.org, amitarora@in.ibm.com, suzukikp@in.ibm.com,
       torvalds@osdl.org
Subject: Re: 2.6.13.3 Memory leak, names_cache
References: <200510062003.j96K3In0016900@owlet.beaverton.ibm.com>
In-Reply-To: <200510062003.j96K3In0016900@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: rderr@weatherflow.com
X-Spam-Processed: weatherflow.com, Thu, 06 Oct 2005 17:17:15 -0400
	(not processed: message from valid local sender)
X-MDRemoteIP: 24.227.114.94
X-Return-Path: rderr@weatherflow.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> Are you running with CONFIG_AUDITSYSCALL?
>
> We ran into what sounds like the same problem and we're testing
> a patch right now for a names_cache growth which only occurs
> with CONFIG_AUDITSYSCALL enabled, and then only every time you
> traverse a symlink.  In open_namei(), in the do_link section, we call
> __do_follow_link() which will bypass the auditing whether it's enabled
> or not.  However at the end of this section, we will call putname(),
> which will *not* actually do a __putname() if auditing is enabled because
> it believes it will happen at syscall return.  So we slowly lose memory
> with each link traversal.
>
> The code in open_namei() is a bit non-intuitive in error conditions,
> but the general fix appears to be pretty straightforward.  Let me know if
> this patch seems to do the trick for you.
>
>
>   
Thanks Rick and Linus,

Rick, I put in your patch and after running for 15 minutes the system is 
holding steady at around 60-80 allocations.  Before it would have 
already have been up to a few thousand.  I'll know for sure tomorrow 
morning.

Thanks again for everyone's help,
Robert J Derr
Weatherflow, Inc.


