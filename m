Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTKKWQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTKKWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:16:22 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26363 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263747AbTKKWQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:16:20 -0500
Date: Tue, 11 Nov 2003 14:41:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>
cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <31250000.1068590491@flay>
In-Reply-To: <20031111201458.GS930@krispykreme>
References: <9710000.1068573723@flay> <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org> <20031111201458.GS930@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There are basically no valid new uses of it. There's a few valid legacy
>> users (I think the file descriptor array), and there are some drivers that
>> use it (which is crap, but drivers are drivers), and it's _really_ valid
>> only for modules. Nothing else.
> 
> The IPC code is doing ugly things too:
> 
> void* ipc_alloc(int size)
> {
>         void* out;
>         if(size > PAGE_SIZE)
>                 out = vmalloc(size);
>         else
>                 out = kmalloc(size, GFP_KERNEL);
>         return out;
> }

That seems particularly .... odd ... as PAGE_SIZE isn't anywhere near the
breakpoint. Worst case (and I know I'll get yelled at for this, but I'll
get another amusing analogy out of Linus ;-)) we should just call kmalloc
and if it fails, then try vmalloc ...

M.

