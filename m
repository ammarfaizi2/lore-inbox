Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbTL3KFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbTL3KFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:05:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:55463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265709AbTL3KFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:05:47 -0500
Date: Tue, 30 Dec 2003 02:05:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optimize ia32 memmove
In-Reply-To: <20031230011156.N6209@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.58.0312300202520.2065@home.osdl.org>
References: <200312300713.hBU7DGC4024213@hera.kernel.org> <3FF129F9.7080703@pobox.com>
 <20031229235158.755e026c.akpm@osdl.org> <3FF12FC7.5030202@pobox.com>
 <20031230011156.N6209@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Andreas Dilger wrote:
> 
> The non-overlapping cases are probably very common and worth optimizing for:

No, almost all non-overlapping users already just use "memcpy()". 

So most of the kernel uses of "memmove()" are likely overlapping - and 
just optimizing the non-overlap case probably doesn't help a lot.

That's why you optimize the overlapping case in one direction. We really 
should do the other case right too.

		Linus
