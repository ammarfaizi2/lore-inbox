Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRKSTT5>; Mon, 19 Nov 2001 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280634AbRKSTTr>; Mon, 19 Nov 2001 14:19:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276988AbRKSTT1>; Mon, 19 Nov 2001 14:19:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: more fun with procfs (netfilter)
Date: 19 Nov 2001 11:18:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tblum$8p6$1@cesium.transmeta.com>
In-Reply-To: <E165kY1-0000Se-00@gondolin.me.apana.org.au> <Pine.GSO.4.21.0111190419250.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0111190419250.17210-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> Some shells (pdksh 5.2.14-1, bash 2.04 as shipped by SuSE) are trying to be
> smart if stdin is from regular file - they hope that third argument of
> lseek() is in bytes and is consistent with read() return value.
> 

Not just hope... they have a legitimate reason to expect that
guarantee from anything that advertises itself as S_IFREG.  I really
think procfs files should advertise themselves as S_IFCHR if they
can't fully obey the semantics of S_IFREG files (including having a
working length in stat()!)

Such S_IFCHR devices can return 0 in st_rdev to signal userspace that
this is a device node keyed by special filesystem semantics rather
than by device number.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
