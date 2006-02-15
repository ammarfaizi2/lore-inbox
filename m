Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423003AbWBOHMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbWBOHMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423007AbWBOHMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:12:16 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:6276 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423003AbWBOHMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:12:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=unKID3XVOhPEK4KgG8Cdj0kfu1kwm3O0gyPLDQyj0Men2bA80unXJJo4oKhGuqsp7C5utcoYgdXsp1ODJ774yx0g3tFWdw9UqwdTrkg5AMck7YySXYEOONcTXwoRvA8wUutThNZXAH+a+mhbQjGAtKKv2h4CSamfN0d6BiaQKK8=  ;
Message-ID: <43F2CB2A.7000909@yahoo.com.au>
Date: Wed, 15 Feb 2006 17:33:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: hawkes@SGI.com
CC: Suresh Siddha <suresh.b.siddha@intel.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@SGI.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] load_balance: "busiest CPU" -> "busier CPUs"
References: <20060207012729.8707.66350.sendpatchset@tomahawk.engr.sgi.com>
In-Reply-To: <20060207012729.8707.66350.sendpatchset@tomahawk.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hawkes@SGI.com wrote:
> Second try, incorporating Suresh Siddha's suggestion to avoid adding
> a field to the runqueue struct.
> 

Sorry for not getting back to you earlier.

Looks like it should work, although bviously exclusive cpusets are
still the preferred way to do exclusive partitioning. Not sure what
the others think about adding complexity and overhead for a
relatively uncommon case, I'm not a huge fan.

I have a suggestion for an improvement - cycle through all CPUs
in the busiest group before moving on to find_busiest_group again?

Do you really need the schedstat field? You'll have to bump the
schedstat version.

The idea I had when thinking about how to handle this, is to have
something like your `consider_cpus` field in the sched domain
itself (which can help you not do too much work at one time, but
will have other complexities like when to reset the mask).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
