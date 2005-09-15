Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVIOAaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVIOAaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:30:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5103 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932495AbVIOAaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:30:23 -0400
Message-ID: <4328C094.8060508@in.ibm.com>
Date: Wed, 14 Sep 2005 19:30:12 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <43278116.8020403@in.ibm.com> <432835B4.7070405@tmr.com>
In-Reply-To: <432835B4.7070405@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> Let me say that this solution, and any other which loops through all 
> threads of a task, isn't going to scale well. I don't have a magic O(1) 
> solution, if it were easy someone would have done that instead of the 
> while loop, just noting that a clever solution would be a win on servers.

Bill,

We will only have to go through the while loop in rare cases where main 
thread has done pthread_exit() before other threads (and hence it's task->fs 
is null). Also, even in most such cases, the very first iteration through 
the while loop  will get us the 'fs' pointer, so we won't have to loop 
through all threads. So I think this won't have scalability problem. Am I right?

Thanks,
Sripathi.
