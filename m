Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbQKIUjn>; Thu, 9 Nov 2000 15:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbQKIUjd>; Thu, 9 Nov 2000 15:39:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131161AbQKIUjT>; Thu, 9 Nov 2000 15:39:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Used space in bytes
Date: 9 Nov 2000 12:39:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uf21i$ro7$1@cesium.transmeta.com>
In-Reply-To: <20001109191843.B11373@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001109191843.B11373@atrey.karlin.mff.cuni.cz>
By author:    Jan Kara <jack@suse.cz>
In newsgroup: linux.dev.kernel
>
>   Hello.
> 
>   I sent similar email a few weeks ago but discussion ended without
> any useful results if I rememeber well.
> 
>   Quota in reiserfs is (and needs to be) accounted in bytes not in blocks.
> I modified quota system to allow such thing so in kernel there's no
> problem. But also 'quotacheck' needs to know how many space does given
> file use. Currently it uses st_blocks from stat(2) to compute the space
> used but for reiserfs we need precision in bytes, not in 512 byte blocks...
> My proposal is to alter stat64() syscall to return also number of bytes
> used (I tried to contact Ulrich Drepper <drepper@redhat.com> who should
> be right person to ask about such things (at least I was said so) but go
> no answer...). Does anybody have any better solution?
>   I know about two others - really ugly ones:
>    1) fs specific ioctl()
>    2) compute needed number of bytes from st_size and st_blocks, which is
>       currently possible but won't be in future
> 

Report a block size (really allocation unit size) st_blocks == 1?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
