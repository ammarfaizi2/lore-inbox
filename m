Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVEFO3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVEFO3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEFO32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:29:28 -0400
Received: from firewall.miltope.com ([208.12.184.221]:14411 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261241AbVEFO2f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:28:35 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Announce] sg3_utils-1.14 available
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 6 May 2005 09:29:01 -0500
Message-ID: <66F9227F7417874C8DB3CEB05772741712AC33@MILEX0.Miltope.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Announce] sg3_utils-1.14 available
Thread-Index: AcVSP7ULYCqna46ATE2qDz6KX5MklgABy4SA
From: "Drew Winstel" <DWinstel@Miltope.com>
To: <dougg@torque.net>, <linux-scsi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>This version adds sg_rmsn to read media serial number(s).

It appears that this doesn't quite work as I had hoped.

Ideally, should it not work upon every drive in which sq_inq reads the serial 
number?

SUSE 9.2, vendor kernel:
root@emitestmachine 09:22:57 ~ # gcc -v; echo "----------------------"; sg_inq  \
-v /dev/sg0; echo "-------------------------"; sg_rmsn -v /dev/sg0
Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.4/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr              \
--with-local-prefix=/usr/local --infodir=/usr/share/info --mandir=/usr/share/man\
--enable-languages=c,c++,f77,objc,java,ada --disable-checking --libdir=/usr/lib \
--enable-libgcj --with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib     \
--with-system-zlib --enable-shared --enable-__cxa_atexit i586-suse-linux
Thread model: posix
gcc version 3.3.4 (pre 3.3.5 20040809)
----------------------
    inquiry cdb: 12 00 00 00 24 00 
standard INQUIRY:
    inquiry cdb: 12 00 00 00 60 00 
  PQual=0  Device_type=0  RMB=0  version=0x03  [SPC]
  [AERC=0]  [TrmTsk=0]  NormACA=0  HiSUP=0  Resp_data_format=2
  SCCS=0  ACC=0  TGPS=0  3PC=0  Protect=0  BQue=0
  EncServ=0  MultiP=0  MChngr=0  [ACKREQQ=0]  Addr16=0
  [RelAdr=0]  WBus16=1  Sync=1  Linked=1  [TranDis=1]  CmdQue=1
  Clocking=0x3  QAS=0  IUS=0
    length=96 (0x60)   Peripheral device type: disk
 Vendor identification: QUANTUM 
 Product identification: ATLAS_V_36_WLS  
 Product revision level: 0230
    inquiry cdb: 12 01 00 00 fc 00 
    inquiry: resid=240
    inquiry cdb: 12 01 80 00 fc 00 
    inquiry: resid=236
 Unit serial number: 143110652885
-------------------------
    read media serial number cdb: ab 01 00 00 00 00 00 00 00 04 00 00 
Read Media Serial Number command not supported

Using RHEL3, vanilla 2.6.7 kernel:
[root@localhost root]# gcc -v; for drive in sg0 sg1 sg2; do sg_inq -v /dev/sg2;\
 echo "---- begin rmsn on sg2 ----" ; sg_rmsn -v /dev/sg2; echo "---- end rmsn \
on sg2 ----"; done
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.3/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man            \
--infodir=/usr/share/info --enable-shared --enable-threads=posix               \
--disable-checking --with-system-zlib --enable-__cxa_atexit                    \
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)
    inquiry cdb: 12 00 00 00 24 00
standard INQUIRY:
    inquiry cdb: 12 00 00 00 90 00
  PQual=0  Device_type=0  RMB=0  version=0x03  [SPC]
  [AERC=0]  [TrmTsk=0]  NormACA=0  HiSUP=1  Resp_data_format=2
  SCCS=0  ACC=0  TGPS=0  3PC=0  Protect=0  BQue=0
  EncServ=0  MultiP=0  MChngr=0  [ACKREQQ=0]  Addr16=1
  [RelAdr=0]  WBus16=1  Sync=1  Linked=1  [TranDis=1]  CmdQue=1
  Clocking=0x3  QAS=1  IUS=1
    length=144 (0x90)   Peripheral device type: disk
 Vendor identification: SEAGATE
 Product identification: ST973401LC
 Product revision level: F402
    inquiry cdb: 12 01 00 00 fc 00
    inquiry: resid=239
    inquiry cdb: 12 01 80 00 fc 00
    inquiry: resid=228
 Unit serial number: 3LB00XQ900008443EEU1
---- begin rmsn on sg0 ----
    read media serial number cdb: ab 01 00 00 00 00 00 00 00 04 00 00
Read Media Serial Number command not supported
---- end rmsn on sg0 ----
    inquiry cdb: 12 00 00 00 24 00
standard INQUIRY:
  PQual=0  Device_type=5  RMB=1  version=0x02  [SCSI-2]
  [AERC=0]  [TrmTsk=0]  NormACA=1  HiSUP=1  Resp_data_format=2
  SCCS=0  ACC=0  TGPS=0  3PC=0  Protect=0  BQue=0
  EncServ=0  MultiP=0  MChngr=0  [ACKREQQ=0]  Addr16=0
  [RelAdr=0]  WBus16=0  Sync=0  Linked=0  [TranDis=0]  CmdQue=0
    length=36 (0x24)   Peripheral device type: cd/dvd
 Vendor identification: SONY
 Product identification: DVD-ROM DDU1621
 Product revision level: S4.0
    inquiry cdb: 12 01 00 00 fc 00
Inquiry error, VPD page=0x0: SCSI status: Check Condition
 Fixed format, current;  Sense key: Illegal Request
 Additional sense: Invalid field in cdb
 Raw sense data (in hex):
        70 00 05 00 00 00 00 0a  00 00 00 00 24 00 00 00
        00 00
plus...: Driver_status=0x08 [DRIVER_SENSE, SUGGEST_OK]
---- begin rmsn on sg1 ----
    read media serial number cdb: ab 01 00 00 00 00 00 00 00 04 00 00
Read Media Serial Number command not supported
---- end rmsn on sg1 ----
    inquiry cdb: 12 00 00 00 24 00
standard INQUIRY:
    inquiry cdb: 12 00 00 00 61 00
  PQual=0  Device_type=0  RMB=0  version=0x05  [SPC-3]
  [AERC=0]  [TrmTsk=0]  NormACA=0  HiSUP=0  Resp_data_format=2
  SCCS=0  ACC=0  TGPS=0  3PC=0  Protect=0  BQue=0
  EncServ=0  MultiP=0  MChngr=0  [ACKREQQ=0]  Addr16=0
  [RelAdr=0]  WBus16=0  Sync=0  Linked=0  [TranDis=0]  CmdQue=0
  Clocking=0x0  QAS=0  IUS=0
    length=97 (0x61)   Peripheral device type: disk
 Vendor identification: ATA
 Product identification: FUJITSU MHT2080B
 Product revision level: 0000
    inquiry cdb: 12 01 00 00 fc 00
    inquiry cdb: 12 01 80 00 fc 00
 Unit serial number:         NR00T45254L5
---- begin rmsn on sg2 ----
    read media serial number cdb: ab 01 00 00 00 00 00 00 00 04 00 00
Read Media Serial Number command not supported

If I'm misunderstanding something, please let me know.

Thanks,

Drew
