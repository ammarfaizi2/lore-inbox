Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290221AbSAOR61>; Tue, 15 Jan 2002 12:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290218AbSAOR6U>; Tue, 15 Jan 2002 12:58:20 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:37901 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S290224AbSAOR52>; Tue, 15 Jan 2002 12:57:28 -0500
Date: Tue, 15 Jan 2002 12:57:01 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc module gets stuck
In-Reply-To: <Pine.GSO.4.21.0201130746400.26122-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0201151252090.29600-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexander!

> > I believe that kern_mount() and kern_umount() are remnants from the time
> > when the binfmt_misc filesystem was mounted automatically by the kernel.  
> > Removing them preserves all functionality (I did check it) while allows
> > unloading binfmt_misc if and only if the binfmt_misc filesystem is not
> > used for any mounts.
> 
> That's wrong - you are using that tree to store information (entries
> you've defined), so the lifetime should be "there are mounts or there
> are entries".  Which is actually pretty easy to implement - see if
> the following (completely untested) patch works for you.  It should
> give the following rules:
> 	if you had defined some entries - they stay alive until you remove
> them, mounted or not (i.e. umount /proc/sys/binfmt_misc && mount ... will
> not destroy any state)
> 	if there is no entries and fs is not mounted - you can rmmod.

It works as you describe it.  I agree that your approach is better.

-- 
Regards,
Pavel Roskin

