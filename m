Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUFCNx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUFCNx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUFCNx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:53:57 -0400
Received: from mail.tmr.com ([216.238.38.203]:33294 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263641AbUFCNxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:53:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: why swap at all?
Date: Thu, 03 Jun 2004 09:54:16 -0400
Organization: TMR Associates, Inc
Message-ID: <c9naac$ps4$1@gatekeeper.tmr.com>
References: <200406012022.i51KMFEB002660@turing-police.cc.vt.edu> <1086124536.2278.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086270604 26500 192.168.12.100 (3 Jun 2004 13:50:04 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1086124536.2278.52.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:

> 	As I said, I think this thread is "becoming offtopic" but what can be
> interesting is the swapping problem fragmentation :
> 
> 	1.Global inactivity (what you're talking about)
> 	2.Application isolation (what we're talking about).
> 
> Geek or not, someone backgrounding an application doesn't want it to
> down the box for X seconds some minutes later when it comes back and
> such things arrive many times a day.Maybe you've got an idea about a
> better rule(s) then ? (I mean for the 2 cases)

Maybe what we need is a per-process tuner like nice, for swap candidacy. 
Unfortunately doing it right is probably 2.7 material, you want users to 
be able to set it DOWN for seldom used things, but not UP where they 
could hog the system. And I think 'right' also means having a capability 
for setting it UP again, etc.

Note that there are some hooks which *might* be useful for quick user, 
there is a sticky bit which seems pretty unused in practice, and which 
might cause pages to be marked less likely to swap. You could implement 
in exec() to do the setting, with whatever access control seems useful.

Just a thought, I'm pretty well convinced that Nick's latest patches 
have reduced the problem, at least for me. I'll try to get some metrics 
on the measured effect, but the "feel" is better by far.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
