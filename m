Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSFDLVf>; Tue, 4 Jun 2002 07:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317479AbSFDLVf>; Tue, 4 Jun 2002 07:21:35 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:20158 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315461AbSFDLVd>; Tue, 4 Jun 2002 07:21:33 -0400
Message-ID: <3CFCA2B0.4060501@antefacto.com>
Date: Tue, 04 Jun 2002 12:21:20 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Need help tracing regular write activity in 5 s interval
In-Reply-To: <20020602135501.GA2548@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> Hello,
> 
> I am using some recent Linux 2.4.x version (2.4.19-pre8-ac5 for now),
> and I have been observing regular disk activity at 5 s intervals for
> some time now which are not related to a particular kernel version.
> 
> I have reiserfs and ext3fs file systems mounted.
> 
> The first thing that came to mind with the "5 s interval" was DJB's
> "svscan", but neither mount -o remount,noatime / nor killall -STOP
> svscan helped.
> 
> The next thing that comes to mind is that journalling file systems
> commit their journal every five seconds. But I have a hard time finding
> out which file system does this or which process causes blocks to be
> marked dirty again. I'd really like to get rid of this regular activity
> unless there's a need.
> 
> So: is there any trace software that can tell me "at 15:52:43.012345,
> process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
> detail so I can figure if it's just an atime update -- as with svscan --
> or a write access)? And that is NOT to be attached to a specific process
> (hint: strace is not an option).
> 
> Also, I'd like to suggest again a mount option that marks filesystems as
> "clean" automatically after all changes have been committed. This may be
> most useful with "noatime", though.
> 
> Thanks in advance,
> 

This thread may be of interest:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101600745431992&w=2

It's very awkward to analyse things like this at present.
For user -> kernel you could use something like syscalltrack.

As an aside, Nautilus (1.0.4) does stuff every 2 seconds
(checking is there a CD inserted) that causes the disk LED to flash.
The same action also causes the kernel (2.4.13) to fill up the ring
buffer with: "VFS: Disk change detected on device ide1(22,0)".

Padraig.

