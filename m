Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130126AbQJaF2r>; Tue, 31 Oct 2000 00:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbQJaF2i>; Tue, 31 Oct 2000 00:28:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19986 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130126AbQJaF2a>; Tue, 31 Oct 2000 00:28:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kmalloc() allocation.
Date: 30 Oct 2000 21:28:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tll94$hc9$1@cesium.transmeta.com>
In-Reply-To: <E13qJZL-00076K-00@the-village.bc.nu> <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> > 64K probably less. kmalloc allocates physically linear spaces. vmalloc will
> > happily grab you 2Mb of space but it will not be physically linear
> > 
> 
> Okay. Thanks.
> 

FWIW, vmalloc()-allocated pages are definitely pinned-down and
available to interrupts.  However, you should keep in mind that the
vmalloc() call *itself* is quite expensive on SMP machines (have to
interrupt all CPUs and flush their TLBs!!) so if you're using
vmalloc(), be careful with the number of calls you make.  Of course,
this is usually not a problem.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
