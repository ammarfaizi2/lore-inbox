Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285398AbRLYGIJ>; Tue, 25 Dec 2001 01:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285405AbRLYGIA>; Tue, 25 Dec 2001 01:08:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18174 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285398AbRLYGHz>;
	Tue, 25 Dec 2001 01:07:55 -0500
Date: Tue, 25 Dec 2001 01:07:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Will Dyson <will_dyson@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] BeFS filesystem 0.6
In-Reply-To: <3C2814AB.9060700@pobox.com>
Message-ID: <Pine.GSO.4.21.0112250058570.28049-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Dec 2001, Will Dyson wrote:

> A & B) I originaly had plans to make the driver work under a variety of 
> different VFSs (maybe freebsd and atheos) and to have user-space tools 
> (like the old mtools for DOS) for people on other OSs. That was the 
> motivation behind those extra abstractions, but I've actually kinda lost 
> interest in the idea. I'll just take 'em out if it really offends 
> people's asthetic sense. Perhaps kernel drivers just weren't meant to be 
> portable.

Well, if you want portable - do it in userland and use CODA...
 
> B) The PPC and x86 versions of BeOS each write their filesystem metadata 
> in native byte-order. So this would only be a problem with disks that 
> were formatted on a big-endian system and read on a little-endian (or 
> the other way around, of course). I've been meaning to handle that case 
> "someday".

Better do it early, while amount of code is not too large.  Endian-clean
code is easy.  The rule is: never treat any "integer" types from disk as
assignment-compatible with int.  Always use something like fs32_to_cpu(),
etc. - it's cleaner that way and inlined functions actually work fine.

> F) Ideally, I would detect both the endianness of the filesystem and the 
> host, and refuse to mount if they differ (or byte-swap the metadata). 
> Can I rely on #ifdef __LITTLE_ENDIAN to detect the endianness I am 
> running on?

See above (and check how sysvfs does it - there it's even more obvious,
since you have to deal with _3_ variants of on-disk bytesex (big-endian,
little-endian and NUXI).

>  > befs_count_blocks() also needs cleanup.
> 
> How so, please?

Same thing - endianness issues.

