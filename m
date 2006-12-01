Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031365AbWLANca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031365AbWLANca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031342AbWLANca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:32:30 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65244 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031356AbWLANc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:32:29 -0500
Date: Fri, 1 Dec 2006 13:39:24 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jan Glauber <jan.glauber@de.ibm.com>
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Pseudo-random number generator
Message-ID: <20061201133924.023289c4@localhost.localdomain>
In-Reply-To: <1164979155.5882.23.camel@bender>
References: <1164979155.5882.23.camel@bender>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * merging the s390 PRNG with the random pool implementation
> PRO: no new interface, random numbers can be read through /dev/urandom
> CON: complex implementation, could only use traditional /dev/urandom algorithm
>      or hardware-accelerated implementation

Also PRO: Can be verified by non-IBM people, high resistance if there is
a flaw (accidental or US government 8)) in the 390 hardware.

> I've chosen the char driver since it allows the user to decide which pseudo-random
> numbers he wants to use. That means there is a new interface for the s390
> PRNG, called /dev/prandom.

And people can pipe this into the urandom layer if they wish.

> +/* copied from libica, use a non-zero initial parameter block */
> +unsigned char parm_block[32] = {
> +0x0F,0x2B,0x8E,0x63,0x8C,0x8E,0xD2,0x52,0x64,0xB7,0xA0,0x7B,0x75,0x28,0xB8,0xF4,
> +0x75,0x5F,0xD2,0xA6,0x8D,0x97,0x11,0xFF,0x49,0xD8,0x23,0xF3,0x7E,0x21,0xEC,0xA0,
> +};
> +

Global variables called "p" and "parm_block". Plus parm_block appears to
be const

Also your register the misc device before allocating the buffer so it can
be opened in theory before the alloc is done and crash.
