Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWBNNuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWBNNuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWBNNuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:50:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13074 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161056AbWBNNuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:50:18 -0500
Date: Tue, 14 Feb 2006 14:50:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sfrench@samba.org
Cc: linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060214135016.GC10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I do obvserve the following on my i386 computer:

I'm connecting to a Samba server.

Copying data to the server works without any problems.

When trying to copy some GB from the server, my computer completely 
frezzes after some 100 MB. This is reproducible.

"Complete freeze" is:
- no reaction to any input, even when I was in the console the magic 
  SysRq key is not working
- if XMMS was playing, the approx. half a second of the song that was
  playing at the time when it happened is played in an endless loop by
  the sound chip

I once switched to the console waiting for the crash, and I saw the 
following messages:
  CIFS VFS: No response to cmd 46 mid 5907
  CIFS VFS: Send error in read = -11

There are no other CIFS messages in my logs, and the messages above 
didn't make it into the logs (there's nothing recorded in the logs at 
the time of the crashes).

I tried kernel 2.6.16-rc2 and 2.6.16-rc3.

CIFS options in my kernel:
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set

I'm mounting with (slightly anonymized):
mount -t cifs -o user="foo",ip=11.22.33.44 //DAT/bar bar

I'm using the smbfs 3.0.21a-4 package from Debian.

It doesn't occur in 2.6.15.4, because with this kernel (and AFAIR also 
with older kernels) my computer refuses to mount this share.

Mounting the same share with smbfs works without big problems (on some 
rare occassions the connection might become stale and I have to umount 
and remount the share, but this is rare and it never affects the 
stability of my computer).

I'm using an e100 network card with a 10 MBit/s connection.

Any other information I can provide for helping to debug this problem?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

