Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVIOAbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVIOAbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:31:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17142 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932495AbVIOAbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:31:15 -0400
Message-ID: <4328C0D0.6000909@in.ibm.com>
Date: Wed, 14 Sep 2005 19:31:12 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <20050914015003.GW25261@ZenIV.linux.org.uk>
In-Reply-To: <20050914015003.GW25261@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, Sep 13, 2005 at 04:10:21PM -0700, Linus Torvalds wrote:
> 
>>I don't think this is wrong per se, but you shouldn't take the tasklist 
>>lock normally. You're better off just doing
> 
> 
> Could you exlain why we might want to bother with that in the first place?
> In any case, why would we want to put that stuff on the common codepath
> instead of specialized ->permission()?
> 
Al,

I can move this code from proc_root_link() to proc_check_root(), but it will 
still not be completely limited to ->permission() path. I can create a 
separate ->permission() for proc_task_inode_operations, and have this 
additional code there. If I do that, I think I will have to duplicate much 
of proc_check_root(). Or else, I will have to split proc_check_root() into 
two functions to prevent code duplication. Please let me know if any of 
these makes sense, and I will send another patch.

If you don't like this idea at all, please let me know if there any other 
way of solving the invisible threads problem, short of taking out 
->permission() altogether from proc_task_inode_operations.

Thanks,
Sripathi.
