Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbSJITJO>; Wed, 9 Oct 2002 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262050AbSJITJO>; Wed, 9 Oct 2002 15:09:14 -0400
Received: from transport.cksoft.de ([62.111.66.27]:23824 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262044AbSJITJL>; Wed, 9 Oct 2002 15:09:11 -0400
Date: Wed, 9 Oct 2002 19:09:53 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] SCSI sym53c416 & string cleanups [2/2]
Message-ID: <Pine.BSF.4.44.0210091906500.717-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this one adds whitespaces between words in multiline printks in
scsi_error and changes sym53c416 Scsi_Host_Template to
C99 designated initializers.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.719, 2002-10-09 18:48:19+00:00, bzeeb@zabbadoz.net
  SCSI: C99 designated initializers in sym53c416
  SCSI: add spaces between words in debug output in scsi_error.c


 scsi_error.c |   14 +++++++-------
 sym53c416.h  |   34 +++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 24 deletions(-)


diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Wed Oct  9 18:48:57 2002
+++ b/drivers/scsi/scsi_error.c	Wed Oct  9 18:48:57 2002
@@ -91,7 +91,7 @@
 	scmd->eh_timeout.expires = jiffies + timeout;
 	scmd->eh_timeout.function = (void (*)(unsigned long)) complete;

