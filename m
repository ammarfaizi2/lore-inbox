Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTETRey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTETRey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:34:54 -0400
Received: from [65.244.37.61] ([65.244.37.61]:39977 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S263837AbTETRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:34:49 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920217E647@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, akpm@digeo.com, davej@suse.de,
       linux.nics@intel.com
Subject: [Patch] e100 driver patch for 2.5 - option to restore old behavio
	r
Date: Tue, 20 May 2003 13:46:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C31EF7.CB7D5590"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C31EF7.CB7D5590
Content-Type: text/plain;
	charset="iso-8859-1"

These patches add a module parameter to restore older
EEPROM behavior to the Intel e100 NIC driver.

In 2.4.x (and early 2.5.x) the e100 driver would print
a warning if there was an error with the EEPROM checksum,
but would continue with device initialization.

Sometime during 2.5.x, the behavior changed, so that any
EEPROM checksum error fails the driver initialization.

We have lots of boxen that for some reason always fail the
checksum, but the E100 NIC operates just fine. Others might
have the same issue.

So here is are two patches that adds a new module parameter
'PromXsumFail' as boolean to the E100 module.  The default
is 'true', so that the behavior is the same as the unpatched
version.  The patch is against 2.5.69.  The first patch file
'patch-e100-src-2.5.69' is for the module source.  The second
file 'patch-e100-doc-2.5.69' is for the e100.txt file in the
Documentation directory.

Patches have been tested on:

1. Custom netbooted P3 PIIX4 with embedded 82559.
2. Dell PC - Intel chipset, Pro/100+ PCI, UP P3.
2. Dell PC - Intel chipset, Pro/100+ PCI, SMP P4.

If you think it useful, please apply.

Thanks
Thomas Downing
Principal Member Technical Staff
IPC Information Systems, Inc.
777 Commerce Drive
Fairfield, CT, USA 06432-5500
voice: 203.339.7030


------_=_NextPart_000_01C31EF7.CB7D5590
Content-Type: application/octet-stream;
	name="patch-e100-doc-2.5.69"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-e100-doc-2.5.69"

*** linux-2.5.69/Documentation/networking/e100.txt	Sun May  4 19:53:40 =
2003=0A=
--- linux-musrum/Documentation/networking/e100.txt	Tue May 20 13:07:38 =
2003=0A=
***************=0A=
*** 195,200 ****=0A=
--- 195,207 ----=0A=
  =0A=
     Not available on 82557 and 82558-based adapters.=0A=
  =0A=
+ PromXsumRail=0A=
+ Valid Raing: 0-1 (0=3Doff, 1=3Don)=0A=
+ Default Value: 1=0A=
+    On causes device initialization to fail if the EEPROM checksum is =
in=0A=
+    error.  Off will print a warning in this case, but initialization =
will=0A=
+    continue.  The latter is the older (2.4) behavior.=0A=
+ =0A=
  =0A=
  CPU Cycle Saver=0A=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=

------_=_NextPart_000_01C31EF7.CB7D5590
Content-Type: application/octet-stream;
	name="patch-e100-src-2.5.69"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-e100-src-2.5.69"

diff -C 3 linux-2.5.69/drivers/net/e100/e100.h =
linux-musrum/drivers/net/e100/e100.h=0A=
*** linux-2.5.69/drivers/net/e100/e100.h	Sun May  4 19:53:09 2003=0A=
--- linux-musrum/drivers/net/e100/e100.h	Tue May 20 13:00:41 2003=0A=
***************=0A=
*** 86,97 ****=0A=
  #define E100_MIN_RFD       8=0A=
  #define E100_MAX_RFD       1024=0A=
  =0A=
! #define E100_DEFAULT_XSUM         true=0A=
! #define E100_DEFAULT_BER          ZLOCK_MAX_ERRORS=0A=
! #define E100_DEFAULT_SPEED_DUPLEX 0=0A=
! #define E100_DEFAULT_FC           0=0A=
! #define E100_DEFAULT_IFS          true=0A=
! #define E100_DEFAULT_UCODE        true=0A=
  =0A=
  #define TX_THRSHLD     8=0A=
  =0A=
--- 86,98 ----=0A=
  #define E100_MIN_RFD       8=0A=
  #define E100_MAX_RFD       1024=0A=
  =0A=
! #define E100_DEFAULT_XSUM           true=0A=
! #define E100_DEFAULT_BER            ZLOCK_MAX_ERRORS=0A=
! #define E100_DEFAULT_SPEED_DUPLEX   0=0A=
! #define E100_DEFAULT_FC             0=0A=
! #define E100_DEFAULT_IFS            true=0A=
! #define E100_DEFAULT_UCODE          true=0A=
! #define E100_DEFAULT_PROM_XSUM_FAIL true=0A=
  =0A=
  #define TX_THRSHLD     8=0A=
  =0A=
***************=0A=
*** 835,845 ****=0A=
  } bd_dma_able_t;=0A=
  =0A=
  /* bit masks for bool parameters */=0A=
