Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbSLKXoI>; Wed, 11 Dec 2002 18:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbSLKXoI>; Wed, 11 Dec 2002 18:44:08 -0500
Received: from ip67-93-141-186.z141-93-67.customer.algx.net ([67.93.141.186]:51083
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id <S267382AbSLKXoH>; Wed, 11 Dec 2002 18:44:07 -0500
Date: Wed, 11 Dec 2002 18:52:58 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: linux-kernel@vger.kernel.org
Subject: Memory Measurements and Lots of Files and Inodes
Message-ID: <20021211235258.GA10857@ducksong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I've got a box with 750MB of RAM.. for the sake of this test, I've
turned off swap. I also have a little program that creates and deletes
lots of little files on a RAMDISK with ext2 on it. The ramdisk is only
4MB max and the files are about 3K and there are never more than four
of them at a time - but the program is constantly creating and
deleting hundreds of thousands of them. I have no reason to think this
issue is unique to the ramdisk - it just makes files faster.

Just sitting back and watching vmstat while this runs my 'free' memory
drops from ~600MB to about ~16MB.. the buffers and cache remain roughly
constant.. at 16MB some sort of garbage collection kicks in - there is
a notable system pause and ~70MB moves from the used to the 'free'
column... this process repeats more or less in a steady state.

If, while this is going on, I run another little app that does
{x= malloc(300MB), memset (x,0,300MB), free (x)}.. suddenly I can move
300MB from the used to the 'free' state...

I assume there is some VFS structure that is growing (perhaps related
to the tremendous # of inodes I'm going through) and is only cleansed
when the number of free pages gets too low.. I'd be interested in any
details someone could provide.

My real question is about the commonly (?) used metric of
free+buffers+cached representing the size of an allocation that could
succeed.. my 300MB allocation above proves that doesn't apply
here.. although, if I turn on strict accounting, that 300MB does fail
even though there is only perhaps 150MB of userspace allocations
outstanding on the box.

Can anybody provide a better metric for "ram free for userspace
allocations"?

Thanks,
-Patrick
