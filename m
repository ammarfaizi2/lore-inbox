Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVJUFOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVJUFOD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 01:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVJUFOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 01:14:03 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53204 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964866AbVJUFOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 01:14:02 -0400
Message-ID: <435878E2.20506@jp.fujitsu.com>
Date: Fri, 21 Oct 2005 14:13:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: mike kravetz <kravetz@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org> <20051020234621.GL5490@w-mikek2.ibm.com> <43585EDE.3090704@jp.fujitsu.com> <20051021033223.GC6846@w-mikek2.ibm.com> <435866E0.8080305@jp.fujitsu.com> <20051021042207.GD6846@w-mikek2.ibm.com>
In-Reply-To: <20051021042207.GD6846@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike kravetz wrote:
>>yea, looks nice :)
>>But such pages are already shown as hotpluggable, I think.
>>ACPI/SRAT will define the range, in ia64.
> 
> 
> I haven't taken a close look at that code, but don't those just give
> you physical ranges that can 'possibly' be removed? 

It just represents pages are physically hotpluggable or not.

> So, isn't it
> possible for hotpluggable ranges to contain pages allocated for kernel
> data structures which would be almost impossible to offline?
> 
The range which contains kernel data isn't hot-pluggable.
So such range shouldn't contain the kernel pages.

As you say, it's very helpful to show how section is used.
But I think showing hotpluggable-or-not looks enough.(KERN mem is not hotpluggable)
Once a section turned to be KERN section, it's never be USER section, I think.

>>The difficulty is how to find hard-to-migrate pages, as Andrew pointed out.
> 
> 
> By examining the fragmentation usemaps, we have a pretty good idea about
> how the blocks are being used.  If a block is flagged as 'User Pages' then
> there is a good chance that it can be offlined.  
yes.

But 'search and find on demand' approach  is not good for the system admin
who makes system resizing plan.
Do you consider some guarantees to keep quantity or location of not-hottpluggable
memory section ?

-- Kame


