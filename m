Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130120AbQLEVjh>; Tue, 5 Dec 2000 16:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbQLEVj1>; Tue, 5 Dec 2000 16:39:27 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:62989 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130120AbQLEVjL>; Tue, 5 Dec 2000 16:39:11 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDE5@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Tigran Aivazian'" <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: RE: [bug] vfsmount->count accounting broken again?
Date: Tue, 5 Dec 2000 13:08:37 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries wrote Monday 4-dec-2000 about a umount patch
for this:

Now that there was some discussion about umount,
I released a version of mount/umount that perhaps
has a slightly better behaviour. Since the change
was largish (and is untested), don't put it blindly
into your distribution.
Another change was one intended to make things behave
a bit better for Japanese (with variable width characters).
Since I changed the patch a bit, it is quite possible
I broke things both for Japanese and English.

Andries - aeb@cwi.nl

ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/
-

I haven't tried it yet.

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> -----Original Message-----
> From: Tigran Aivazian [mailto:tigran@veritas.com]
> Sent: Tuesday, December 05, 2000 1:07 PM
> To: linux-kernel@vger.kernel.org
> Subject: [bug] vfsmount->count accounting broken again?
> 
> 
> Hi,
> 
> Imagine two ext2 filesystems
> 
> /dev/hda1 mounted rw on /boot
> /dev/hda3 mounted rw on /usr/src
> 
> now mount /dev/hda3 also on /boot
> 
> mount -t ext2 /dev/hda3 /boot
> 
> this succeeds, which is expected. Now umount it.
> 
> umount /boot
> 
> this also succeeds, which is expected. Now do df(1) and notice that
> /etc/mtab is corrupted and no longer shows the old /boot 
> filesystem even
> though we know (from /proc/mounts) that it is mounted. This 
> is a bug but a
> userspace one (should mail Andries later, probably 
> util-linux). Now, the
> interesting bit, i.e. the kernel bug:
> 
> umount /boot
> 
> this fails with EBUSY. So, I think the reference count has gone wrong
> somewhere -- I will put debugging code in do_umount() and see, but
> everyone is welcome to fix it before I do so...
> 
> Regards,
> Tigran
> 
> -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
