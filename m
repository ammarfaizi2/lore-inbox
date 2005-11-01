Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVKAKXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKAKXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKAKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 05:23:45 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24464 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750727AbVKAKXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 05:23:45 -0500
Message-ID: <436741EC.9080109@jp.fujitsu.com>
Date: Tue, 01 Nov 2005 19:22:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org,
       kravetz@us.ibm.com, raybry@mpdtxmail.amd.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       haveblue@us.ibm.com, magnus.damm@gmail.com, pj@sgi.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com> <20051031192506.100d03fa.akpm@osdl.org>
In-Reply-To: <20051031192506.100d03fa.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christoph Lameter <clameter@sgi.com> wrote:
> 
>>This is a patchset intended to introduce page migration into the kernel
>> through a simple implementation of swap based page migration.
>> The aim is to be minimally intrusive in order to have some hopes for inclusion
>> into 2.6.15. A separate direct page migration patch is being developed that
>> applies on top of this patch. The direct migration patch is being discussed on
>> <lhms-devel@lists.sourceforge.net>.
> 
> 
> I remain concerned that it hasn't been demonstrated that the infrastructure
> which this patch provides will be adequate for all future applications -
> especially memory hot-remove.
>
 > So I'll queue this up for -mm, but I think we need to see an entire
 > hot-remove implementation based on this, and have all the interested
 > parties signed up to it before we can start moving the infrastructure into
 > mainline.
 >

It looks Christoph didn't use (direct)memory migration core in this set,
so memory-hotremove will not be affected by this.

At the first look, memory hotplugger will just replace swap_page()
with migrate_onepage().

Comparing swap-based migration and memory hotremove, memory hotremove
has to support wider kinds of pages other than anon, file-cache
swap-cache, mlocked() page used by direct I/O, HugeTLB pages and achieve
close to 100% guaranntee. Ignoring the fact migration and hotremove will
share the code, what they have to do is very different.

swap-based approach looks just intend to do process migration and
it itself looks not bad.

I think your point is that hotremove and migration will share some amounts of codes.
We are now discussing *direct* page migration and will share codes for anon pages.
It is being discussed in -lhms. We'd like to create good one.

Thanks,
-- KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

