Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWBFHh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBFHh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWBFHh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:37:57 -0500
Received: from fmr17.intel.com ([134.134.136.16]:135 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750722AbWBFHh4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:37:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: EC interrupt mode by default breaks power button and lid button
Date: Mon, 6 Feb 2006 15:37:47 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC24F@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EC interrupt mode by default breaks power button and lid button
thread-index: AcYqgfQYHhDfWs58RYaQwEvi5FqFswAbdOhg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Gerhard Schrenk" <deb.gschrenk@gmx.de>,
       "Brown, Len" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Feb 2006 07:37:47.0862 (UTC) FILETIME=[39E75F60:01C62AF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't revert that patch, and test kernel parameter ec_intr=0
Also, please send me acpidump output.

I'm wondering how ec interrupt mode breaks power & lid button.

Thanks
Luming 

>-----Original Message-----
>From: Gerhard Schrenk [mailto:deb.gschrenk@gmx.de] 
>Sent: 2006Äê2ÔÂ6ÈÕ 2:04
>To: Brown, Len
>Cc: Yu, Luming; linux-kernel@vger.kernel.org
>Subject: EC interrupt mode by default breaks power button and 
>lid button
>
>Hi,
>
>the following commit breaks power button and lid button on my centrino
>notebook (MSI S260; branded as Medion SIM S2100).
>
>|gps@medusa:~/scratch/kernel-tree$ git bisect good
>|53f11d4ff8797bcceaf014e62bd39f16ce84baec is first bad commit
>|diff-tree 53f11d4ff8797bcceaf014e62bd39f16ce84baec (from 
>02b28a33aae93a3b53068e0858d62f8bcaef60a3)
>|Author: Len Brown <len.brown@intel.com>
>|Date:   Mon Dec 5 16:46:36 2005 -0500
>|
>|    [ACPI] Enable Embedded Controller (EC) interrupt mode by default
>|    
>|    "ec_intr=0" reverts to polling
>|    "ec_burst=" no longer exists.
>|    
>|    Signed-off-by: Len Brown <len.brown@intel.com>
>|    Acked-by: Luming Yu <luming.yu@intel.com>
>|
>|:040000 040000 9eec66712c68ebe372b2fb2c8d78bdc99df942ab 
>e7e62cd09983730aee468edd4ba1cce50786b7e5 M      Documentation
>|:040000 040000 6e7db46918f6124f64a11f6757560078a8a27519 
>aa8abb1023024902300cb2e7a5bf74acd8c579e8 M      drivers
>
>With
>
>  git revert 53f11d4ff8797bcceaf014e62bd39f16ce84baec
>
>on top of linus' tree I have no problems with power/lid buttons and my
>acpid configuration.
>
>Suspend to disk/mem (at least for some seconds/minutes thereafter) with
>an unpatched kernel from linus' tree is another possibility to bring
>power/lid events back to life.
>
>On my debian (etch) system I have following acpid(?) 1.0.4-3 
>configuration:
>
>|gps@medusa$ cat /etc/acpi/events/my_lid
>|event=button[ /]lid
>|action=/etc/acpi/actions/my_lid.sh %e
>
>|gps@medusa:~$ cat /etc/acpi/actions/my_lid.sh 
>|#!/bin/sh
>|# lid button pressed/released event handler
>|
>|# echo "lid-event" | wall
>|echo platform > /sys/power/disk
>|echo disk > /sys/power/state
>
>|gps@medusa:~$ cat /etc/acpi/events/powerbtn 
>|event=button[ /]power
>|action=/etc/acpi/actions/my_powerbtn.sh
>
>|gps@medusa:~$ cat /etc/acpi/actions/my_powerbtn.sh 
>|#!/bin/sh
>|# suspend to disk (hybernation) when the power button has 
>been pressed 
>|# echo "power-button-event" | wall
>|echo mem > /sys/power/state
>
>-- Gerhard
>
