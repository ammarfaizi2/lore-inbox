Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269327AbUI3Qdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269327AbUI3Qdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUI3Qdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:33:39 -0400
Received: from mail.tmr.com ([216.238.38.203]:57606 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269327AbUI3QdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:33:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Consistent kernel hang during heavy TCP connection handling load
Date: Thu, 30 Sep 2004 12:34:35 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhc2d$5na$1@gatekeeper.tmr.com>
References: <20040926174217.GB18172@atrey.karlin.mff.cuni.cz> <NFBBICMEBHKIKEFBPLMCGEHFIJAA.aathan-linux-kernel-1542@cloakmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096561550 5866 192.168.12.100 (30 Sep 2004 16:25:50 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <NFBBICMEBHKIKEFBPLMCGEHFIJAA.aathan-linux-kernel-1542@cloakmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew A. wrote:
> Jan,
> 
> Thanks for responding.  When I got no responses, I searched for ways to get more data out of the kernel--I must say that it has been
> quite a journey to identify what is working, where to get it, and how to install it when it comes to kernel
> debugging/crash-data-gathering tools.  LKCD for example, is not available at the location you'll eventually arrive at if you search
> for it in google ... it's not obvious what it's state is (current/defunct/superceded), there's KDB, KGDB, netdump, netconsol,
> netlog, diskdump (conusingly known as lkdump) etc. etc.  And then, even if you do figure out what tools are current, you then have
> to match the tool to the particular kernel version you are running -- which can be a task and a half unto itself.
> 
> Is diskdump available for 2.4?  Can anyone comment on the choice of tools below?
> 
> Anyway, I have also done all of the following:
> 
> (1) Enabled netdump/netconsole on 2.6.8.1-521 Fedora Core kernel, after first fixing the startup scripts.  Fixes can be found at
> www.memeplex.com/Linux.html  Note that after I also fixed crash.c to be a 2.6 compliant kernel module, and loading it to test
> netdump, I always end up with a vmcore-incomplete image approx 45k in size, on the netdump-server.  Can anyone tell me if this is
> absurdly small, and if so, what might be the solution?  The client box always reboots so I suspect too-small timeouts are the issue.

My experience is 100% with RH kernels, but the dump should be about 
memory size, in my case 2.5G or 4G and it is. But I did see hangs which 
resulted in the size you mention, a few k and hang.

There was a patch floating around to write a core image to a disk 
partition like Solaris, AIX, and other commercial systems, but Linus was 
opposed for some reason I remember as "I don't need this and it culd be 
dangerous" or similar. If that can be retrofitted to a current kernel it 
would be more useful than netdump, I suspect.

In any case, the short answer is that what you see is way too short, it 
sounds like the header info on config, registers, or somesuch that 
netdump sends first before the core.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
