Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283718AbRLOVCe>; Sat, 15 Dec 2001 16:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283719AbRLOVCV>; Sat, 15 Dec 2001 16:02:21 -0500
Received: from fungus.teststation.com ([212.32.186.211]:41741 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S283718AbRLOVCI>; Sat, 15 Dec 2001 16:02:08 -0500
Date: Sat, 15 Dec 2001 22:02:00 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Petr Titera <P.Titera@century.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 4GB file size limit on SMBFS
In-Reply-To: <3C19A3CC.7020501@century.cz>
Message-ID: <Pine.LNX.4.33.0112151705010.12939-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, Petr Titera wrote:

> simple
> 	dd if=/dev/zero of=test bs=1024k count=8000
> 
> gives 4GB file on server without any error. I cannot what would whappen 
> if I use real file as my test machine has only 2GB of disk space :( So 
> portions of output file can be rewriten.

The first patch was incomplete. It contained a calculation bug on the
smbfs side limiting the possible offset to 32bits unsigned.

New patch vs 2.4.16 (and others) available here:
    http://www.hojdpunkten.ac.se/054/samba/lfs.html


The annoying thing is that someone pointed that bug out to me some time
ago in an earlier version. I made the change and verified it then, but now
I used an unfixed patch as base for the 2.4.15-pre version ... grr.

I have successfully tested this with a winXP machine someone had. Not the
'dd test' but truncating it to 4.5G (less network transfer time), writing
something above the 4G mark and then checking that it doesn't end up
below. Also works with samba.

(But not with win2k and FAT, which all win2k users around here seems to be
 using, that gives ENOSPC after 4G. Should perhaps be EFBIG ... or not)


Let me know if this works better for you.

/Urban

