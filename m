Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965373AbVKHDwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965373AbVKHDwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbVKHDwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:52:45 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:23634 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965373AbVKHDwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:52:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JWX/8TNtDTtqnrFnO3VXQdTHC7o429+hzqmi75CNX91Nv9a5Qj1v/BBYgdzSepdrcIwlsN12/pnpV8USuewXcrCBWcLHSC4wcMNC+6et1ntxF7PIcipci+PLQT1aGxye2LJFfZehy+feYvXcLTEpw1CXe/gVZ0vRy01Zqb48r6Y=  ;
Message-ID: <4370217F.3090807@yahoo.com.au>
Date: Tue, 08 Nov 2005 14:54:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Brian Twichell <tbrian@us.ibm.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, slpratt@us.ibm.com, anton@samba.org
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.61.0511071745020.28676@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511071745020.28676@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> 
> Can you change sched_yield() to usleep(1) or usleep(0) and see if
> that works. I found that in recent kernels sched_yield() just seems
> to spin (may not actually spin, but seems to with a high CPU usage).
> 

I've told you that it *does* spin and always has. Even with 2.4
kernels. In fact, it is *specified* to spin, anything else would
be a bug.

Caveat: it also yields the CPU, but only if there is another
runnable task with a higher priority (which is meaningless
between SCHED_OTHER tasks, though we try to do something sane
there too).

Secondly, Brian actually pinpointed the source of the
regression and it is not sched_yield(), nor has sched_yield
changed since the regression. So wouldn't this just be a wild
goose chase.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
