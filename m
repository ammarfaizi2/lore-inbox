Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUAZQOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUAZQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 11:14:00 -0500
Received: from lists.us.dell.com ([143.166.224.162]:2221 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266116AbUAZQN4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 11:13:56 -0500
Date: Mon, 26 Jan 2004 10:13:49 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EDD report URL change
Message-ID: <20040126101348.A21462@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, thanks for merging my changeset 1.1505 below into -rc1-mm2
already.   I append a patch my changeset 1.1506 below, which changes
the EDD report URL to a new dell.com server.

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd-for-linus

This will update the following files:

 Documentation/i386/zero-page.txt |    4 +++-
 arch/i386/boot/setup.S           |   21 +++++++++++++++++++++
 arch/i386/kernel/edd.c           |   26 +++++++++++++++++++++++---
 arch/i386/kernel/i386_ksyms.c    |    6 ------
 arch/i386/kernel/setup.c         |    7 +++++++
 include/asm-i386/edd.h           |    6 +++++-
 include/asm-i386/setup.h         |    1 +
 7 files changed, 60 insertions, 11 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (04/01/26 1.1506)
   EDD: change report URL, bump version

<Matt_Domsch@dell.com> (04/01/20 1.1505)
   EDD: read disk80 MBR signature, export through edd module
   
   There are 4 bytes in the MSDOS master boot record, at offset 0x1b8,
   which may contain a per-system-unique signature.  By first writing a
   unique signature to each disk in the system, then rebooting, and then
   reading the MBR to get the signature for the boot disk (int13 dev
   80h), userspace may use it to compare against disks it knows as named
   /dev/[hs]d[a-z], and thus determine which disk is the BIOS boot disk,
   thus where the /boot, / and boot loaders should be placed.
     
   This is useful in the case where the BIOS is not EDD3.0 compliant,
   thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
   boot disk, yet you need to know which disk is the boot disk.  It's
   most useful in OS installers.
      
   This patch retrieves the signature from the disk in setup.S, stores it
   in a space reserved in the empty_zero_page, copies it somewhere safe
   in setup.c, and exports it via
   /sys/firmware/edd/int13_disk80/mbr_signature in edd.c.  Code is
   covered under CONFIG_EDD=[ym].


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1506, 2004-01-26 09:54:48-06:00, Matt_Domsch@dell.com
  EDD: change report URL, bump version


 edd.c |    4 ++--
 1 files changed, 2 insertions, 2 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Mon Jan 26 10:03:36 2004
+++ b/arch/i386/kernel/edd.c	Mon Jan 26 10:03:36 2004
@@ -60,9 +60,9 @@
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.11 2003-Dec-17"
+#define EDD_VERSION "0.12 2004-Jan-26"
 #define EDD_DEVICE_NAME_SIZE 16
-#define REPORT_URL "http://domsch.com/linux/edd30/results.html"
+#define REPORT_URL "http://linux.dell.com/edd/results.html"
 
 #define left (PAGE_SIZE - (p - buf) - 1)
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1506
## Wrapped with gzip_uu ##


M'XL( %@Z%4   \64VV[30!"&K[-/,4HNP?;L.;$45&@B:"DT<@DW"$4;>X.C
M^!#9FP*2'Q[;I0=0*2JJA&U9]FAF-/^_GV8$R]I6X>"=<6XU*_,Z3LD(WI2U
M"P>)S3(_+O,V$)5E&PC2,K=!GO1IP7H7V"0)LFUQ^.8Q7WKMG[<I*Z^+U*2M
M6A@7IW!IJSH<4)_?1-SWO0T'T?SU\NQE1,AT"L>I*;[8"^M@.B6NK"Y-EM1'
MQJ596?BN,D6=6V>Z89J;U(8ALO:65'.4JJ$*A6YBFE!J!+4),C%6@MQ1=G2M
MZ--/#9]_[2:0M@VID%PUBJ)",@/J4XD*4 1( ]9^3$(I0C'V4(6(<%]W>$;!
M0_(*GE;(,8EA/IN%$/>%4-E]63E81F?/87W(][W1V[(@;T$A%9HL;FTEWB,O
M0M @>7&OOL94[?%O^5@%.UL5-NLX\.->!D6<,*1<BH9*ID4S46JB-QN]-@G?
M:!,_MF-W)HI**;AH&--:][S<G]_!\^0#_P6@AR?O:!)<-HSCF/<T,?R=)2X>
M9(F!Q_XG2U>FGX-7?>V?EHW%'_S_!\IFB@,E)_U[E-C-MK#=8*N/\^CBY/P]
M#-&G##HWO5-3>$P-VQ+9E\@[)=%\<1Y]6+7SPS!U;A\&5WO)O_:Q7U65K0^9
?J_W4Y=GP=D'%J8UW]2&?QE9KJ=>,_ #0G52T%@4     
 
