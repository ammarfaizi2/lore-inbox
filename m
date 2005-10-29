Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVJ2BAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVJ2BAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVJ2BAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 21:00:24 -0400
Received: from animx.eu.org ([216.98.75.249]:3278 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750974AbVJ2BAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 21:00:23 -0400
Date: Fri, 28 Oct 2005 21:12:28 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: NFS permission denied error
Message-ID: <20051029011228.GA28695@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server setup (2.6.10 vanilla kernel, nfsroot with local hard disks
that are exported).  Recently the motherboard died and had to be replaced. 
No configuration changes were performed to the system otherwise.  Now I see
Permission Denied errors when attempting to mount any of the exported
directories.  Server is called "nail" with IP of 192.168.2.15 (x86)

kmountd nfs-utils 1.0.6

exports:
/backup         192.168.0.0/255.255.0.0(rw,async,wdelay,no_root_squash)
/160g           192.168.0.0/255.255.0.0(rw,async,wdelay,no_root_squash)
/80g            192.168.0.0/255.255.0.0(rw,async,wdelay,no_root_squash)
Those are hdc sda and hda respectively

The clients are "vegeta" 192.168.2.7 2.6.12 (x86) and "kakarot" 192.168.2.6
2.4.20 (alpha)

The only workaround I found is to use exportfs -f and everything works fine. 
I can't understand why this is now giving me problems.

I set nfsd_debug to 65535 and I see this:
Oct 28 21:14:27 nail kernel: nfsd: exp_rootfh(/backup [ef3c15a4]
192.168.0.0/255.255.0.0:hdc/2)
Oct 28 21:14:27 nail kernel: nfsd: exp_rootfh export not found.

However, running exportfs shows:
/backup         192.168.0.0/255.255.0.0
/160g           192.168.0.0/255.255.0.0
/80g            192.168.0.0/255.255.0.0

After exportfs -f:
Oct 28 21:15:07 nail kernel: nfsd: exp_rootfh(/backup [ef3c15a4]
192.168.0.0/255.255.0.0:hdc/2)
Oct 28 21:15:07 nail kernel: nfsd: fh_compose(exp 16:00/2 ///, ino=2)
Oct 28 21:15:07 nail kernel: nfsd_dispatch: vers 3 proc 19
Oct 28 21:15:07 nail kernel: nfsd: FSINFO(3)   12: 00000001 00001600
00000002 00000000 00000000 00000000
Oct 28 21:15:07 nail kernel: nfsd: fh_verify(12: 00000001 00001600 00000002
00000000 00000000 00000000)
Oct 28 21:15:07 nail kernel: nfsd: Dropping request due to malloc failure!
Oct 28 21:15:07 nail kernel: found domain 192.168.0.0/255.255.0.0
Oct 28 21:15:07 nail kernel: found fsidtype 0
Oct 28 21:15:07 nail kernel: found fsid length 8
Oct 28 21:15:07 nail kernel: Path seems to be </backup>
Oct 28 21:15:07 nail kernel: Found the path /backup
Oct 28 21:15:07 nail kernel: And found export
Oct 28 21:15:07 nail kernel: nfsd_dispatch: vers 3 proc 19
Oct 28 21:15:07 nail kernel: nfsd: FSINFO(3)   12: 00000001 00001600
00000002 00000000 00000000 00000000
Oct 28 21:15:07 nail kernel: nfsd: fh_verify(12: 00000001 00001600 00000002
00000000 00000000 00000000)
Oct 28 21:15:08 nail kernel: nfsd_dispatch: vers 3 proc 19
Oct 28 21:15:08 nail kernel: nfsd: FSINFO(3)   12: 00000001 00001600
00000002 00000000 00000000 00000000
Oct 28 21:15:08 nail kernel: nfsd: fh_verify(12: 00000001 00001600 00000002
00000000 00000000 00000000)
Oct 28 21:15:08 nail kernel: nfsd_dispatch: vers 3 proc 1
Oct 28 21:15:08 nail kernel: nfsd: GETATTR(3)  12: 00000001 00001600
00000002 00000000 00000000 00000000
Oct 28 21:15:08 nail kernel: nfsd: fh_verify(12: 00000001 00001600 00000002
00000000 00000000 00000000)

At this point I have no idea what's going on.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
