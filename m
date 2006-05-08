Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWEHEqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWEHEqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWEHEqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:46:18 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:58985 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932293AbWEHEqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:46:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1D4YzW5moG2SPWL7D8WHWEN+27csVu42aVwVTNfaZ8xiXNKNUcJL3iYFH4R0AzyFEJaCoI1r7GIjs+Z48E5X0eFk2T+FhqUCQBsYRe3iZJ87GDoG3WGEDpyzvlRGH7kSETCGl/KSz4/Y5DeUo2hYmRx3tn8J7Es9mo4/wLjM4dU=  ;
Message-ID: <445ECD10.1090506@yahoo.com.au>
Date: Mon, 08 May 2006 14:46:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk>	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>	 <1146640155.7526.27.camel@homer>  <445DE925.9010006@yahoo.com.au>	 <1147023122.13315.16.camel@homer>  <1147061696.8544.12.camel@homer> <1147063063.8809.7.camel@homer>
In-Reply-To: <1147063063.8809.7.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

>Sorry for yet another reply, but running the old starvation testcase
>that caused sched_clock() to be born in the first place tickled my
>funny-bone.  With that running and hitting 300k context switches...
>
>now: 2100508962835 tick: 2100508972067 stamp: 2100508961220 total: 2906
>now: 2101531243883 tick: 2101531251877 stamp: 2101531238543 total: 2924
>now: 2102695422392 tick: 2102695431699 stamp: 2102695418265 total: 2940
>
>Accounting?  Not :)
>

Yeah I agree with Andi that this accounting stuff is probably done
for some POSIX conformance that doesn't matter. Actually it is worse
than that because if anyone _really_ did need it, then they'll get a
horrible surprise when their system mysteriously fails in production.

It should either get ripped out, or perhaps converted to use jiffies
until a sane high resolution, low overhead scheme is developed (if
ever). And that would exclude something that does this accounting in
fastpaths for the 99.99% of processes that never use it.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
