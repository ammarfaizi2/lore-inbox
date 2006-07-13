Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWGMUP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWGMUP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWGMUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:15:27 -0400
Received: from outbound.nfsmt.com ([69.51.125.2]:32296 "EHLO
	kal-l-crp-mal01.corp.nfs.add") by vger.kernel.org with ESMTP
	id S1030349AbWGMUPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:15:25 -0400
Subject: RE: [NFS] nfs problems with 2.6.18-rc1
Date: Thu, 13 Jul 2006 14:15:23 -0600
MIME-Version: 1.0
Message-ID: <ED449C7CEC5CA740AB9445940556EC521D8B@kal-l-crp-mal01.corp.nfs.add>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [NFS] nfs problems with 2.6.18-rc1
Thread-Index: AcamqVwhtNOWTB9VRqOfrwOef722HwADnF0g
From: "Ottman, Tom" <Tom.Ottman@nfsmt.com>
To: "Janos Farkas" <chexum+dev@gmail.com>, <linux-kernel@vger.kernel.org>,
       <nfs@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of today I have been receiving your email strings, and I am not
aware why.  
The reference that is close is the NFS, which on my end is National
Flood Services in Kalispell, MT.   
I you could remove me from your distribution list, it would be greatly
appreciated.

Thanks, 

Thomas Ottman
Program Manager, NFS 
(888) 888-2169 ext 545
Fax (406) 257-1292
tom.ottman@nfsmt.com

 
-----Original Message-----
From: nfs-bounces@lists.sourceforge.net
[mailto:nfs-bounces@lists.sourceforge.net] On Behalf Of Janos Farkas
Sent: Thursday, July 13, 2006 12:22 PM
To: linux-kernel@vger.kernel.org; nfs@lists.sourceforge.net
Subject: [NFS] nfs problems with 2.6.18-rc1

Hi!

I recently updated two (old) hosts to 2.6.18-rc1, and started noticing
weird things with the nfs mounted /home s.

I frequently face EACCESs where a few minutes ago there wasn't any
problem, and after a retry everything does work again.

An example that easily trips it is keeping mutt open
on a single mailbox file (strace -tt| grep stat):

20:04:08.393815 stat64("mailbox", {st_mode=S_IFREG|0600, st_size=401000,
...}) = 0
20:08:41.859168 stat64("mailbox", {st_mode=S_IFREG|0600, st_size=401000,
...}) = 0
20:09:30.975876 stat64("mailbox", 0xbfe8966c) = -1 EACCES (Permission
denied)

This results in a bit scary "Mailbox was corrupted!" message, but
otherwise harmless.  Reopening the mailbox succeeds immediately.

A sample session with an rsync session updating files on the nfs mounted
/home/:

-----
> rsync...
receiving file list ... done
file1
rsync: close failed on "/home/path/.file1.UgEmSh": Permission denied
(13)
rsync error: error in file IO (code 11) at receiver.c(628) [receiver]
rsync: connection unexpectedly closed (2490 bytes received so far)
[generator]
rsync error: error in rsync protocol data stream (code 12) at io.c(471)
[generator]
> rsync...
receiving file list ... done
rsync: recv_generator: failed to stat "/home/path/file2": Permission
denied (13)
rsync: recv_generator: failed to stat "/home/path/file3": Permission
denied (13)
rsync: recv_generator: failed to stat "/home/path/file4": Permission
denied (13)
rsync: recv_generator: failed to stat "/home/path/file5": Permission
denied (13)
rsync: recv_generator: failed to stat "/home/path/file6": Permission
denied (13)
rsync: recv_generator: failed to stat "/home/path/file7": Permission
denied (13)
-----

I also think this is related in the dmesg.  Think, because there's no
other trace of any "read error" on the disks, and the comments in
mm/filemap.c (but the message is not that much help to be sure of this).

Reducing readahead size to 28K
Reducing readahead size to 4K
Reducing readahead size to 28K
Reducing readahead size to 4K
Reducing readahead size to 28K
Reducing readahead size to 4K
Reducing readahead size to 0K

The relevant part of the /proc/mounts file:

-----
automount(pid1831) /home autofs rw 0 0
HOST:/export/PATH /home/path nfs
rw,vers=3,rsize=8192,wsize=8192,hard,intr,nolock,proto=udp,timeo=7,retra
ns=3,sec=sys,addr=HOST 0 0
-----

How can I help with tracing this?  git bisecting on these machines takes
at least an hour per step, (and no reasonable connectivity either to
compile elsewhere much quicker).

Janos


------------------------------------------------------------------------
-
Using Tomcat but need to do more? Need to support web services,
security?
Get stuff done quickly with pre-integrated technology to make your job
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs

