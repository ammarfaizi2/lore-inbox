Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVHHO1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVHHO1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVHHO1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:27:00 -0400
Received: from no-dns-yet.demon.co.uk ([195.173.84.2]:26128 "EHLO
	monitor.bluefinger.com") by vger.kernel.org with ESMTP
	id S932081AbVHHO07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:26:59 -0400
From: Thomas Chiverton <thomas.chiverton@bluefinger.com>
To: linux-kernel@vger.kernel.org
Subject: cifs kernel module and MS DFS shares [2.6.12-1.1411_FC4]
Date: Mon, 8 Aug 2005 15:26:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081526.55555@moveAlongNothingToSeeHere>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I was referred here by Thomas Anders over on the Samba list, as apparently 
it's the cifs kernel module at fault ?).

I am having problems mounting a DFS share using mount.cifs, even though it 
works in smbclient fine.
After mounting, each top-level directory contains a copy of the top level 
directory.
Turning up debug and verbose don't seem to help. Any ideas ?

I can mount non-DFS shares from the same CIFS server fine.

[tom@charles-compaq@1306 /home/tom/Projects/gbb-core-app ]
  smbclient //exchsvr/dfs -U tchiverton -W BLUEFINGER
Password:
Domain=[BLUEFINGER] OS=[Windows Server 2003 3790 Service Pack 1] 
Server=[Windows Server 2003 5.2]
smb: \> ls
  .                                   D        0  Sun Aug  7 16:06:52 2005
  ..                                  D        0  Sun Aug  7 16:06:52 2005
  Applications                        D        0  Sun Aug  7 16:06:52 2005
  Common                              D        0  Sun Aug  7 13:54:40 2005
  Consultants                         D        0  Sun Aug  7 14:01:50 2005
  Directors                           D        0  Sun Aug  7 14:06:19 2005
  Engineering                         D        0  Sun Aug  7 13:57:48 2005
  Finance                             D        0  Sun Aug  7 13:53:59 2005
  Management                          D        0  Sun Aug  7 10:37:01 2005
  Software Development                D        0  Sun Aug  7 13:58:54 2005
  Version                             D        0  Sun Aug  7 14:04:56 2005
  WinTA Data                          D        0  Sun Aug  7 14:10:29 2005

                44955 blocks of size 2097152. 25934 blocks available
smb: \> cd Consultants
smb: \Consultants\> ls
  .                                   D        0  Wed Aug  3 11:51:57 2005
  ..                                  D        0  Sun Aug  7 12:19:03 2005
  NO                                  D        0  Thu Nov 18 10:35:49 2004
  EEZ Course                          D        0  Wed Mar 23 13:48:54 2005
  BlueFinger Software Library         D        0  Tue Jul  5 13:39:32 2005
  IM                                  D        0  Wed Aug  3 13:19:30 2005

                55995 blocks of size 1048576. 9499 blocks available
smb: \Consultants\> exit

Great ! So now...

[root@charles-compaq gbb_domain]#  mount.cifs //exchsvr/dfs /mnt/dfs/ -o 
user=tchiverton,domain=BLUEFINGER
Password:
[root@charles-compaq gbb_domain]#  ls /mnt/dfs/
Applications  Consultants  Engineering  Management            Version
Common        Directors    Finance      Software Development  WinTA Data
[root@charles-compaq gbb_domain]# ls /mnt/dfs/Consultants/
Applications  Consultants  Engineering  Management            Version
Common        Directors    Finance      Software Development  WinTA Data
[root@charles-compaq gbb_domain]#      

Bah :-(
-- 

Tom Chiverton 
Advanced ColdFusion Programmer
