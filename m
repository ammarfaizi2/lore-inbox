Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbREaSYT>; Thu, 31 May 2001 14:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbREaSYJ>; Thu, 31 May 2001 14:24:09 -0400
Received: from [208.155.152.19] ([208.155.152.19]:17679 "EHLO
	basilio.i-manila.com.ph") by vger.kernel.org with ESMTP
	id <S263152AbREaSYC>; Thu, 31 May 2001 14:24:02 -0400
Date: Fri, 1 Jun 2001 02:23:15 +0800 (PHT)
From: Federico Sevilla III <jijo@i-manila.com.ph>
To: ReiserFS Mailing List <reiserfs@devlinux.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: kernel-2.4.5
 bug)
In-Reply-To: <3B167AFD.EC1897E1@namesys.com>
Message-ID: <Pine.LNX.4.21.0106010147060.1228-100000@kalapati.jijo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some experiences with the unmount issue(s) concerning Linux
kernel 2.4.5-ac5, (in my case) the 3ware RAID controller, and ReiserFS.

I'm using kernel 2.4.5-ac5 and have a 3ware Escalade 6400 controller
(firmware upgraded to v6.6 to fix RAID5 issue) with four disks on 64k
RAID5.

I do not get kernel oopses when I unmount, but I noticed that unmounts
(whether called by root or during shutdown) "freeze" and cause the
controller to do an initializing scan of the array to verify parity (which
it normally only does when the first laying out of zeroes doesn't go
properly).

After a first unmount (when called by root), subsequent unmount attempts
or even syncs (using the sync utility) will "freeze" as if waiting for the
drives to respond. Other file activity is normal but a little slow (as
they normally are when initializing scans are being done by the hardware
RAID controller).

I haven't found any NULLs at the start of recently created or modified
files, and things seem to be okay except for this issue when unmounting.
As a matter of fact during the last time this "freeze" happened I gathered
my wits to help me from panicking (the company's data's on this box, it's
our main Samba fileserver) and created a small file with a few text, then
stopped all my applications (the ones I could stop using the /etc/init.d
scripts) and killed the power.

When I rebooted, the 3ware controller's BIOS of course told me that the
initializing scan would commence after the OS was loaded (as expected).
Boot up was normal, ReiserFS replayed transactions pretty quickly without
any wierd comments, and then I checked the files I remember were changed
or the small test file I created and ... everything seemed to be in order,
intact, and as if nothing untoward happened. Well, at least I didn't find
anything that looked untoward/messed up. I hope everything is indeed in
order (I've got both my fingers crossed and this honestly makes typing a
little difficult ;> ).

I'm staying on 2.4.5-ac5 for whatever it's worth (putting my life on the
line for the community? kidding...) and will report anything new. I will
be on the lookout for later ac patches, 2.4.6 ... and hopefully anything
anybody can share with me about this. I hope we'll see an end to these
issues soon. May all those actually doing work on it be blessed. :)

 --> Jijo

--
Linux, MS-DOS, and Windows NT ...
... also known as the Good, the Bad, and the Ugly

