Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWGID0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWGID0K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWGID0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:26:10 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:12479 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964923AbWGID0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:26:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ekdqOSNki1K8wDxrHwzYkzPj1nR58YQCr9mWxmDAQ+c0m+o6KZJXhZGppo+LiL2ExsMRXpIKBYt/Ti6/cp3dOmuoT1ajQQApX2nlg6Hl6XZH8kxU7mItvD/ZG1FkJAi1sBDosSsiZtahBolIoKcCuHkp1K6RsPsVX3Z/znEp3VY=  ;
Message-ID: <44B0774E.5010103@yahoo.com.au>
Date: Sun, 09 Jul 2006 13:26:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
References: <20060709000703.GA9806@cerise.buici.com>
In-Reply-To: <20060709000703.GA9806@cerise.buici.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> I'm investigating why I am triggering a BUG_ON in split_page() when I
> use the sound subsystems dma memory allocation aide.
> 
> The crux of the problem appears to be that snd_malloc_dev_pages()
> passes __GFP_COMP into dma_alloc_coherent().  On the ARM and several
> other architectures, the dma allocation code calls split_page () with
> pages allocated with this flag which, in turn, triggers the BUG_ON()
> check for the CompoundPage flag.
> 
> So, the questions are these: Who is doing the wrong thing?  Should the
> snd_malloc_dev_pages() call drop the __GFP_COMP flag?  Should
> split_page() allow the page to be compound?  Should __GFP_COMP be 0 on
> ARM and other architectures that don't support compound pages?

I personally never liked the explicit __GFP_COMP going in everywhere,
and would have much preferred a GFP_USERMAP, which the architecture /
allocator could satisfy as they liked.

As a hack, you can make arm's dma_alloc_coherent() drop __GFP_COMP,
which should work.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
