Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUDCWs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUDCWs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:48:28 -0500
Received: from pxy3allmi.all.mi.charter.com ([24.247.15.42]:14756 "EHLO
	proxy3-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262020AbUDCWsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:48:24 -0500
Message-ID: <406F3F2D.20301@quark.didntduck.org>
Date: Sat, 03 Apr 2004 17:48:13 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] more i386 head.S cleanups
References: <406ECAE7.1020407@quark.didntduck.org> <20040403160226.GY6248@waste.org>
In-Reply-To: <20040403160226.GY6248@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Sat, Apr 03, 2004 at 09:32:07AM -0500, Brian Gerst wrote:
> 
>>- Move empty_zero_page and swapper_pg_dir to BSS.  This requires that 
>>BSS is cleared earlier, but reclaims over 3k that was lost due to page 
>>alignment.
>>- Move stack_start, ready, and int_msg, boot_gdt_descr, idt_descr, and 
>>cpu_gdt_descr to .data.  They were interfering with disassembly while in 
>>.text.
> 
> 
> Nice. Do you mean 3k here or 0x3000? 

3 kilobytes apporiximately.  Most of the first page was wasted because 
swapper_pg_dir aligns to the start of the next page.

> 
> On a related note, I've been sitting on this patch which reorders the
> bootstrap code so we can free most of it once we're up:
> 

The bootstrap page tables can easily be reclaimed if large pages are 
used, but the bootstrap code needs more care, especially with hotplug cpus.

--
				Brian Gerst
