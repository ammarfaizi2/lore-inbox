Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282387AbRKXHRm>; Sat, 24 Nov 2001 02:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282389AbRKXHRX>; Sat, 24 Nov 2001 02:17:23 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:24175 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S282387AbRKXHRL>; Sat, 24 Nov 2001 02:17:11 -0500
Date: Sat, 24 Nov 2001 09:17:04 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: HPT370 on 2.2.20+ide-patch - tried 2.4.15 and it fails, too
Message-ID: <20011124091704.H4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]> <20011122210503.B4809@niksula.cs.hut.fi> <20011122215424.C4809@niksula.cs.hut.fi> <20011123143502.D4809@niksula.cs.hut.fi> <20011123163932.E4809@niksula.cs.hut.fi> <20011123233211.F4809@niksula.cs.hut.fi> <20011124085201.G4809@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011124085201.G4809@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sat, Nov 24, 2001 at 08:52:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 08:52:01AM +0200, you [Ville Herva] claimed:
> 
> had stalled at _second_ run. The first, identical run had gone through.
> The point where it happened is after dd has read the last (not whole GB) and
> is trying to skip slightly more than the size of md0:
> 
> At 63 GB
> 756+1 records in
> 756+1 records out
> b1a566b4b54905ab21d138670b7abae3  -
> At 64 GB
> <stalls>                           
> 
> This never happened with 2.2.*

The "stall" seems to be a dd bug:

strace dd if=/dev/md0 of=/dev/null bs=1048576 count=1024 skip=65536
(...)
open("/dev/md0", O_RDONLY|O_LARGEFILE)  = 0
(...)
_llseek(0, 68719476736, 0xbffff2d0, SEEK_SET) = -1 EINVAL (Invalid argument)
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1048576) = 
1048576
read(0, "\366&\3704\327\310\243\232\332\220\223\235\367\206\300"...,
1048576) = 
1048576
read(0, "n\3164\326\366>\330\5\377\236\303>Vf\377f\317<\226\212"...,
1048576) = 
1048576
(...)
(reads propably the whole /dev/md0)

...back to investigating the differing md5sums...


-- v --

v@iki.fi
