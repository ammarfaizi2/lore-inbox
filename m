Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUEFRV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUEFRV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUEFRV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:21:58 -0400
Received: from dns.texnet.it ([151.99.150.6]:40876 "EHLO dns.texnet.it")
	by vger.kernel.org with ESMTP id S261576AbUEFRVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:21:55 -0400
Date: Thu, 6 May 2004 19:21:52 +0200
From: Niccolo Rigacci <niccolo@rigacci.org>
To: linux-kernel@vger.kernel.org
Subject: 2Gb file size limit on 2.4.24, LVM and ext3?
Message-ID: <20040506172152.GB17351@paros.rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all!

I got a very strange problem: I can create files larger than 2
Gb (even 5 Gb), but I can't read them back.

- The simple "cat" command fails with:
  # ls -la pippo
  -rw-r--r--    1 root     root     2147483648 May  6 17:03 pippo
  # cat pippo
  cat: pippo: Operation not permitted

- A file just 2kb under 2Gb, reads fine.

- If I do an "strace cat pippo" it works fine! So how can
  I trace the problem further?

- The partition is an ext3 over LVM, kernel 2.4.24. Debian Woody
  (glibc-2.2.5-11.5). Pentium 4 2.80GHz.
  I tried both a quoted filesystem and a non quoted with same
  results.

- On a very similar system I have no problem, the main
  difference is using LVM here.

Is there a known issue? Can someone tell me how can trace down
the problem?


Many thanks!

Please CC to me if you can.



Some info on the machine:

# uname -a
Linux argo 2.4.24 #1 Wed Feb 11 19:03:31 CET 2004 i686 unknown

# cat /proc/lvm/global
LVM driver LVM version 1.0.7(28/03/2003)
Total:  1 VG  1 PV  2 LVs (2 LVs open 2 times)
Global: 41615 bytes malloced IOP version:10 57 days ... active
VG:  vg0  [1 PV, 2 LV/2 open]  PE Size: 32768 KB
  Usage [KB/PE]: 76709888/2341 total 76709888/2341 used 0/0 free
  PV:  [AA] md2  76709888 /2341   76709888 /2341     0 /0
    LVs: [AWDL  ] var             20971520 /640      1x open
         [AWDL  ] home            55738368 /1701     1x open

argo:~# mount
/dev/md0 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/vg0/var on /var type ext3 (rw)
/dev/vg0/home on /home type ext3 (rw,nodev,usrquota)

-- 
Niccolo Rigacci
Firenze - Italy

War against Iraq? Not in my name!
