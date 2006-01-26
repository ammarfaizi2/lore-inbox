Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWAZOoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWAZOoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWAZOoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:44:34 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:24583 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751348AbWAZOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:44:34 -0500
Message-ID: <43D8E023.8080504@symas.com>
Date: Thu, 26 Jan 2006 06:43:47 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <43D7CAAB.9070008@yahoo.com.au> <43D7D234.6060005@symas.com> <43D88D7B.1030204@yahoo.com.au> <E47694FE-571C-40BC-B247-2AC3EEBDA63C@mac.com>
In-Reply-To: <E47694FE-571C-40BC-B247-2AC3EEBDA63C@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> Haven't you OpenLDAP guys realized that the pthread model you're 
> actually looking for is this?  POSIX mutexes are not designed to 
> mandate scheduling requirements *precisely* because this achieves your 
> scheduling goals by explicitly stating what they are.

This isn't about OpenLDAP. Yes, we had a lot of yield() calls scattered 
through the code, leftovers from when we only supported non-preemptive 
threading. Those calls have been removed. There are a few remaining, 
that are only in code paths for unusual errors, so what they do has no 
real performance impact.

The point of this discussion is that the POSIX spec says one thing and 
you guys say another; one way or another that should be resolved. The 
2.6 kernel behavior is a noticable departure from previous releases. The 
2.4/LinuxThreads guys believed their implementation was correct. If you 
believe the 2.6 implementation is correct, then you should get the spec 
amended or state up front that the "P" in "NPTL" doesn't really mean 
anything.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

