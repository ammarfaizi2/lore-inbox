Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbUKLXPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUKLXPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUKLXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:13:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:13067 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262662AbUKLXL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:11:27 -0500
Date: 13 Nov 2004 00:11:26 +0100
Date: Sat, 13 Nov 2004 00:11:26 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Schlichter <thomas.schlichter@web.de>, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: 2.6.10-rc1-mm4
Message-ID: <20041112231126.GC15853@muc.de>
References: <200411102333.03412.thomas.schlichter@web.de> <20041110150307.3a06cc1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110150307.3a06cc1d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kernel BUG at arch/i386/mm/highmem.c:63!
> > EIP is at kunmap_atomic+0x27/0x70
> > Call Trace
> >   show_stack+0xa6/0xb0
> >   show_register+0x14d/0x1c0
> >   die+0x158/0x2e0
> >   do_invalid_op+0xef/0x100
> >   error_code+0x2b/0x30
> >   copy_pte_range+0x122/0x490
> 
> This might help:

Indeed. Thanks for fixing this.  I checked the other functions,
but it seems I only made this mistake once.

-Andi

> 
> 
> 
> 
> We're modifying src_pte and dst_pte in the for-loop, and then unmapping the
> modified pointers.  If one of them walked off the end of the page then blam.
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
