Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWITSDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWITSDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWITSDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:03:37 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:7530 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750854AbWITSDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:03:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hSZgmY1C2X8S5Dx8KNGhpPjEjzp0krjxeTsyviewcLyyRKWznBGIvVnaOOkgbSVUD9cXnjVG1AEBfsKyuuVilIXJdhBxrg9cYqS9vqsVWY+zOxpd8L3VxsgaF4Z3TOCZxi2LdtHBt6n8xBT2qhB8WsTbqh085fYbvgZuZjXNoIo=  ;
Message-ID: <45118270.60901@yahoo.com.au>
Date: Thu, 21 Sep 2006 04:03:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: rohitseth@google.com, pj@sgi.com,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
References: <1158718568.29000.44.camel@galaxy.corp.google.com> <4510D3F4.1040009@yahoo.com.au> <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com> <451172AB.2070103@yahoo.com.au> <Pine.LNX.4.64.0609201006420.30793@schroedinger.engr.sgi.com> <45117830.3080909@yahoo.com.au> <Pine.LNX.4.64.0609201024310.31178@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609201024310.31178@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 21 Sep 2006, Nick Piggin wrote:
> 
> 
>>Patch 2/5 in this series provides hooks, and they are pretty unintrusive.
> 
> 
> Ok. We shadow existing vm counters add stuff to the adress_space 
> structure. The task add / remove is duplicating what some of the cpuset 
> hooks do. That clearly shows that we are just duplicating functionality.

I don't think so. To start with, the point about containers is they are
not per address_space.

But secondly, these are hooks from the container subsystem into the mm
subsystem. As such, they might do something a bit more or different
than simple statistics, and we don't want to teach the core mm/ about
what that might be. You also want to be able to configure them out
entirely.

I think it is fine to add some new hooks in fundamental (ie mm agnostic)
points. Without getting to the fine details about exactly how the hooks
are implemented, or what information needs to be tracked, I think we can
say that they are not much burden for mm/ to bear (if they turn out to
be usable).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
