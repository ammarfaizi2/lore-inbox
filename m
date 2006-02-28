Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWB1SXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWB1SXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWB1SXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:23:22 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:20223 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S932376AbWB1SXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:23:22 -0500
Message-ID: <440494FC.9050400@nortel.com>
Date: Tue, 28 Feb 2006 12:22:52 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
References: <1140841250.2587.33.camel@localhost.localdomain> <20060225142814.GB17844@kvack.org> <1140887517.9852.4.camel@localhost.localdomain> <20060225174134.GA18291@kvack.org> <1141149009.24103.8.camel@camp4.serpentine.com> <20060228175838.GD24306@kvack.org>
In-Reply-To: <20060228175838.GD24306@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2006 18:22:54.0591 (UTC) FILETIME=[FE0000F0:01C63C93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Feb 28, 2006 at 09:50:08AM -0800, Bryan O'Sullivan wrote:
> 
>>The last 32-bit write triggers the chip to put the packet on the wire.
>>We make sure it happens after the earlier bulk write using a barrier.
> 
> 
> The barrier you're looking for is wmb() in asm/system.h, which is defined 
> on both SMP and UP.

That will synchronize with other CPUs as well, which may not necessarily 
be needed.

On PPC for instance, you could implement the desired semantics using 
"eieio" (enforce in-order execution of IO).  This is lighter weight than 
a full "sync", which is what wmb() maps to.

Chris
