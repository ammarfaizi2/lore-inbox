Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVGFJLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVGFJLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVGFJLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:11:41 -0400
Received: from odin2.bull.net ([192.90.70.84]:61904 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262153AbVGFHTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:19:11 -0400
Subject: PREEMPT_RT and mptfusion
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: BTS
Message-Id: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 06 Jul 2005 09:05:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem I have didn't exist in 48-36 : The last version I can run.
>From the 50-47, ( I didn't test 40-38 through 50-46 ) I get the
following problem : I cannot boot :

On a 2.6.12 with no RT patch, I get the following :
...
Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 32 (level, low) -> IRQ 177
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
ACPI: PCI Interrupt 0000:04:03.1[B] -> GSI 33 (level, low) -> IRQ 185
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.20
scsi0 : ioc0: LSI53C1030, FwRev=01000e00h, Ports=1, MaxQ=222, IRQ=177
  Vendor: IBM-ESXS  Model: DTN036W3UWDY10FN  Rev: S27P
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write back
...

with a 2.6.12 with RT patch and PREEMPT_RT
...
Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 32 (level, low) -> IRQ 177
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
<== wait ~ 13 secondes
ioc0: 53C1030: Initiating ioc0 recovery    <== New with the RT patch
<== wait ~ 13 secondes between each Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ACPI: PCI Interrupt 0000:04:03.1[B] -> GSI 33 (level, low) -> IRQ 185
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
<== wait ~ 13 secondes between each Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
ioc0: 53C1030: Initiating ioc0 recovery
Fusion MPT SCSI Host driver 3.01.20
scsi0 : ioc0: LSI53C1030, FwRev=01000e00h, Ports=1, MaxQ=222, IRQ=177
mptscsih: ioc0: >> Attempting task abort! (sc=f7c71e00)
mptbase: Initiating ioc0 recovery
mptbase: ioc0: ERROR - Diagnostic reset FAILED! ( 102h)
mptbase: ioc0 NOT READY WARNING!
mptbase: ioc0 WARNING - (-1) Cannot recovery ioc0
mptbase: ioc0 Issue of TaskMgmt failed!
mptscsih: ioc0: WARNING - Error issuing abort task! (sc=f7c7&e00)
mptscsih: ioc0: >> Attempting bus reset! (sc=f7c71e00)
mptbase: Initiating ioc0 recovery
mptbase: ioc0: ERROR - Doorbell ACK timeout (count=4999),
IntStatus=80000000!
mptbase: ioc0: ERROR - Diagnostic reset FAILED! (102h)
mptbase: ioc0 NOT READY WARNING!
...

