Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318822AbSHFOI1>; Tue, 6 Aug 2002 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSHFOHV>; Tue, 6 Aug 2002 10:07:21 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:47069 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S319086AbSHFOHF>;
	Tue, 6 Aug 2002 10:07:05 -0400
Date: Tue, 6 Aug 2002 16:10:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, martin@dalecki.de
Subject: Re: [PATCH] 2.5.30 IDE 112
Message-ID: <20020806141042.GA29807@win.tue.nl>
References: <13C83160220@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13C83160220@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 02:19:29PM +0200, Petr Vandrovec wrote:

> FYI I had to use hda=cyls,255,63 to repartition my HDD.

(Or set H=255 S=63 in *fdisk.)

> BIOS refused to report proper size (120GB) when partition table
> was empty, or when it contained partitions created for xxx/16/63
> geometry. It reported size ~600MB, and actively refused to allow
> access above this limit...

Funny. Do you mean that your BIOS used SETMAX ?

> please talk to [cs]fdisk maintainer (and other) to print big fat
> warning and to allow specify BIOS heads/sectors, otherwise partitioning
> of empty disk in the way compatible with non-Linux OSes (Netware, Windows)
> is not an easy task.

Yes. I already advised this maintainer to add -C,-H,-S options to fdisk
(cfdisk and sfdisk already have them), and he did so immediately.
Visible one of these weeks in util-linux-2.11v.

> # lilo
> Warning: Int 0x13 function 8 and function 0x48 return different
> head/sector geometries for BIOS drive 0x81
>     fn 08: 788 cylinders, 255 heads, 63 sectors
>     fn 48: 13424 cylinders, 15 heads, 63 sectors
> Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
>     Kernel: 35973 cylinders, 16 heads, 63 sectors
>       BIOS: 1023 cylinders, 255 heads, 63 sectors

Since geometry does not exist, it is not surprising that everybody
invents something else. Not only do kernel and BIOS differ, but
BIOS is not consistent internally.

For a while, with disk sizes between 500 MB and 8 GB, maximum DOS-accessible
capacity was obtained by H=255 S=63. But IDE accepts at most 16 heads, so
H=255 requires a translating BIOS. For sizes above 8 GB the translation
is useless and will only take some small amount of time.
Setting the disk to Normal (instead of Large / LBA / Extended or so)
works best.

So, I have two questions:
1. What precisely do you mean with "actively refused" ?
2. Is there a Windows or Netware reason to prefer extended translation
above no translation?

Andries
