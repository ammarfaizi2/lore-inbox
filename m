Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTEVAd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTEVAd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:33:26 -0400
Received: from pop.gmx.de ([213.165.64.20]:23264 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262409AbTEVAdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:33:25 -0400
Message-ID: <3ECC1DE0.3030707@gmx.net>
Date: Thu, 22 May 2003 02:46:24 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: root@chaos.analogic.com, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: recursive spinlocks. Shoot.
References: <PEEPIDHAKMCGHDBJLHKGGEHPCMAA.rwhite@casabyte.com>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGGEHPCMAA.rwhite@casabyte.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> 
> Here is a problem statement that is virtually unimplementable in the current
> Linux kernel because of the simple-minded locking model.
> 
> Create a meta file-system that takes two existing (backing) file system
> devices (or existing mounted directories) and aggregates them such that:
> 
> (Ladies, and Gentlemen, The "deltafs" file system...)

Call it unionfs.

> 1) It doesn't matter what types of file systems are used as the backing file
> systems.
> 2) The aggregate file system is fully read-write
> 3) The base (first existing) file system is read-only
> 4) The front (second existing) file system is read-write
> 5) All operations are available on the aggregate file system (unlink,
> rename, open for write, open for append, chown, set access time, etc.)
> 6) The aggregate file system engine will transcribe all the modified files
> from the base to the front file system if the file is modified.
> 7) The aggregate file system will (probably using a reserved file name and a
> journaling structure encoded therein) maintain a white-out list to hide
> unlinked and renamed files.
> 8) After unmount, the front file system should be a minimal delta of the
> base file system
> 9) Remounting the same combination of file systems should consistently
> result in the same, consistent file system image.
> 10) (you get the point... 8-)

IIRC, Al Viro was working on this and we might have it in 2.6

http://www.ussg.iu.edu/hypermail/linux/kernel/0201.0/0745.html

Al?


Regards,
Carl-Daniel

