Return-Path: <linux-kernel-owner+w=401wt.eu-S965066AbXAMHzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbXAMHzK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 02:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbXAMHzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 02:55:10 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:32928 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965076AbXAMHzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 02:55:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xgcudJOuG9HFELVxYLoSSYDl2tqlmfAzw/D7Af74GbnnQp4FeM1k68p1tozK+VLczBjbUwf8/AWAVFVo57SYQsVhk1i2zfwFDwau2QxXjFGlXCNFeeiMk6Ls3pHPEqDbb5OTBryB7F232A/lLaFhliyZKDYb7FhxStvuANtaBBQ=  ;
X-YMail-OSG: SYFvwAcVM1nsL.oMuaTIXtsqpNUAdNp.WurJ_yh9WuTPpnuUlJYDgroq3B0G9wIY3opNt.uC_cSDzcfB94Nkkcpenbklz8cthupHPsOm.o4qzLxIVntjer_yAJlrVqBzm67jso7RHOxe9N_KoUDBzdFI4Lha3fRuGaPx.MPbXQzyUB2ThJFECZ_T_MJgqrphmofC8RjafSIe19g-
Message-ID: <45A89008.2030408@yahoo.com.au>
Date: Sat, 13 Jan 2007 18:53:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
References: <20070112160104.GA5766@localhost.localdomain> <45A86291.8090408@yahoo.com.au> <20070113073643.GA4234@localhost.localdomain>
In-Reply-To: <20070113073643.GA4234@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> On Sat, Jan 13, 2007 at 03:39:45PM +1100, Nick Piggin wrote:

>>What is the "CS time"?
> 
> 
> Critical Section :).  This is the maximal time interval I measured  from 
> t2 above to the time point we release the spin lock.  This is the hold 
> time I guess.
> 
> 
>>It would be interesting to know how long the maximal lru_lock *hold* time 
>>is,
>>which could give us a better indication of whether it is a hardware problem.
>>
>>For example, if the maximum hold time is 10ms, that it might indicate a
>>hardware fairness problem.
> 
> 
> The maximal hold time was about 3s.

Well then it doesn't seem very surprising that this could cause a 30s wait
time for one CPU in a 16 core system, regardless of fairness.

I guess most of the contention, and the lock hold times are coming from
vmscan? Do you know exactly which critical sections are the culprits?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
