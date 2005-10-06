Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVJFPIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVJFPIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVJFPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:08:29 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:32853 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1751075AbVJFPI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:08:29 -0400
DomainKey-Signature: a=rsa-sha1; b=IA4oGvEGzzhLojxefa2YnVg0IjWxmuFQUWinKhvjyFJGwUH2etAtWqGoiafnkzP1pySxLzSuIP42lD4XfTh0re149cMEaMKioTr41dSwKSpVojq5LFdl8O00uzFmqS/WQY1y+ynFF9ls4dY4UYZer5rTNCHk4QETzLlXdWsHizY=; c=nofws; d=rudy.mif.pg.gda.pl; q=dns; s=prime
Date: Thu, 6 Oct 2005 17:08:26 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
cc: dm-devel@redhat.com
Subject: [2.6.14-rc3-git3/x86_64]: lvrename stalls on rename snapshot volume
Message-ID: <Pine.BSO.4.62.0510061349190.28198@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-309887809-1128609134=:28198"
Content-ID: <Pine.BSO.4.62.0510061652130.28198@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-309887809-1128609134=:28198
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0510061652131.28198@rudy.mif.pg.gda.pl>


[root@v20z-2 ~]# vgs -a; lvs
File descriptor 3 left open
File descriptor 5 left open
File descriptor 7 left open
   VG     #PV #LV #SN Attr  VSize   VFree
   users    1   2   0 wz--n 499,99G 49,99G
   v20z.2   1   3   0 wz--n  63,75G     0
   zie      1   3   0 wz--n 124,99G 56,99G
File descriptor 3 left open
File descriptor 5 left open
File descriptor 7 left open
   LV       VG     Attr   LSize   Origin Snap%  Move Log Copy%
   prac     users  -wi-ao 225,00G
   studenci users  -wi-ao 225,00G
   home     v20z.2 -wi-ao  33,75G
   root     v20z.2 -wi-ao  10,00G
   var      v20z.2 -wi-ao  20,00G
   mail     zie    -wi-ao  24,00G
   mailman  zie    -wi-ao   8,00G
[root@v20z-2 ~]# lvcreate -s -L5G -c 4k -p r -n prac-1 /dev/users/prac
File descriptor 3 left open
File descriptor 5 left open
File descriptor 7 left open
   Logical volume "prac-1" created
[root@v20z-2 ~]# lvs -a
File descriptor 3 left open
File descriptor 5 left open
File descriptor 7 left open
   LV       VG     Attr   LSize   Origin Snap%  Move Log Copy%
   prac     users  owi-ao 225,00G
   [prac-1] users  sri-a-   5,00G prac     0,00
   studenci users  -wi-ao 225,00G
   home     v20z.2 -wi-ao  33,75G
   root     v20z.2 -wi-ao  10,00G
   var      v20z.2 -wi-ao  20,00G
   mail     zie    -wi-ao  24,00G
   mailman  zie    -wi-ao   8,00G
   srv      zie    -wi-ao  36,00G
[root@v20z-2 ~]# lvrename /dev/users/prac-1 /dev/users/prac-2
File descriptor 3 left open
File descriptor 5 left open
File descriptor 7 left open

And in this poind lvrename stalls with sleeping in kernel in function:

# ps -eo wchan,args | grep lvrename
sync_b lvrename /dev/users/prac-1 /dev/users/prac-2
^^^^^^

lvrename can't be killed. Also system can't be shutdowned because hanging 
lvrename stops shutdown. All other works correctly and there is kernel 
messages.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-309887809-1128609134=:28198--
