Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSEVXcb>; Wed, 22 May 2002 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEVXca>; Wed, 22 May 2002 19:32:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49678 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312590AbSEVXc2>; Wed, 22 May 2002 19:32:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5.17 /dev/port
Date: 22 May 2002 16:32:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ach9pk$ced$1@cesium.transmeta.com>
In-Reply-To: <UTC200205222246.g4MMkNL26024.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200205222246.g4MMkNL26024.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
> 
> In my eyes /dev/port is a rather unimportant corner
> of the kernel. Removing it does not streamline anything,
> we hear that it saves 454 bytes. A worthy goal, but..
> 
> Today a few things use /dev/port. Some low level mouse,
> keyboard and console utilities. kbdrate. hwclock.
> 
> Is it needed? Hardly - most uses can be replaced by inb()
> and outb(). But I am not sure why that would be better.
> And I seem to recall that hwclock on some flavours of Alpha
> really needed the /dev/port way. But I may be mistaken.
> 

On non-Intel platforms, with no dedicated IOIO opcodes, IOIO is
usually implemented as a specific memory range.  In that case, the
only way to allow user-space access to it would be to mmap() that
range... which means iopl() inb() and outb() on those platforms might
be implemented either as open, readp and writep, respectively, or by
iopl() being open() followed by mmap().

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
