Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSCSXJL>; Tue, 19 Mar 2002 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293400AbSCSXJB>; Tue, 19 Mar 2002 18:09:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293251AbSCSXIs>; Tue, 19 Mar 2002 18:08:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: extending callbacks?
Date: 19 Mar 2002 15:08:23 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a78gd7$jk$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.4.44.0203191111320.20995-100000@speedy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.44.0203191111320.20995-100000@speedy>
By author:    Matthias Scheidegger <mscheid@iam.unibe.ch>
In newsgroup: linux.dev.kernel
> 
> I've got the following problem: I want to register a callback in a kernel
> structure, but I need to supply an additional argument to my own code. I.e. I
> need a callback
> 
> int (*cb)(int u)
> 
> to really call
> 
> int (*real_cb)(int u, void* my_arg)
> 
> At the moment, I'm only focussing on the i386 architecture.
> In user space, I'd do this by generating some machine code, which takes the
> original args, pushes my_fixed_arg and calls real_cb (using mprotect to make
> the generated code callable). That way I'd use a function
> 
> int (*)(int) create_callback(int (*real_cb)(int, void*), void *arg);
> 
> Is there a good way to do that in the kernel?
> Not necessarily using self modifying code, I'll only use it if I must.
> 

In general, it's impossible.  On a lot of architectures, it happens to
"just work" with the appropriate cast, but that's completely dependent
on the ABI.

The extra arguemnt, of course, contains garbage.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
