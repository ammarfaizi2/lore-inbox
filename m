Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWBMC0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWBMC0j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWBMC0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:26:38 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:25228 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751096AbWBMC0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:26:38 -0500
Message-ID: <43EFEE57.7070009@cfl.rr.com>
Date: Sun, 12 Feb 2006 21:26:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Nicolas George <nicolas.george@ens.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com> <20060213010701.GA8430@clipper.ens.fr>
In-Reply-To: <20060213010701.GA8430@clipper.ens.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas George wrote:
> According to Wikipedia, and what I knew besides, FAT32 has a limit of 2 To
> for the whole filesystem. But the limit I was talking of is the file size
> limit: 4 Go perfile. Which is, nowadays, a bit short: an ISO image for a
> DVD-R does not fit, for example.
> 

Ahh yes, the per file limit.  BTW, why are you saying "To" and "Go" when 
you apparently mean "TB" and "GB"?

> I am not sure about that: you can not do really good algorthms on bad data
> structures, and the data structures of FAT do not provide any support to do
> smart allocation.
> 

The fat data structures do not encourage fragmentation any more or less 
than ext2/3.  NTFS is slightly better, more comparable to reiserfs than 
ext2/3, but the difference is small.  What causes massive fragmentation 
is how the driver chooses to allocate new blocks as you write to files. 
  Microsoft has always used about the worst possible algorithm for doing 
this you can imagine, which is why fragmentation has always been a big 
problem on their OSes.  Linux is smarter and allocates blocks such that 
fragmentation is kept to a minimum.

> That is interesting. Do you know how efficient UDF is compared to others
> filesystems on normal hard drives? It is optimized for CDs and DVDs, I would
> not be surprised if the performances were poor on different supports.
> 

I have not done any testing, but I know no reason why it would be worse 
than fat.  It does not do transaction logging, and there currently is no 
fsck for it, so for safety reasons, it may not be such a good choice. 
If you want reliability, efficiency, and posix semantics, I'd go with 
reiserfs or ext3.

> I believe that such options should not be done on a per-filesystem basis.
> Something in the common code of the VFS would be more logical. 
> 

I agree.  I think the VFS layer should process the uid/gid options.  By 
default it should replace nobody with the specified id, and fat and ntfs 
  should just report all files as owned by nobody.  Then a new option 
should be added to force the translation for all ids, not just nobody.


> The idea was to mount the disk with its haphazard UIDs, and then export it
> and mount it as a network filesystem over the loopback. By itself, it is
> absolutely useless, but networked filesystems have UIDs mapping facilities.
> 

Eww, that is quite a kludge.

