Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbTGCGlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 02:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTGCGlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 02:41:39 -0400
Received: from remt19.cluster1.charter.net ([209.225.8.29]:59077 "EHLO
	remt19.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265398AbTGCGli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 02:41:38 -0400
Message-ID: <3F03D387.8000501@mrs.umn.edu>
Date: Thu, 03 Jul 2003 01:56:07 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: New idea for file-based mounts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using mount/umount syscalls, have a file that exists 
per-directory named, say, ..mount.  Then, to mount /dev/sda at /home, 
you issue the command
echo "/dev/sda rw" > /home/..mount
(Almost the same syntax as mtab.) The OS takes action (upon modification 
of the ..mounts file) and attempts the mount.  Reading back the file 
would show:
/dev/sda rw

if the mount suceeded, otherwise it would be null if there is an error.  
To unmount the file system, remove that line from the ..mounts file.

Now, if you want to do layered mounts, a la plan 9, you could search 
from the top line through the last line.  Say you had a directory, 
/programs.  You want to make a union of directories together, so you 
make /programs/..mounts look like:
/home/root/bin rw
/bin ro
/sbin ro
/usr/bin ro

Since /home/root/bin rw is read-write, any newly written files in 
/programs really go in /home/root/bin.  But you see files from each of 
the four directories (unless they have duplicate names, then higher in 
the list takes precedence) due to the unioning.

Why do this? A few reasons: one could set unix permissions/acl's on the 
..mounts file--you could easily let non-root users perform mount 
operations on certain directories.  Then you don't need mount and 
unmount commands as well.


