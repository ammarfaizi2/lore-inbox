Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290748AbSAYRj2>; Fri, 25 Jan 2002 12:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290749AbSAYRjS>; Fri, 25 Jan 2002 12:39:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4110 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290748AbSAYRjO>; Fri, 25 Jan 2002 12:39:14 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Too big EBDA issue
Date: 25 Jan 2002 09:38:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2s571$8oe$1@cesium.transmeta.com>
In-Reply-To: <1038781885.20020125205822@udm.net.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1038781885.20020125205822@udm.net.ru>
By author:    ASA <llb@udm.net.ru>
In newsgroup: linux.dev.kernel
> 
> Today I had to upgrade DiskOnChip BIOS extender and after that I could not
> boot linux anymore. After digging hard in problem I found that EBDA was
> enlarged to 33KB so remaining conventional memory was reduced to 607KB but
> normal booting proccess bzImage loading requires at least 608 KB. After
> checking on other systems with DiskOnChip I found their EBDA have sizes
> typically of 29-31 KB.
> 
> Yeah, it is very large EBDA (normal PC's I checked just have only 1 KB
> EBDA). It seems DickOnChip BIOS requires much space on irder to store own
> temporary data to implement their TrueFFS.
> 
> But I guess that there will be some other BIOS extensions that will require
> another EBDA space. As far as bzImage loading model requires space of 32 K
> between 576K (0x90000) and 608K (0x98000) but almost no other place I think
> there is necessity to extend boot protocol in order to relocate 16-bit mode
> loader closer to the lowest memory bound, not to the upper one.
> 

That was done way way long ago.  If your boot protocol is 2.02 or
later, you can locate it anywhere between 0x10000 and 0x90000.  This
applies to bzImages only; zImages are still screwed.

You need a modern enough bootloader that knows about this and uses it,
however.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
