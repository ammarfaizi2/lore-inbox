Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbUKLXvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUKLXvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbUKLXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:49:03 -0500
Received: from fsmlabs.com ([168.103.115.128]:48774 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262677AbUKLXcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:32:00 -0500
Date: Fri, 12 Nov 2004 16:31:14 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
cc: Thomas Schlichter <thomas.schlichter@web.de>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.10-rc1-mm4
In-Reply-To: <20041110150307.3a06cc1d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0411121630530.3388@musoma.fsmlabs.com>
References: <200411102333.03412.thomas.schlichter@web.de>
 <20041110150307.3a06cc1d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004, Andrew Morton wrote:

> Thomas Schlichter <thomas.schlichter@web.de> wrote:
> >
> > Today I tested the linux-2.6.10-rc1-mm4 kernel and it works fine with the 
> > attached config. But if I enable HIGHPTE, that kernel hits following BUG 
> > (written down by hand) and panics when the INIT process is started:
> > 
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
> 
> 
> 
> 
> We're modifying src_pte and dst_pte in the for-loop, and then unmapping the
> modified pointers.  If one of them walked off the end of the page then blam.

Thanks that fixed it (but you already knew that).

	Zwane

