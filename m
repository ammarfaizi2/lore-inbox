Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbWBNR2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWBNR2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWBNR2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:28:39 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:25502 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1422697AbWBNR2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:28:38 -0500
Message-ID: <43F220B6.1080406@soleranetworks.com>
Date: Tue, 14 Feb 2006 11:25:58 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMBFS Locking Issues with Advanced Server 2000/2003 [kernel 2.6.14]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attached errors.  Intermittent errors occur when VNC viewer is installed 
and running from a remote server which is also mapped
with smbfs.  Problem can be recreated by executing perl commands 
remotely against source code stored on a Windows 2000/2003
Advanced Server.  There are no other applications locking the code.  The 
first error occurs when running Perl and Perl hangs remotely
and the process never returns.  After hitting control C to break out of 
Perl, SMBFS leaves the files locked remotely and they cannot be deleted 
until the volume is unmounted.  Unmounting and remounting clears the 
problem, but this is dirty and should recover more gracefully.

Mount also reports erroneously when this occurs that the volume is 
mounted twice, which it is not the case -- the volume was only mounted
once. 

Perl command:

perl -pi -e "s/interface/interfaceIndex/g" *[ch]

erroneous mount info:

/dev/sda3 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda1 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
/dev/sda4 on /pfs type dsfs (rw)
//192.168.2.27/dsfs on /win type smbfs (0)
//192.168.2.27/dsfs on /win type smbfs (0)


Error returned after perl croaks:

[root@predator dsarchive]#
[root@predator dsarchive]# rm -rf 01-14-06-final/
rm: cannot remove `01-14-06-final//utils/dscapture.c': Text file busy
rm: cannot remove `01-14-06-final//utils/dsinput.c': Text file busy
[root@predator dsarchive]#
[root@predator dsarchive]#
[root@predator dsarchive]#

Jeff
