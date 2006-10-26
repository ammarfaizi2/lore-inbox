Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423305AbWJZMDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423305AbWJZMDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423306AbWJZMDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:03:34 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:52872 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423305AbWJZMDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:03:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CSJ6pMjbQL7KrpnKf48HgbTwBRrQF7giIctf3DPuCDpGJLXcYGfjd0rdpvGOCS5KXNRGiVLfW8DH2bD1cZX7phzzVZlNYLOKQ9RsS5FrNfJSxtNXzSVcX0T4TsNNt6lWFMLSBtL2+2CYe8KZzz+nyeZEsPoT4F77VNrNps2lzWc=  ;
Message-ID: <4540A404.5090406@yahoo.com.au>
Date: Thu, 26 Oct 2006 22:03:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 2/5] Extract load calculation from rebalance_tick
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com> <20061024183114.4530.95231.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183114.4530.95231.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Extract load calculation from rebalance_tick
> 
> A load calculation is always done in rebalance_tick() in addition
> to the real load balancing activities that only take place when certain
> jiffie counts have been reached. Move that processing into a separate
> function and call it directly from scheduler_tick().

Ack for this one.

> 
> Also extract the time slice handling from scheduler_tick and
> put it into a separate function. Then we can clean up scheduler_tick
> significantly. It will no longer have any gotos.

'time_slice' should be static, and it should be named better, and you
may as well also put the "task has expired but not rescheduled" part
in there too. That is part of the same logical op (which is to resched
the task when it finishes timeslice).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
