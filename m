Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSDZP6j>; Fri, 26 Apr 2002 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313422AbSDZP6i>; Fri, 26 Apr 2002 11:58:38 -0400
Received: from host194.steeleye.com ([216.33.1.194]:56337 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S312414AbSDZP6h>; Fri, 26 Apr 2002 11:58:37 -0400
Message-Id: <200204261558.g3QFwUq04782@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [BKPATCH] boot hang in migration threads with 2.5.9 and 2.5.10
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Apr 2002 10:58:30 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an obvious and simple one line fix for a missing CPU logical to 
physical mapping (against 2.5.9).  Without this, my SMP boxes hang forever 
after printing out the migration thread start information.

James Bottomley

===================================================================


ChangeSet@1.531.9.1, 2002-04-26 10:43:28-05:00, jejb@mulgrave.(none)
  Fix migration task boot hang for machines with different physical
  and logical CPU numberings.


 sched.c |    2 +-
 1 files changed, 1 insertion, 1 deletion


diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Apr 26 10:54:56 2002
+++ b/kernel/sched.c	Fri Apr 26 10:54:56 2002
@@ -1760,7 +1760,7 @@
 	current->cpus_allowed = -1L;
 
 	for (cpu = 0; cpu < smp_num_cpus; cpu++)
-		while (!cpu_rq(cpu)->migration_thread)
+		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
 			schedule_timeout(2);
 }
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
1.531.9.1
## Wrapped with gzip_uu ##


begin 664 bkpatch2152
M'XL(`%!XR3P``[64:VO;,!2&/T>_XHQ^:1A1=+,3&U+2RRZEA86.?"Z*?!*[
ML>7,4M(5_.,GMR5=1Z"L;+9!EG7\ZKQ'CW0$<X=-VKO#NP4Y@J^U\VFOTF6)
M#[0HJ?.(X16IJ:LP?%/787A862^&W1_#LZOAV?SR^F(@:$1"P$Q[D\,.&Y?V
M.)7[+_YA@VGOYM.7^?7I#2&3"9SGVJ[P.WJ83(BOFYTN,S?5/B]K2WVCK:O0
MZV[>=A_:"L9$N",^DBR*6QXS-6H-SSC7BF/&A!K'BF2Z1+,NIK@K7%';P0ZM
MWS;H#HDI(03GDLDV%D&47`"GD>0TH1R8&#(U%#%PEBJ9BO&`12ECT#F?5MMR
MU>@=TF-;6^S#1PX#1L[@WUHY)P8^%S^A*L)D/I@!K]T:%F$=H)."9=U`I4U>
M6'1P7_@<LF*YQ"98ADW^X`JCRZ"A;09EO>IZ<#Z;@]U6"VP*NW*47$$L6<+)
M[&5-R.`O+T*89N3D#?=K;"R60V=RS*CYO02)3%HU$E*TT6(A)!\)$[-,8B(/
M5ON@DA(QCV2BDI8SR=0C9:_CWD;M/1F296UR/T7GJ$5#,SR<'4^85%*-6S:.
MH_@)-$XY%:]!DTFJDK=`X_\%M-,L"Z`Y%[#8P^+K/49@-ELPM>UV=R`Q</-4
MYV\P:.X?G\#![(^2OX.D"SZ*)7!R^=SV>O=Y42(<?P@)W#8_CKOF.;_;2F^Z
F?K\_.-GOD5N?-ZBS_LN!%'(Q:[>M)IRI1602)+\`GJW5%_@$````
`
end


