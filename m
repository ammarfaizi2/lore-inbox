Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRJCLHY>; Wed, 3 Oct 2001 07:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273115AbRJCLHO>; Wed, 3 Oct 2001 07:07:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13720 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273108AbRJCLHG>;
	Wed, 3 Oct 2001 07:07:06 -0400
Date: Wed, 3 Oct 2001 07:07:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: andersg@0x63.nu
cc: linux-kernel@vger.kernel.org, magnusm@0x63.nu
Subject: Re: mount D-states on secound mount
In-Reply-To: <20011003130007.A32735@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.GSO.4.21.0110030704500.21861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001 andersg@0x63.nu wrote:

> Hi,
> 
> i run 2.4.10 with lvm-1.0.1-rc2 on a smp-system.
> 
> Mounting a filesystem a second time fails. (mount /dev/vg00/lv01 /ftp/www ;
> mount /dev/vg00/lv01 /www ). The disk contains a reiserfs filesystem.
> It worked in 2.4.9 with lvm-1.0.1-rc2. Is this a lvm problem?
> 
> Mount D-states here:
> 
> Trace; c02085bc <rwsem_down_read_failed+11c/144>
> Trace; c020c5b2 <stext_lock+2296/7054>
> Trace; c0147d04 <sync_inodes+14/4c>
> Trace; c0134a8a <fsync_dev+3a/74>
> Trace; c0134ace <sync_dev+a/10>
> Trace; c01c5692 <lvm_blk_close+36/54>

Remove the call of sync_dev() from lvm_blk_close().  It doesn't have
any business being there.

