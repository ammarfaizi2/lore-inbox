Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTKKUTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTKKUTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:19:06 -0500
Received: from dp.samba.org ([66.70.73.150]:50666 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263717AbTKKUS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:18:59 -0500
Date: Wed, 12 Nov 2003 07:14:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <20031111201458.GS930@krispykreme>
References: <9710000.1068573723@flay> <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> There are basically no valid new uses of it. There's a few valid legacy
> users (I think the file descriptor array), and there are some drivers that
> use it (which is crap, but drivers are drivers), and it's _really_ valid
> only for modules. Nothing else.

The IPC code is doing ugly things too:

void* ipc_alloc(int size)
{
        void* out;
        if(size > PAGE_SIZE)
                out = vmalloc(size);
        else
                out = kmalloc(size, GFP_KERNEL);
        return out;
}

Anton
