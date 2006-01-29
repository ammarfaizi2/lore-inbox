Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWA2U2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWA2U2e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWA2U2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:28:33 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:45452 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751164AbWA2U2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:28:33 -0500
Message-ID: <43DD2571.4020805@cosmosbay.com>
Date: Sun, 29 Jan 2006 21:28:33 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com> <m17j8jfs03.fsf@ebiederm.dsl.xmission.com> <20060128235113.697e3a2c.akpm@osdl.org> <200601291620.28291.ioe-lkml@rameria.de> <20060129113312.73f31485.akpm@osdl.org> <43DD1FDC.4080302@cosmosbay.com> <20060129200504.GD28400@kvack.org>
In-Reply-To: <20060129200504.GD28400@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise a écrit :
> On Sun, Jan 29, 2006 at 09:04:44PM +0100, Eric Dumazet wrote:
>> Chasing some invalid accesses to .init zone, I found that free_init_pages() 
>> was properly freeing the pages but virtual was still usable.
> 
> This change will break the large table entries up, resulting in more TLB 
> pressure and reducing performance, and so should only be activated as a 
> debug option.

Hum... yet another CONFIG option ?

Could we 'just' move rodata (because of CONFIG_DEBUG_RODATA) and .init section 
   in their own 2MB/4MB page, playing with vmlinux.lds.S ?

It would be possible to have a full hugepage readonly for rodata,  and a full 
NOPROT for .init ?

Eric
