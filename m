Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423254AbWKFCTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254AbWKFCTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 21:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423265AbWKFCTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 21:19:34 -0500
Received: from pop-altamira.atl.sa.earthlink.net ([207.69.195.62]:18308 "EHLO
	pop-altamira.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1423254AbWKFCTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 21:19:33 -0500
Message-ID: <454E9BAC.1000009@cfl.rr.com>
Date: Sun, 05 Nov 2006 21:19:24 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jun Sun <jsun@junsun.net>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?
References: <20061102021547.GA1240@srv.junsun.net> <454A1D82.7040709@cfl.rr.com> <1162486642.14530.64.camel@laptopd505.fenrus.org> <454A4237.90106@cfl.rr.com> <1162498205.14530.83.camel@laptopd505.fenrus.org> <454A627C.1090104@cfl.rr.com> <1162505945.14530.98.camel@ <20061102231715.GA10902@srv.junsun.net>
In-Reply-To: <20061102231715.GA10902@srv.junsun.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Sun wrote:
> Perhaps a better solution is to 
> 
> 1. get rid of DMA zone
> 
> 2. have another alloc funciton (e.g., kmalloc_range()) which takes an
>    extra pair of parameters to indicate the desired range for the
>    allocated memory.  Most DMA buffers are allocated during start-up.
>    So the alloc operations should generally be successful.
> 
> 3. convert drivers over to use the new function.
> 
> Cheers.
> 
> Jun
>    are allocated at start-up time.

That is what I was thinking.  You don't need lots of separate pools, you 
just need the standard allocator to prefer higher addresses, and then 
the bounce routines need to simply check if the existing user buffer 
happens to already be within the area the hardware can address ( which 
it often will be ), and if not, copy the data to pages allocated in 
lower memory.


