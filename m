Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030693AbWJDBq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030693AbWJDBq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030695AbWJDBq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:46:57 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:22870 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030693AbWJDBq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:46:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QPCFFufW/77zMqlfzsEazJzNpB05K/3KbXbnr3PCyFI5SyLpqO3rGA7sugjZ4EJqM5gqb2ECa2Gco/8yxrsRhfwxuWCM7ElyCd0JmPJD8hoeTQmrfHslU8VGVFldplxkAbpsSG2lX4pDlAFiJK+GGEAZtk454jAsmShl1aa8wqU=  ;
Message-ID: <45231299.1000601@yahoo.com.au>
Date: Wed, 04 Oct 2006 11:47:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <1159916644.8035.35.camel@localhost.localdomain>	<20061003170705.6a75f4dd.akpm@osdl.org>	<1159920569.8035.71.camel@localhost.localdomain> <20061003181452.778291fb.akpm@osdl.org>
In-Reply-To: <20061003181452.778291fb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 03 Oct 2006 17:09:29 -0700
> Tim Chen <tim.c.chen@linux.intel.com> wrote:
> 
> 
>>On Tue, 2006-10-03 at 17:07 -0700, Andrew Morton wrote:
>>
>>
>>>Perhaps the `static int __warn_once' is getting put in the same cacheline
>>>as some frequently-modified thing.   Perhaps try marking that as __read_mostly?
>>>
>>
>>I've tried marking static int __warn_once as __read_mostly.  However, it
>>did not help with reducing the cache miss :(
>>
>>So I would suggest reversing the "Let WARN_ON/WARN_ON_ONCE return the
>>condition" patch.  It has just been added 3 days ago so reversing it
>>should not be a problem.
>>
> 
> 
> Not yet, please.  This is presently a mystery, and we need to work out
> what's going on.

Still, it seems kind of odd to add this IMO. Especially the WARN_ON_ONCE
makes the if statement less readable.

   if (WARN_ON_ONCE(blah)) {
   }

What does that mean? Without looking at the implementation, that says
the condition is true at most once, when the warning is printed.

What's wrong with adding WARN and WARN_ONCE, and eating the single extra
line? You're always telling people to do that with assignments (which I
agree with, but are _more_ readable than this WARN_ON_ONCE thing).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
