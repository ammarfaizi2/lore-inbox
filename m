Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287936AbSAMCBX>; Sat, 12 Jan 2002 21:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287945AbSAMCBF>; Sat, 12 Jan 2002 21:01:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62651 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287936AbSAMCAq>;
	Sat, 12 Jan 2002 21:00:46 -0500
Date: Sat, 12 Jan 2002 21:00:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <200201120804.AAA19339@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201122045540.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Jan 2002, H. Peter Anvin wrote:

> Field name    Field size	 Meaning
> c_magic	      6 bytes		 The string "070701" or "070702"
> c_ino	      8 bytes		 File inode number
> c_mode	      8 bytes		 File mode and permissions
> c_uid	      8 bytes		 File uid
> c_gid	      8 bytes		 File gid
> c_nlink	      8 bytes		 Number of links
> c_mtime	      8 bytes		 Modification time
> c_filesize    8 bytes		 Size of data field
> c_maj	      8 bytes		 Major part of file device number
> c_min	      8 bytes		 Minor part of file device number
> c_rmaj	      8 bytes		 Major part of device node reference
> c_rmin	      8 bytes		 Minor part of device node reference
> c_namesize    8 bytes		 Length of filename, including final \0
> c_chksum      8 bytes		 CRC of data field if c_magic is 070702

+				or "00000000" if it's 070701.  Kernel
+				is not expected to verify it in any case.
 
> The c_mode field matches the contents of st_mode returned by stat(2)
> on Linux, and encodes the file type and file permissions.
 
- The c_filesize should be zero for any non-regular file.
+ The c_filesize can be non-zero only for regular files and symlinks.
+ For symlinks data and c_filesize match the results of readlink(2).
+ Having more than one link to a symlink is illegal.

