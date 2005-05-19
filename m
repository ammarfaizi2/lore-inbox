Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVEUTkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVEUTkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEUTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 15:40:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46183 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261650AbVEUTkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 15:40:47 -0400
Date: Thu, 19 May 2005 18:48:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Guo Racing <racing.guo@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] porting lockless mce from x86_64 to i386
In-Reply-To: <1116495706.18666.55.camel@guorj.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0505191834480.13030@goblin.wat.veritas.com>
References: <1116495351.18666.47.camel@guorj.sh.intel.com> 
    <1116495706.18666.55.camel@guorj.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 21 May 2005 19:40:42.0459 (UTC) 
    FILETIME=[F95CE2B0:01C55E3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Guo Racing wrote:

> Lockless MCE(machine check exception) is ported from
> x86-64 to i386. This patch is for implementation.

You seem to be missing most of the issues people raise:
perhaps your spamfilter is too eager.

Where is Brice Goglin's #include <asm/apic.h> in mce_intel.c?

i386 machine_check_init misses calling mcheck_init in Intel
and Centaur cases, so a lot of the code is largely untested.

You need to avoid the P6 and AMD problems with bank0,
as the replaced code did.

I fear there may be more.

Hugh
