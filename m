Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSD1MY1>; Sun, 28 Apr 2002 08:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSD1MY0>; Sun, 28 Apr 2002 08:24:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57216 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S293680AbSD1MYZ>;
	Sun, 28 Apr 2002 08:24:25 -0400
Date: Sun, 28 Apr 2002 14:24:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: [bk+patch] Let (WIP) be replaced with (EXPERIMENTAL)
Message-ID: <20020428142415.A10747@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet@1.571, 2002-04-28 14:22:33+02:00, vojtech@twilight.ucw.cz
  This removes the CONFIG_IDEDMA_PCI_WIP option, replacing it with
  the more common CONFIG_EXPERIMENTAL. It also adds a depencency
  on $CONFIG_EXPERIMENTAL where missing.


 Config.help |    7 -------
 Config.in   |   13 ++++++-------
 2 files changed, 6 insertions(+), 14 deletions(-)


diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Sun Apr 28 14:22:55 2002
+++ b/drivers/ide/Config.help	Sun Apr 28 14:22:55 2002
@@ -299,13 +299,6 @@
 
   It is normally safe to answer Y; however, the default is N.
 
-CONFIG_IDEDMA_PCI_WIP
-  If you enable this you will be able to use and test highly
-  developmental projects. If you say N, the configurator will
-  simply skip those options.
-
-  It is SAFEST to say N to this question.
-
 CONFIG_BLK_DEV_PDC_ADMA
   Please read the comments at the top of <file:drivers/ide/ide-pci.c>.
 
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Sun Apr 28 14:22:55 2002
+++ b/drivers/ide/Config.in	Sun Apr 28 14:22:55 2002
@@ -47,18 +47,17 @@
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
-	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
-	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
+	 dep_bool '    Drive DMA black/whitelist (EXPERIMENTAL)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_EXPERIMENTAL
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
 	 dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
-	 dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
+	 dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3 $CONFIG_EXPERIMENTAL
 	 dep_bool '    AMD and nVidia chipset support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    CMD64X chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
   	 dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
-	 dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
+	 dep_mbool '      HPT34X AUTODMA support (EXPERIMENTAL)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_EXPERIMENTAL
 	 dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    Intel and Efar (SMsC) chipset support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 if [ "$CONFIG_BLK_DEV_PIIX" = "y" ]; then
@@ -68,15 +67,15 @@
 	    dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      IT8172 IDE Tuning support' CONFIG_IT8172_TUNING $CONFIG_BLK_DEV_IT8172 $CONFIG_IDEDMA_PCI_AUTO
 	 fi
-	 dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
-	 dep_mbool '    Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_IDEDMA_PCI_WIP
+	 dep_mbool '    Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_EXPERIMENTAL
 	 dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
 	 dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
 	 dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	 dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	 dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    VIA chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
       fi
 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch10736
M'XL(`)_IRSP``[56[V_:2!#]C/^*D7I2[]1B]H>-;21.I9A+K1*"@#3YAC;V
M!N_%]EJV$ZXG__&W-@%2:LK1NX!!8IF=]W;>O+'?P'7.LU[K2?Y9<#_4WL`G
MF1>]5K$6D5B%A?[HKW7_;[4^DU*M=T(9\\YS=.?NH2,"WB:ZJ:F(*2O\$)YX
MEO=:6*>[E>)KRGNMV>CB>CR8:5J_#\.0)2L^YP7T^UHALR<6!?D'5H213/0B
M8TD>\X+IOHS+76A)$"+J;6*+(K-;XBXRK-+'`<;,P#Q`Q+"[AO9,[</!`0[S
M&,3&!&/LE`:U;4=S`>NFA0&1#C(ZQ`9L]`CI4?H.D1Y"<"0MO"/01MI'^'\/
M,=1\6(0BAXS'\HGG4(0<AE>3/[R+I>>.W,O!<CKTEC?>%&1:")F\5Y%IQ'R1
MK$`4L!9%J%)4NV*9<5`<8IEL,XQNIZ.9=SF:+`9C';P"6)1+8$&0`X.`ISSQ
MU?55)5![?FG8!.N0JZRQR',%J&N?0171,K7I7EBM?>9+TQ!#VN^05BW37,4@
M$U5S52W7&<KD7JSTD$?IMJ9=A+"%:8D<9)&2V9P9=^K3]9EEXV,"_CAIW26$
M4%R2KN.8BMZ/=6Y()I(7FAL(*\VI0VA)L<,,Q\<*!%/#8><0W.;<TZ/J%ZJM
M=>0\E=%>J;1'+7>ZM,J`5FF8EDUJ`V+S.__A4_Y#T+9>Q7^SVGK*0QELO5:Q
M?P^)!(6PXADDG`<\J/I_TQY7T,[6]:7Z>7I,BI^PAJOT!>N8OB(Y/4;_0V>>
MH^\WG5FK2PUD;,8KML]7M_M:Z@XCSI+'%.3]9K;N*GDO(EXING'4:45%\C-Z
MF@B(YID8L-:J1N[R3LH(WH)ZN14&J!$/=VJ@/W36H2AX)/("?GTY@W][>W!#
MF(QNEN[,^S):CKWYPIM<S!MGM\(V%:I7?V^PXSTXP&#LP24V_Z)PXPXA?TQ3
MF2EH=S"Y&,VNKN=[7/7_4D5C\Y;ND#Z./R_=T9?OUK]ET*W.[75Q,X-/TP4U
M;F%PO;BJJK"CT'SZ3?1R&WU(Y#E9,P^KYF$UJ3"9VY:AYI$?BC17SRDG6&SA
MMML.:>QOVL>HT)H*;2K)5-W7[X4/KEB)@D4P:/^+NFR1IY5*+RMS@.O4N$Y#
L"1;\(6,Q+&:7Q$'G%N)YU[EUV#TS^B'W'_+'N*\\;"*+<NT?A^+?3ZH*````
`
end

-- 
Vojtech Pavlik
SuSE Labs
