Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWJWFHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWJWFHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWJWFHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:07:54 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:31421 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751496AbWJWFHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:07:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=L3+DVLgAcpAOIHaIYrsQKucXmUWteDdDLKmUW9bY/bM8EN8gPpatbGw1VrT0Ev+qIOHrUE36Pszt94TfgShO1FYZqL7tOSjoDGOd5m3xuN8tX6OYvuD25DYC+OLzjz6hksBRL2YX57gGxfOdqly5leZ9emsNZLyKOZ3zLG4AELo=  ;
Message-ID: <453C4E22.9000308@yahoo.com.au>
Date: Mon, 23 Oct 2006 15:07:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<20061020210422.GA29870@in.ibm.com> <20061022201824.267525c9.pj@sgi.com>
In-Reply-To: <20061022201824.267525c9.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Dinakar wrote:
> 
>>IMO this patch addresses just one of the requirements for partitionable
>>sched domains
> 
> 
> Correct - this particular patch was just addressing one of these.
> 
> Nick raised the reasonable concern that this patch was adding something
> to cpusets that was not especially related to cpusets.

Did you send resend the patch to remove sched-domain partitioning?
After clearing up my confusion, IMO that is needed and could probably
go into 2.6.19.

> So I will not be sending this patch to Andrew for *-mm.
> 
> There are further opportunities for improvements in some of this code,
> which my colleague Christoph Lameter may be taking an interest in.
> Ideally kernel-user API's for isolating and partitioning sched domains
> would arise from that work, though I don't know if we can wait that
> long.

The sched-domains code is all there and just ready to be used. IMO
using the cpusets API (or a slight extension thereof) would be the
best idea if we're going to use any explicit interface at all.

A cool option would be to determine the partitions according to the
disjoint set of unions of cpus_allowed masks of all tasks. I see this
getting computationally expensive though, probably O(tasks*CPUs)... I
guess that isn't too bad.

Might be better than a userspace interface.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