-	SCSI_LOG_ERROR_RECOVERY(5, printk("Adding timer for command %p at"
+	SCSI_LOG_ERROR_RECOVERY(5, printk("Adding timer for command %p at "
 					  "%d (%p)\n", scmd, timeout,
 					  complete));

@@ -757,14 +757,14 @@
 		    SCSI_SENSE_VALID(scmd))
 			continue;

-		SCSI_LOG_ERROR_RECOVERY(2, printk("%s: requesting sense"
+		SCSI_LOG_ERROR_RECOVERY(2, printk("%s: requesting sense "
 						  "for %d\n", __FUNCTION__,
 						  scmd->target));
 		rtn = scsi_request_sense(scmd);
 		if (rtn != SUCCESS)
 			continue;

-		SCSI_LOG_ERROR_RECOVERY(3, printk("sense requested for %p"
+		SCSI_LOG_ERROR_RECOVERY(3, printk("sense requested for %p "
 						  "- result %x\n", scmd,
 						  scmd->result));
 		SCSI_LOG_ERROR_RECOVERY(3, print_sense("bh", scmd));
@@ -1168,9 +1168,9 @@
 		if (!scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
 			continue;

-		printk(KERN_INFO "%s: Device set offline - not"
-				"ready or command retry failed"
-				"after error recovery: host"
+		printk(KERN_INFO "%s: Device set offline - not "
+				"ready or command retry failed "
+				"after error recovery: host "
 				"%d channel %d id %d lun %d\n",
 				__FUNCTION__, shost->host_no,
 				scmd->device->channel,
@@ -1243,7 +1243,7 @@
 	 */
 	if (scmd->device->online == FALSE) {
 		SCSI_LOG_ERROR_RECOVERY(5, printk("%s: device offline - report"
-						  "as SUCCESS\n",
+						  " as SUCCESS\n",
 						  __FUNCTION__));
 		return SUCCESS;
 	}
diff -Nru a/drivers/scsi/sym53c416.h b/drivers/scsi/sym53c416.h
--- a/drivers/scsi/sym53c416.h	Wed Oct  9 18:48:57 2002
+++ b/drivers/scsi/sym53c416.h	Wed Oct  9 18:48:57 2002
@@ -39,21 +39,21 @@
 static int sym53c416_bios_param(Disk *, struct block_device *, int *);
 static void sym53c416_setup(char *str, int *ints);

-#define SYM53C416 {                                          \
-                  proc_name:         "sym53c416",   \
-                  name:              "Symbios Logic 53c416", \
-                  detect:            sym53c416_detect,       \
-                  info:              sym53c416_info,         \
-                  command:           sym53c416_command,      \
-                  queuecommand:      sym53c416_queuecommand, \
-                  abort:             sym53c416_abort,        \
-                  reset:             sym53c416_reset,        \
-                  bios_param:        sym53c416_bios_param,   \
-                  can_queue:         1,                      \
-                  this_id:           SYM53C416_SCSI_ID,      \
-                  sg_tablesize:      32,                     \
-                  cmd_per_lun:       1,                      \
-                  unchecked_isa_dma: 1,                      \
-                  use_clustering:    ENABLE_CLUSTERING       \
-                  }
+#define SYM53C416 {						\
+		.proc_name =		"sym53c416",		\
+		.name =			"Symbios Logic 53c416",	\
+		.detect =		sym53c416_detect,	\
+		.info =			sym53c416_info,		\
+		.command =		sym53c416_command,	\
+		.queuecommand =		sym53c416_queuecommand,	\
+		.abort =		sym53c416_abort,	\
+		.reset =		sym53c416_reset,	\
+		.bios_param =		sym53c416_bios_param,	\
+		.can_queue =		1,			\
+		.this_id =		SYM53C416_SCSI_ID,	\
+		.sg_tablesize =		32,			\
+		.cmd_per_lun =		1,			\
+		.unchecked_isa_dma =	1,			\
+		.use_clustering =	ENABLE_CLUSTERING	\
+		}
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
1.719
## Wrapped with gzip_uu ##


begin 664 bkpatch12286
M'XL(`!EZI#T``[56;6_B1A#^;/^*$=%)5UV`W?4;1J)*CM`479I$T%0ZZ21K
M;0_@"[:YW7524OK?NS8.+VD2E&O/6%Z8>?;9F=EYUAS!C431-<('Q-`\@E]S
MJ;K&`P]#'N</K0R5-H[R7!O;A11M*:)V>-N<)UGQY^9+D[4<4^.NN8IF<(="
M=@W:LC86M5Q@UQ@-SF\N3D>FV>M!?\:S*8Y10:]GJES<\7DL3[B:S?.LI03/
M9(J*MZ(\76V@*T8(TQ^'>A9QW!5UB>VM(AI3RFV*,6%VQ[7-*I.3W0R>4%!"
M?.K9OF6MF-?I4/,,:,NC/A#6IJ1-?*"=KMWI4O\#(5U"X-^,\(%!DY@?X?\-
MO6]&,.Z/AUWH^S[$*)-IQA7&D&2)2O@\>="EU3]`+E/'BFSJ;B;P.`:YX!%*
M"%'=(V9PGXNX0L<8%E/("[4H5#4[DDF`0N2B%9F?0!?!9^;U=D_,YALOTR2<
MF#\?J$8LDK(UVN7R[=T8=JIC$])9$<NA;!5RC"R"+&21Q6+WF5TXP%CML^LP
MAZV()O;>&.!CB5NS_?C\%;4]HO<P<DD';3)A:#N^YQ\.\`EC'9_K6"O*.L2J
MA/%B2H>%\M_J:W[%K^%)6LRG@M]AZWV69_C3X0I3Q@C5&1"/=JQ*2=3;$9+;
M=9B^7Q&2!TWO!PKI)5WHOJ]ZX@J:XKZZ=1M?OUS^[]#$F6\#-8?5TRBC"2ZN
MSH/!:'0U"D:#_M4?@]'G]\XQ+$22J=OWC=,X3K(IJ"1%`9-<@,X\Y5D,[Q;`
M%33,,\\E)>-Z,%[D9%O.=[(+`K\5*%7)+3&3N&;RUDS>JTS6EFD]M>;21U(9
MH`Y,<U'J4;#,H1XM/1I&/>738'09#"]_N8(JC#.\2R+4(2C()Q/]WD!H0I:7
MB1GZ:@CD\1)VTA:HQ!(F/)GKY6H0GRA=G&I/M#_*]68MNS#3+ZTJ$F:[95KU
M:%070`.XA/%-OS\8C[]DC>-GA+:5YEMU]M9CPKQ+1'Z2:N;60A8MC(L#A![3
MA;4[NLTM8OE^I3%[7V+ZMEZ1F%9DD_Y(D;WRMM(Z6Q]NKPIMF_/WZ,QFH-,;
M.IUR.(IQ4O;6^/-OCM77G/#7N@^^Z'YH+40>!1E/$7JZFS;K-HYK_Z/+:(R7
M:9CD$B[R:1+!!E:A8E08J1*W80C6MAJ09).\HMGZ2]/C*H\=OD=0&VL&+;,"
MG\7M>FHP#W/Q))S*5+L%EJ+;<U>FVEVF&2RXX.D^9FNO@1'/UJN7.'K\6%,U
M2V205%%NBAY4)\KPK)XIIX'BX5RWR$,UV6*;V5$:!PL4P;S(]FF++)IA=(MQ
MD$@>Q"G7[AVOQ"":%_HH$N7!UC,&EZ<?+P9!_^)F_/M@-+P\KW!_;_^65FRR
22'M:B1%UD9O_`/=KG7O\"@``
`
end

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

