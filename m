Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291532AbSBAESd>; Thu, 31 Jan 2002 23:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291533AbSBAESY>; Thu, 31 Jan 2002 23:18:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56337 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291532AbSBAESU>; Thu, 31 Jan 2002 23:18:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Date: 31 Jan 2002 20:18:01 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3d4tp$nlu$1@cesium.transmeta.com>
In-Reply-To: <20020131.162549.74750188.davem@redhat.com> <E16WRmu-0003iO-00@the-village.bc.nu> <20020131.163054.41634626.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020131.163054.41634626.davem@redhat.com>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>    
>    tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL
>    
> This doesn't solve the CRC32 case.  What if you want
> CONFIG_SMALL, yet some net driver that needs the crc32
> routines?
> 

We could do it something like what I did with inflate_fs -- build it
as a module if the kernel proper doesn't need it (and modules are
enabled.)

It *does* mean the configure rules need to contain these dependencies,
though.

crc32 is an interesting case... you can create code to make the tables
with a very small amount of code.  This saves space on disk, but not
in memory; in fact, if you can't jettison this code you lose in
memory...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