! #define PRM_XSUMRX       0x00000001=0A=
! #define PRM_UCODE        0x00000002=0A=
! #define PRM_FC           0x00000004=0A=
! #define PRM_IFS          0x00000008=0A=
! #define PRM_BUNDLE_SMALL 0x00000010=0A=
  =0A=
  struct cfg_params {=0A=
  	int e100_speed_duplex;=0A=
--- 836,847 ----=0A=
  } bd_dma_able_t;=0A=
  =0A=
  /* bit masks for bool parameters */=0A=
! #define PRM_XSUMRX         0x00000001=0A=
! #define PRM_UCODE          0x00000002=0A=
! #define PRM_FC             0x00000004=0A=
! #define PRM_IFS            0x00000008=0A=
! #define PRM_BUNDLE_SMALL   0x00000010=0A=
! #define PRM_PROM_XSUM_FAIL 0x00000020=0A=
  =0A=
  struct cfg_params {=0A=
  	int e100_speed_duplex;=0A=
diff -C 3 linux-2.5.69/drivers/net/e100/e100_main.c =
linux-musrum/drivers/net/e100/e100_main.c=0A=
*** linux-2.5.69/drivers/net/e100/e100_main.c	Sun May  4 19:53:14 =
2003=0A=
--- linux-musrum/drivers/net/e100/e100_main.c	Tue May 20 12:48:41 =
2003=0A=
***************=0A=
*** 375,380 ****=0A=
--- 375,381 ----=0A=
  E100_PARAM(BundleSmallFr, "Disable or enable interrupt bundling of =
small frames");=0A=
  E100_PARAM(BundleMax, "Maximum number for CPU saver's packet =
bundling");=0A=
  E100_PARAM(IFS, "Disable or enable the adaptive IFS algorithm");=0A=
+ E100_PARAM(PromXsumFail, "Fail initialization on EEPROM checksum =
mismatch");=0A=
  =0A=
  /**=0A=
   * e100_exec_cmd - issue a comand=0A=
***************=0A=
*** 653,660 ****=0A=
  	if (cal_checksum !=3D read_checksum) {=0A=
                  printk(KERN_ERR "e100: Corrupted EEPROM on instance =
#%d\n",=0A=
  		       e100nics);=0A=
!                 rc =3D -ENODEV;=0A=
!                 goto err_pci;=0A=
  	}=0A=
  	=0A=
  	dev->vlan_rx_register =3D e100_vlan_rx_register;=0A=
--- 654,666 ----=0A=
  	if (cal_checksum !=3D read_checksum) {=0A=
                  printk(KERN_ERR "e100: Corrupted EEPROM on instance =
#%d\n",=0A=
  		       e100nics);=0A=
!         if (bdp->params.b_params & PRM_PROM_XSUM_FAIL) {=0A=
!             rc =3D -ENODEV;=0A=
!             goto err_pci;=0A=
!         }=0A=
!         else=0A=
!             printk(KERN_WARNING =0A=
!                    "e100: check settings before activating this =
device\n");=0A=
  	}=0A=
  	=0A=
  	dev->vlan_rx_register =3D e100_vlan_rx_register;=0A=
***************=0A=
*** 899,904 ****=0A=
--- 905,912 ----=0A=
  			    0xFFFF, E100_DEFAULT_CPUSAVER_BUNDLE_MAX,=0A=
  			    "CPU saver bundle max value");=0A=
  =0A=
+     e100_set_bool_option(bdp, PromXsumFail[board], =
PRM_PROM_XSUM_FAIL, =0A=
+                 E100_DEFAULT_PROM_XSUM_FAIL, "fail on prom xsum =
error");=0A=
  }=0A=
  =0A=
  /**=0A=

------_=_NextPart_000_01C31EF7.CB7D5590--
