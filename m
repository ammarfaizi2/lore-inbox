Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270379AbUJTDWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270379AbUJTDWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270365AbUJTDWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 23:22:19 -0400
Received: from fmr06.intel.com ([134.134.136.7]:33698 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270425AbUJTDSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 23:18:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Date: Wed, 20 Oct 2004 11:18:08 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8405DCA922@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Thread-Index: AcS1odP+IlcQ49VASq2T5u+qBlMTNAArgp/w
From: "Yu, Luming" <luming.yu@intel.com>
To: "Borislav Deianov" <borislav@users.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Oct 2004 03:18:11.0816 (UTC) FILETIME=[6E0DDE80:01C4B653]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Too many hard-code . :-( 

I'm working on a generic hotkey driver, which will move configurable 
stuff to user space. 

 Basically, I will standardize hotkey event num dispatched to user space

through /proc/acpi/event.  And I will define config and action
interfaces
under /proc/acpi/hotkey to make the hotkey driver has unified interface 
to user space daemon. :

ev_config: config interface for event based hotkey.

Format for config event based hotkey:
echo
"config_command:bus_handle:action_handle:internal_event_num:external_hot
key_num" > ev_config
For example:
1. add a new hotkey:
 echo "0 : _SB.VGA : _SB.VGA.LCD._BCM :0x86 : 0x86" >
/proc/acpi/ev_config
2. delete a hotkey config:
 echo "1: : : :0x86" > /proc/acpi/ev_config
3. update a hotkey config:
 echo "0 : _SB.VGA : _SB.VGA.CRT._BCM :0x87 : 0x87" >
/proc/acpi/ev_config

pl_config: config interface for polling based hotkey.
Format for config polling based hotkey:
 echo
"config_command:pollin_handle:action_handle:internal_event_num:external_
hotkey_num" > ev_config
For example:
1. add a new hotkey:
 echo "0 : _SB.VGA : _SB.POLLING_METHOD : _SB.ACTION_METHOD  : 0X86 :
0X86" > /proc/acpi/pl_config
2.. 

Action: action interface for acpid to call aml method related to the
hotkey event. 
Format for calling aml method through action interface.
 echo "event_num: argument type : value"
For example:
 echo "0x86:1:30" > /proc/acpi/action

Thanks,
Luming

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Borislav Deianov
>Sent: Tuesday, October 19, 2004 2:00 PM
>To: Brown, Len; acpi-devel@lists.sourceforge.net; 
>linux-kernel@vger.kernel.org
>Subject: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
>
>Hi,
>
>This is a Linux ACPI driver for the IBM ThinkPad laptops. It aims to
>support various features of these laptops which are accessible through
>the ACPI framework but not otherwise supported by the generic Linux
>ACPI drivers.
>
>For more information, see http://ibm-acpi.sf.net/
>
>The attached patch is against 2.6.9-rc4-mm1.
>
>Boris
>
