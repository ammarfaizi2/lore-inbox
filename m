Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbSJGVYV>; Mon, 7 Oct 2002 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263408AbSJGVYV>; Mon, 7 Oct 2002 17:24:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16399 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263407AbSJGVYE>; Mon, 7 Oct 2002 17:24:04 -0400
Date: Mon, 7 Oct 2002 14:28:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] Make it possible to compile in the Bluetooth subsystem
In-Reply-To: <1034025872.861.81.camel@pegasus>
Message-ID: <Pine.LNX.4.33.0210071426480.1402-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Oct 2002, Marcel Holtmann wrote:
> 
> but when I try to compile in the Bluetooth subsystem I got the following
> error:
> 
> net/built-in.o: In function `sock_init':
> net/built-in.o(.text.init+0x5b): undefined reference to `bluez_init'
> make: *** [.tmp_vmlinux1] Error 1

This is a separate error, apparently because net/socket.c calls 
"blues_init()" if bluetooth is configured in.

That shouldn't be needed at all, since the "init_module()" thing should 
take care of it. Please try just removing the bluez_init references from 
net/socket.c - that should fix the compile, and if all the ordering issues 
are ok, it should also work afterwards..

		Linus

