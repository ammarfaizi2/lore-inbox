Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267889AbUIURe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbUIURe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUIURe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:34:56 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:29665 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S267889AbUIURew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:34:52 -0400
Message-ID: <4150662C.9030407@dssimail.com>
Date: Tue, 21 Sep 2004 12:34:36 -0500
From: "Mr. Berkley Shands" <berkley@dssimail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: "df" errors for NFS mounted filesystems under 2.6.9-rc*
Content-Type: multipart/mixed;
 boundary="------------030102070505050307050709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030102070505050307050709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've noticed that the reported disk space for NFS mounted partitions is 
very broken under 2.6.9-[rc1, rc2, rc2-bk7].
"df -k" and "df -h" report wildly different stats between 2.6.6 and 
2.6.9*. See attached...
I don't know if this is the version of nfs mount or some other kernel 
interaction. It does not appear to
hurt anything (no crashes or panics :-).

berkley

--------------030102070505050307050709
Content-Type: text/plain;
 name="bad.df"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bad.df"

linux-2.6.9-rc* seems to have a problem reporting NFS mounted disk subsystems statistics :-)
2.6.9-rc1, -rc2 and -rc2-bk7 all show the WRONG file systems sizes (redHat ES3.0 U3, x86_64)
in this example.

root@typhoon raid0/berkley/sources> uname -a
Linux typhoon 2.6.6 #74 SMP Mon Sep 20 10:21:28 CDT 2004 x86_64 x86_64 x86_64 GNU/Linux

root@typhoon /root> df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             1.9G  385M  1.5G  22% /
/dev/hda2             7.6G  5.2G  2.0G  73% /usr
/dev/hda3             1.9G  241M  1.6G  14% /var
/dev/hda6              24G   33M   23G   1% /export0
/dev/md2              602G   30G  542G   6% /s0
none                  3.7G     0  3.7G   0% /dev/shm
hurricane:/raid0      203G   51G  142G  27% /raid0
hurricane:/raid1      871G  263G  564G  32% /raid1
hurricane:/raid2      1.2T   19G  1.1T   2% /raid2
hurricane:/raid3      766G  160G  569G  22% /raid3
hurricane:/export0     20G  9.6G  9.4G  51% /export/hurricane
root@typhoon /root> df -k
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda1              1968872    393728   1475128  22% /
/dev/hda2              7874688   5399696   2074968  73% /usr
/dev/hda3              1968904    246364   1622524  14% /var
/dev/hda6             24686908     32828  23400032   1% /export0
/dev/md2             630269456  30490980 567762580   6% /s0
none                   3830756         0   3830756   0% /dev/shm
hurricane:/raid0     211931872  52802732 148363604  27% /raid0
hurricane:/raid1     912392924 275583268 591181444  32% /raid1
hurricane:/raid2     1225352628  19873668 1144199824   2% /raid2
hurricane:/raid3     803099344 166823728 596113120  22% /raid3
hurricane:/export0    20896660   9982100   9853068  51% /export/hurricane

root@typhoon /root> uname -a
Linux typhoon 2.6.9-rc2-bk7 #19 SMP Tue Sep 21 12:03:21 CDT 2004 x86_64 x86_64 x86_64 GNU/Linux

root@typhoon /root> df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             1.9G  389M  1.5G  22% /
/dev/hda2             7.6G  5.2G  2.0G  73% /usr
/dev/hda3             1.9G  240M  1.6G  14% /var
/dev/hda6              24G   33M   23G   1% /export0
/dev/md2              602G   30G  542G   6% /s0
none                  3.7G     0  3.7G   0% /dev/shm
hurricane:/raid0       26G  6.3G   18G  27% /raid0
hurricane:/raid1      109G   33G   71G  32% /raid1
hurricane:/raid2      147G  2.4G  137G   2% /raid2
hurricane:/raid3       96G   20G   72G  22% /raid3
hurricane:/export0    2.5G  1.2G  1.2G  51% /export/hurricane
root@typhoon /root> df -k
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda1              1968872    397440   1471416  22% /
/dev/hda2              7874688   5399696   2074968  73% /usr
/dev/hda3              1968904    246180   1622708  14% /var
/dev/hda6             24686908     32828  23400032   1% /export0
/dev/md2             630269456  30490980 567762580   6% /s0
none                   3818292         0   3818292   0% /dev/shm
hurricane:/raid0      26491484   6600340  18545452  27% /raid0
hurricane:/raid1     114049116  34447908  73897684  32% /raid1
hurricane:/raid2     153169080   2484208 143024980   2% /raid2
hurricane:/raid3     100387420  20852968  74514140  22% /raid3
hurricane:/export0     2612084   1247764   1231636  51% /export/hurricane

--------------030102070505050307050709--
