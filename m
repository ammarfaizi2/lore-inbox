Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSF0AL5>; Wed, 26 Jun 2002 20:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSF0AL4>; Wed, 26 Jun 2002 20:11:56 -0400
Received: from mail.iil.ie ([217.78.0.24]:17680 "HELO
	mail3.internet-ireland.ie") by vger.kernel.org with SMTP
	id <S316686AbSF0AL4>; Wed, 26 Jun 2002 20:11:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Golden <david.golden@unison.ie>
To: linux-kernel@vger.kernel.org
Subject: Re: New Zaurus Wishlist - removable media handling
Date: Thu, 27 Jun 2002 01:19:49 +0100
X-Mailer: KMail [version 1.3.2]
References: <3D1A2DC1.6040401@travellingkiwi.com>
In-Reply-To: <3D1A2DC1.6040401@travellingkiwi.com>
Cc: zaurus-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020627001108.E56D9AA91F@mail3.internet-ireland.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And Unix filesystems were NOT designed for removable media.
>

(LKML cc'd because this rant *might* be coherent enough to explain it
to Linux kernel hackers)

The main problem I have with the Linux filesystems is this:

Forcing the user to think about which drive he stuck a disk or other
removable medium into each time he wants to access it is silly - people
often think of the disk as an entity independent of whichever drive it 
happens to be in at the time.

It drives me crazy^Hier when software insists on its cdrom being /mnt/cdrom,
for example  - there should be some way for the software to ask for
"Give me a disk called xyzzy1, and I don't care what drive it is!", and 
preferably by just trying to open e.g. /mnt/xyzzy1/

Once you've worked with a system that simply doesn't give a damn 
what drive you put a removable disk into, or even lets you pretend an 
arbitrary directory in the filesystem is that disk, it's very difficult to be 
comfortable on ones that do give a damn.  

Accessing the removable medium by the volume name of the medium, _not_
  (or not solely) by the drive it is in is something that the AmigaOS (the 
"classic" AmigaOS, not the Intent platform plastered with Amiga-trademarks) 
got "right", and Linux and Windows tend to get "wrong". (note the inverted 
commas - "right" and "wrong" are merely my opinion as a one-time Amiga 
user and now as a desktop linux user)

Amigas handled this with Assigns / amiga-style logical volumes (distinct from 
unix/linux LVMs, which are block-level) - if you stuck a CD named xyzzy1 in 
drive CD0:, you could access it via "CD0:" - "the volume currently in drive 
CD0:, whatever it may be called" , or via "xyzzy1:" - " the volume called 
xyzzy1, whatever drive it may be in"

Yes, this could be (fairly) trivially accomplished by a daemon managing a few
symlinks, or (better) the kernel automounter combined with the Linux vfs's 
support for multiple mounts of the same filesystem in different places.  

Unfortunately, there's no standard for it, and no desktop distros implement 
one, preferrring to have half-assed ad-hoc code in installers. (AFAIK on 
windows too, installers and individual applications for the most part write 
ad-hoc code to retreive the volume name, after scanning for drives.  That's 
not general or scaleable...)
 
obZaurus: The Zaurus, of course, inherits just the same problem, as far as I 
can tell -  /mnt/cf is whatever compact flash card happens to be in at the 
time, there's no direct way to ask the linux filesystem for a particular 
removeable medium. 

