Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317453AbSFCSng>; Mon, 3 Jun 2002 14:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317454AbSFCSnf>; Mon, 3 Jun 2002 14:43:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317453AbSFCSnd>; Mon, 3 Jun 2002 14:43:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Atomic operations
Date: 3 Jun 2002 11:43:07 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <adgdbr$1nj$1@cesium.transmeta.com>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A15@ntserver2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <EE83E551E08D1D43AD52D50B9F5110927E7A15@ntserver2>
By author:    Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
In newsgroup: linux.dev.kernel
> 
> Could you, please, clarify what you meant saying that there was no way of
> doing so. I admit, I'm no expert in i386 assembly, but this operation seems
> so simple to me...
> 

That doesn't mean the hardware is going to provide it atomically.

> 
> Could you, please, suggest some other implementation (with waiting and
> trying again - whatever this means)?
> 

Very simple:

- Set a spinlock (note: you need a spinlock variable)
- Read
- Add
- Clear spinlock

This is called "bootstrapping" -- using a more primitive atomic
operation to get what you need.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
