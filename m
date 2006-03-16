Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWCPDnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWCPDnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWCPDnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:43:47 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:24499 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932604AbWCPDnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:43:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nbL/rTGDCiqh09voMqOyoDEpewbpOJILlaegDQ6lZDaL8DVkngg1J18EMJZvWeASgh2dSxX5sJc+4+27QOo/o5aDjs4ebSq1Owdo+1ybup8isnIXYuJ1QjgyptMWS2A+MgGogj1wT43A3usGfKG1ydmH6DDJd3Cf0G1tcNazVsA=  ;
Message-ID: <4418DEEA.2000008@yahoo.com.au>
Date: Thu, 16 Mar 2006 14:43:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines for_each_possible_cpu
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> Now,
> for_each_cpu() is for-loop cpu over cpu_possible_map.
> for_each_online_cpu is for-loop cpu over cpu_online_map.
> .....for_each_cpu() looks bad name.
> 
> This patch renames for_each_cpu() as for_each_possible_cpu().
> 
> I also wrote patches to replace all for_each_cpu with for_each_possible_cpu.
> please confirm....
> 
> BTW, when HOTPLUC_CPU is not suppoted, using for_each_possible_cpu()
> should be avoided, I think.
> 
> all patches are against 2.6.16-rc6-mm1.
> 

for_each_cpu() effectively is for_each_possible_cpu() as far as
generic code is concerned. In other words, nobody would ever expect
for_each_cpu to return an _impossible_ CPU, thus you are just
adding a redundant element to the name.

The only places where things might care is arch bootup code, but
the cpu interface is such that the arch code is expected to _hide_
any weird details from these generic interfaces.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
