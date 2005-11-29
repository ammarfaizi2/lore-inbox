Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVK2GzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVK2GzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVK2GzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:55:15 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:42842 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751328AbVK2GzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:55:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r8fxECqZVO/sQJBNnqzYLtQ/JNmdJNwycEmbnnpowtZgV8dLBdoF5E1aGcz2zSVcz6KLiYnNOQ2QLI3cA5WqONa4WyaMuMchLkYGSJPMVmupP/SIDUJkp25fEQVvCakyL27Z3Py426rvXMIDl7ldVdOllcooowG0xFUspowvWL4=  ;
Message-ID: <438BFB44.2080208@yahoo.com.au>
Date: Tue, 29 Nov 2005 17:55:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
References: <20051118220755.GA3029@elte.hu> <1132353689.4735.43.camel@cmn3.stanford.edu> <1132367947.5706.11.camel@localhost.localdomain> <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu> <1133232503.6328.18.camel@localhost.localdomain> <20051128190253.1b7068d6.akpm@osdl.org> <1133235740.6328.27.camel@localhost.localdomain> <20051128200108.068b2dcd.akpm@osdl.org> <20051129064420.GA15374@elte.hu>
In-Reply-To: <20051129064420.GA15374@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>>The way to solve this was to set
>>> idle=poll.  The original patch I sent was to allow the user to change to
>>> idle=poll dynamically.  This way they could switch to the poll_idle and
>>> run there tests (requiring tsc not to drift) and then switch back to the
>>> default idle to save on electricity.
>>
>>Use gettimeofday()?
>>
>>If it's just for some sort of instrumentation, run NR_CPUS instances 
>>of a niced-down busyloop, pin each one to a different CPU?  That way 
>>the idle function doesn't get called at all..
> 
> 
> idle=poll is also frequently done for performance reasons [it reduces 
> idle wakeup latency by 10 usecs] - while it could be turned off if the 
> system has been idle for some time. E.g. cpufreqd could sample idle time 
> and turn on/off idle=poll. High-performance setups could enable it all 
> the time.
> 
> as long as it can be done with zero-cost, i dont see why Steven's patch 
> wouldnt be a plus for us. It's a performance thing, and having runtime 
> switches for seemless performance features cannot be bad.
> 

Why not just slightly cleanup and extend (eg. to ACPI) the
hlt_counter thingy that many architectures already have?

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
