Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267821AbUHEUbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267821AbUHEUbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHEUbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:31:51 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41856 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267821AbUHEUbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:31:37 -0400
Message-ID: <411299D4.5060001@tmr.com>
Date: Thu, 05 Aug 2004 16:34:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
References: <Pine.LNX.4.44.0408051302330.8229-100000@dhcp83-102.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408051302330.8229-100000@dhcp83-102.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> The patch below implements RSS ulimit enforcement for 2.6.8-rc3-mm1.
> It works in a very simple way: if a process has more resident memory
> than its RSS limit allows, we pretend it didn't access any of its
> pages, making it easy for the pageout code to evict the pages.
> 
> In addition to this, we don't allow a process that exceeds its RSS
> limit to have the swapout protection token.
> 
> I have tested the patch on my system here and it appears to be working
> fine.

You have had better luck getting that to compile than I have, but I'm 
still working on it. I assume that the note about sched compiling with 
SMP set will get me going.

Wish there was something like RSS for cache, so that one process reading 
every inode on the planet, or doing an md5 on an 11GB file wouldn't push 
every damn process out if it's waiting for me to finish typing a line...

I did a brute force patch for 2.4.18 to limit the total memory used for 
cache, but it would sure be nice to just limit by process. Yes I know 
cache is shared, I have looked at this before :-(

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
