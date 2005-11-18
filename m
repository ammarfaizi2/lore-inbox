Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbVKRINx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVKRINx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVKRINx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:13:53 -0500
Received: from gold.veritas.com ([143.127.12.110]:3752 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964883AbVKRINw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:13:52 -0500
Date: Fri, 18 Nov 2005 08:12:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
In-Reply-To: <20051118.000414.10534984.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0511180809250.5788@goblin.wat.veritas.com>
References: <437D6AD0.5080909@yahoo.com.au> <20051117.224516.118147408.davem@davemloft.net>
 <Pine.LNX.4.61.0511180724060.5435@goblin.wat.veritas.com>
 <20051118.000414.10534984.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2005 08:13:52.0474 (UTC) FILETIME=[0310F3A0:01C5EC18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, David S. Miller wrote:
> 
> The recent vbetool suspend-from-ram datapoint shows that it might be
> important that the BIOS data area is application local,
> ie. MAP_PRIVATE.  Ie. it works only if the writes are not performed
> to the real BIOS data page.

Interesting.  I haven't dared reach that conclusion yet.

> If true, that means the MAP_PRIVATE+VM_UNPAGED case has legit users.
> Although, such applications could just copy the interrupt vector plus
> BIOS data area into an anonymously mapped region and have the vm86
> execution work off that instead of the /dev/mem mapping.

Yes, they could indeed.  Would save the kernel contortions.

> So, just to make sure this all adds up, a PROT_WRITE+MAP_PRIVATE
> mapping of /dev/mem results in any pages written to being COW'd.
> Right?

Yes, in everything before 2.6.15-rc1, and again with my patches.

> It is a good question as to which cases doing stuff like this want to
> make modifications to the real BIOS data area, and which ones do not.
> Aparently vbetool does not.

Hugh
