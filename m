Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRCZT2X>; Mon, 26 Mar 2001 14:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRCZT2P>; Mon, 26 Mar 2001 14:28:15 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:37436 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132546AbRCZT1z>; Mon, 26 Mar 2001 14:27:55 -0500
Date: Mon, 26 Mar 2001 13:26:50 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103261926.NAA02298@tomcat.admin.navo.hpc.mil>
To: matthew@wil.cx, LA Walsh <law@sgi.com>
Subject: Re: 64-bit block sizes on 32-bit systems
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Mon, Mar 26, 2001 at 08:39:21AM -0800, LA Walsh wrote:
> > I vaguely remember a discussion about this a few months back.
> > If I remember, the reasoning was it would unnecessarily slow
> > down smaller systems that would never have block devices in
> > the 4-28T range attached.  
> 
> 4k page size * 2GB = 8TB.
> 
> i consider it much more likely on such systems that the page size will
> be increased to maybe 16 or 64k which would give us 32TB or 128TB.
> you keep on trying to increase the size of types without looking at
> what gcc outputs in the way of code that manipulates 64-bit types.
> seriously, why don't you just try it?  see what the performance is.
> see what the code size is.  then come back with some numbers.  and i mean
> numbers, not `it doesn't feel any slower'.
> 
> personally, i'm going to see what the situation looks like in 5 years time
> and try to solve the problem then.  there're enough real problems with the
> VFS today that i don't feel inclined to fix tomorrow's potential problems.

I don't feel that it is that far away ... IBM has already released a 64 CPU
intel based system (NUMA). We already have systems in that class (though
64 bit based) that use 5 TB file systems. The need is coming, and appears
to be coming fast. It should be resolved during the improvements to the
VFS.

A second reason to include it in the VFS is that the low level filesystem
implementation would NOT be required to use it. If the administrator
CHOOSES to access a 16TB filesystem from a workstation, then it should
be possible (likely something like the GFS, where the administrator is
just monitoring things, would be reasonable for a 32 bit system to do).

As I see it, the VFS itself doesn't really care what the block size is,
it just carries relatively opaque values that the filesystem implementation
uses. Most of the overhead should just be copying an extra 4 bytes around.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
