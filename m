Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbULCRuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbULCRuO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbULCRuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:50:14 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:57483 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262455AbULCRti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:49:38 -0500
Message-ID: <41B0A710.5050408@austin.rr.com>
Date: Fri, 03 Dec 2004 11:49:04 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aia21@cam.ac.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote
> I have been mulling over in my head for quite a while what 
> to do about an interface for "advanced ntfs features" but so far I have 
> always pushed this to the back of my mind.  After all no point in 
> providing advanced features considering we don't even provide full 
> read-write access yet.  I just thought I would mentione NTFS when I saw 
>
>But to answer your question I definitely would envisage an interface to 
>the kernel driver

The same issue has been on my mind for other filesystems too - since I 
can return similar information to NTFS.  The "easy" things
to return that could be useful to apps (including Samba4, but also 
backup apps etc.) include:

1) file creation time
2) "dos" attribute bits
3) perhaps ACL mapping into "POSIX ACL" (getfacl/setfacl's Linux xattr) 
format from the CIFS/NTFS style.
4) streams (which could be mapped in a few cases to xattrs, but are getting
increasingly used and therefore important for certain types of apps - like
network backup e.g. to be able to get access to)

The first two are in the on disk format already of various filesytems (NTFS, VFAT, even JFS, and would be trivial 
for me to export in the cifs vfs.  I suspect NFSv4 which is similar to CIFS in many ways would also have
an easy time of exporting a few of those.   The first two of these could of course be simply special casings
the reserved xattr name "User.DosAttribute" or equivalent used by Samba4.  This has a few advantages - local apps work 
and migrations to Linux from Windows are easier (as more data is preserved)  :)

Note that NTFS now has a form of symlink stored in "OS/2 EAs" on disk (I see them show up on test systems 
when the Unix Services are loaded) as well as Unix like devices - very strange but potentially could 
be mapped into something that made sense to Linux.


