Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSEAWxh>; Wed, 1 May 2002 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314081AbSEAWxg>; Wed, 1 May 2002 18:53:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3091 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314080AbSEAWxg>; Wed, 1 May 2002 18:53:36 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] alternative API for raw devices
Date: 1 May 2002 15:52:25 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aaprj9$nqv$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0205011555450.12640-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0205011555450.12640-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> 	* it's _not_ a character device - stat() will give you S_IFREG.
> 	  To check that <foo> is a new-style raw device call statfs(2) and
> 	  compare .f_type with rawfs magic (0x726177).  It doesn't conflict
> 	  with existing check for raw devices (stat(), check that it's
> 	  a character device and compare major with RAW_MAJOR), so existing
> 	  software can be taught to check for raw devices in
> 	  backwards-compatible way.
> 

I really don't know if it's a good idea for this to be S_IFREG, which
software has a reasonable expecation to behave like a normal file,
which a raw device *definitely* doesn't.

I would really like things like this as well as a lot of the
zero-length magic files in /proc to be S_ISCHR with i_rdev ==
MK_DEV(0,0) (the latter to let user space know that this isn't a
standard device node.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
