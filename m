Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSJ0Wuq>; Sun, 27 Oct 2002 17:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSJ0Wuq>; Sun, 27 Oct 2002 17:50:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61195 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262721AbSJ0WsW>; Sun, 27 Oct 2002 17:48:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New nanosecond stat patch for 2.5.44
Date: 27 Oct 2002 14:54:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aphqqo$261$1@cesium.transmeta.com>
References: <20021027121318.GA2249@averell> <20021027214913.GA17533@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021027214913.GA17533@clusterfs.com>
By author:    Andreas Dilger <adilger@clusterfs.com>
In newsgroup: linux.dev.kernel
> 
> 3) The fields you are usurping in struct stat are actually there for the
>    Y2038 problem (when time_t wraps).  At least that's what Ted said when
>    we were looking into nsec times for ext2/3.  Granted, we may all be
>    using 64-bit systems by 2038...  I've always thought 64 bits is much
>    to large for time_t, so we could always use 20 or 30 bits for sub-second
>    times, and the remaining bits for extending time_t at the high end,
>    and mask those off for now, but that is a separate issue...
> 

64-bit time_t is nice because you don't *ever* need to worry about
overflow; it's capable of handling times on a galactic lifespan
scale.  It's overkill, of course, but it's the *right* kind of
overkill.

We probably need to revamp struct stat anyway, to support a larger
dev_t, and possibly a larger ino_t (we should account for 64-bit ino_t
at least if we have to redesign the structure.)  At that point I would
really like to advocate for int64_t ts_sec and uint32_t ts_nsec and
quite possibly a int32_t ts_taidelta to deal with leap seconds... I'd
personally like struct timespec to look like the above everywhere.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
