Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319144AbSIDLkE>; Wed, 4 Sep 2002 07:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319147AbSIDLkE>; Wed, 4 Sep 2002 07:40:04 -0400
Received: from cs144080.pp.htv.fi ([213.243.144.80]:47886 "EHLO chip.ath.cx")
	by vger.kernel.org with ESMTP id <S319144AbSIDLkD>;
	Wed, 4 Sep 2002 07:40:03 -0400
Date: Wed, 4 Sep 2002 14:44:06 +0300 (EEST)
From: Panu Matilainen <pmatilai@welho.com>
X-X-Sender: pmatilai@chip.ath.cx
To: Urban Widmark <urban@teststation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 32bit UID wraps around with smbfs
In-Reply-To: <Pine.LNX.4.44.0209041252590.7921-100000@cola.enlightnet.local>
Message-ID: <Pine.LNX.4.44.0209041441050.7970-100000@chip.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Urban Widmark wrote:

> On Wed, 4 Sep 2002, Panu Matilainen wrote:
> 
> > Hi,
> > 
> > Smbfs has problems with 32bit UID/GID's: when you do
> > 'smbmount //some/share /mnt/samba -o uid=100000' the mountpoint UID (and 
> > GID) wrap around at 65535.
> > 
> > The attached patch, along with samba recompile against fixed headers
> > apparently fixes it. This problem is present at least in all 2.4 kernels,
> > I haven't looked at 2.5.
> 
> I don't think this is an acceptable fix for the main kernel. You are
> changing a binary interface in a stable kernel series.

Yup.. I had my doubts about the changes (I'm not a kernel hacker, just 
poked around and noticed that things seem to work with that change)

> I personally think that smb_mount_data is a bad idea and are slowly
> working on moving smbfs to an ascii interface. With 2.4 any recent
> smbmount should be using the ascii interface already, the problem there is
> that smbmnt uses the smb_mount_data internally ...
> 
> This patch contains stuff I want to have included in samba 2.2.6,
> including fixes for smbmnt's uid-abuse:
> http://www.hojdpunkten.ac.se/054/samba/smbmount-2.2.5-misc-2.patch.gz
> 
> And this is needed to change the storage size of the in-kernel mount
> struct:
> http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.18-uid32.patch

Thanks, I'll try these out!

-- 
	- Panu -

