Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVHIJdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVHIJdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVHIJdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:33:47 -0400
Received: from [193.151.93.131] ([193.151.93.131]:787 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S932488AbVHIJdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:33:46 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Xavier Roche <roche+kml2@exalead.com>
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
Date: Tue, 9 Aug 2005 11:33:21 +0200
User-Agent: KMail/1.7.2
References: <42F8720D.4060300@picsearch.com>
In-Reply-To: <42F8720D.4060300@picsearch.com>
Cc: linux-kernel@vger.kernel.org, vinays@burntmail.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hhH+CzMXL8MOmPi"
Message-Id: <200508091133.21837.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_hhH+CzMXL8MOmPi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached (sorry, couldn't get it to not word-wrap inline) is a patch to remove 
incorrect documentation regarding overcommit.

On Tuesday 09 August 2005 11:06, you wrote:
> vinay wrote:
> > I have a problem with linux kernel's Out Of Memory (OOM) killer.

You're not alone.

> This condition should not occur without using overcommit. Are you sure
> you are not using overcommit ? (cat /proc/sys/vm/overcommit_memory)
>
> To dasable it:
> echo 0 > /proc/sys/vm/overcommit_memory

The documentation seems forked on this point, and from what I can see from the 
source (mm/mmap.c and include/linux/mman.h) 
Documentation/filesystems/proc.txt is wrong and Documentation/sysctl/vm.txt 
is right.

#define OVERCOMMIT_NEVER		2

> Overcommit is quite dangerous on production systems, because it leads to
> oom kills on heavy loads (at least, this is what I experienced).

... and it's on by default. bleh.



---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--Boundary-00=_hhH+CzMXL8MOmPi
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="overcommit_doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="overcommit_doc.patch"

diff -uprN linux-2.6.12.4.orig/CREDITS linux-2.6.12.4/CREDITS
--- linux-2.6.12.4.orig/CREDITS 2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4/CREDITS      2005-08-09 11:21:53.000000000 +0200
@@ -1267,6 +1267,12 @@ E: ehaase@inf.fu-berlin.de
 W: http://www.inf.fu-berlin.de/~ehaase
 D: Driver for the Commodore A2232 serial board
 
+N: Thomas Habets
+E: thomas@habets.pp.se
+W: http://www.habets.pp.se/
+D: Reader of code, slayer of wrongful documentation
+P: 1024D/AD48E854 A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854
+
 N: Bruno Haible
 E: haible@ma2s2.mathematik.uni-karlsruhe.de
 D: SysV FS, shm swapping, memory management fixes
diff -uprN linux-2.6.12.4.orig/Documentation/filesystems/proc.txt linux-2.6.12.4/Documentation/filesystems/proc.txt
--- linux-2.6.12.4.orig/Documentation/filesystems/proc.txt      2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4/Documentation/filesystems/proc.txt   2005-08-09 11:16:13.000000000 +0200
@@ -1240,16 +1240,7 @@ swap-intensive.
 overcommit_memory
 -----------------
 
-This file  contains  one  value.  The following algorithm is used to decide if
-there's enough  memory:  if  the  value of overcommit_memory is positive, then
-there's always  enough  memory. This is a useful feature, since programs often
-malloc() huge  amounts  of  memory 'just in case', while they only use a small
-part of  it.  Leaving  this value at 0 will lead to the failure of such a huge
-malloc(), when in fact the system has enough memory for the program to run.
-
-On the  other  hand,  enabling this feature can cause you to run out of memory
-and thrash the system to death, so large and/or important servers will want to
-set this value to 0.
+See Documentation/sysctl/vm.txt.
 
 nr_hugepages and hugetlb_shm_group
 ----------------------------------

--Boundary-00=_hhH+CzMXL8MOmPi--
