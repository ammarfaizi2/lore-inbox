Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264866AbSJ3TxN>; Wed, 30 Oct 2002 14:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSJ3Tw0>; Wed, 30 Oct 2002 14:52:26 -0500
Received: from smtp3.us.dell.com ([143.166.148.134]:45319 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S264866AbSJ3Ttf>; Wed, 30 Oct 2002 14:49:35 -0500
Date: Wed, 30 Oct 2002 13:56:00 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 2.5.44] EDD updates 2/4
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68BC03E6@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0210301355350.27031-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.810, 2002-10-23 11:18:52-05:00, Matt_Domsch@dell.com
  EDD: cleanups
  
  print PCI info as %02x.%02x.%d
  Don't warn about nonexistant SCSI devices if it's not a SCSI device


 edd.c |    6 +++---
 1 files changed, 3 insertions, 3 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Wed Oct 23 13:15:44 2002
+++ b/arch/i386/kernel/edd.c	Wed Oct 23 13:15:44 2002
@@ -194,7 +194,7 @@
 	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
 		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
 		p += snprintf(p, left,
-			     "\t%02x:%02x.%01x  channel: %u\n",
+			     "\t%02x:%02x.%d  channel: %u\n",
 			     info->params.interface_path.pci.bus,
 			     info->params.interface_path.pci.slot,
 			     info->params.interface_path.pci.function,
@@ -354,7 +354,7 @@
 						  pci.function));
 		if (!pci_dev) {
 			p += snprintf(p, left, "Error: BIOS says this is a PCI device, but the OS doesn't know\n");
-			p += snprintf(p, left, "  about a PCI device at %02x:%02x.%01x\n",
+			p += snprintf(p, left, "  about a PCI device at %02x:%02x.%d\n",
 				     info->params.interface_path.pci.bus,
 				     info->params.interface_path.pci.slot,
 				     info->params.interface_path.pci.function);
@@ -365,7 +365,7 @@
 		}
 	}
 
-	if (found_pci) {
+	if (found_pci && !edd_dev_is_type(edev, "SCSI")) {
 		sd = edd_find_matching_scsi_device(edev);
 		if (!sd) {
 			p += snprintf(p, left, "Error: BIOS says this is a SCSI device, but\n");

===================================================================


This BitKeeper patch contains the following changesets:
1.810
## Wrapped with gzip_uu ##


begin 664 bkpatch19565
M'XL(`%#GMCT``]U4:VO;,!3];/V*NY2^:&WKX5<,&5WCLI5M+*3T6R$HMKR8
M.E*PE+9C_O&3G:P-I1NL]--DX8OD>X]USCUH#ZZU:%+G*S=FEJFESA=H#SXI
M;5*G$'7MY6II-Z9*V0U_H9;"7Q9]FC^_]>M*KA]<ZH6N*`K7J&ZMD<V?<),O
MX$XT.G6(QQYWS(^52)WIQ<?K+Q^F"(U&,%YP^5U<"0.C$3*JN>-UH<^X6=1*
M>J;A4B^%X=TQVL?4EF),[1.2F.$P:DF$@[C-24$(#X@H,`V2*$`[G,Y^<WD&
M0NRTD9"PI2RA&&5`O(1@P-0GV*<,"$E)DH;4Q6&*,;R$"2<$7(S.X6V//T8Y
M7&19"GDMN%ROM%W;N6HJ:6`ROH1*E@JXAGU,'[S-J[`)F9*'!NYY(X'/U=J`
M5%(\5-IP6W<UOKJ$0MQ5N=!0E5"90VT3#/#=3^@S6#D809.G_B#W'P="F&/T
M_D7)6MY8!U4LB?Q;T4A1^]9`7K[M"1Y23%@8M"2D<=`.HV@8EV4\YP4K8YZ_
M`I$R$I'$JHP3'`>]\5[.[USXY@=^!2(E)&*,TM8:!`][6[+GI@SBOYJ2@<O^
M,U/VS?L&;G/?3^NQR1_Z^`JW9F08`T&7F^`X#G1C<&,Z%NF6"D!N%;._26%_
M?2,'IRAC85^V";9L!2<CT+*7I#Q:G4(M2G,*`]@RY[U.&T[`#>S";Q&CI$?L
M@V,%.2K56A:S55[!P0&\LPQGMGY6Z5EWH1X)N[`_Z+0:'!_#SZ<;.%^(_%:O
2EZ,Y%WP8)@+]`@(O_5SQ!0``
`
end

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


