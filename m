Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUFQHEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUFQHEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 03:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUFQHEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 03:04:33 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:16668 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S266333AbUFQHD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 03:03:59 -0400
Date: Thu, 17 Jun 2004 07:03:47 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Corey Minyard <minyard@acm.org>
cc: Alex Williamson <alex.williamson@hp.com>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: IPMI hangup in 2.6.6-rc3
In-Reply-To: <40D0B0D1.60804@acm.org>
Message-Id: <Pine.LNX.4.58.0406170701580.7233@praktifix.dwd.de>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de> 
 <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org>
 <1086887543.4182.46.camel@tdi> <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de>
 <40D056E2.4010605@acm.org> <40D05779.9080203@acm.org>
 <Pine.LNX.4.58.0406161822280.13439@praktifix.dwd.de>
 <Pine.LNX.4.58.0406161842180.13439@praktifix.dwd.de> <40D0B0D1.60804@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Corey Minyard wrote:

> I cannot figure out from the traceback what is wrong, and I haven't been able
> to reproduce this, even with ipmitool.
> 
> What kernel version are you running?  Can you verify that the attached patch
> is in your code?
> 
> --- linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c.orig Wed Jun  9
> 12:08:23 2004
> +++ linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c      Wed Jun  9
> 12:07:09 2004
> @@ -199,7 +199,7 @@ static int handle_send_req(ipmi_user_t     goto out;
>        }
> 
> -      if (copy_from_user(&msgdata,
> +      if (copy_from_user(msgdata,
>           req->msg.data,
>           req->msg.data_len))
>        {
> 
Hurray! Now it works!!! Many thanks for the quick patch! As Alex Williamson
already mentioned this was missing in stock 2.6.7, that is what I am using.

Here the results:

ipmitool -I open sdr list
Baseboard 1.2V   | 1.20 Volts        | ok
Baseboard 1.25V  | 1.25 Volts        | ok
Baseboard 1.8V   | 1.79 Volts        | ok
Baseboard 1.8VSB | 1.80 Volts        | ok
Baseboard 2.5V   | 2.49 Volts        | ok
Baseboard 3.3V   | 3.37 Volts        | ok
Baseboard 3.3AUX | 3.33 Volts        | ok
Baseboard 5.0V   | 5.07 Volts        | ok
Baseboard 5VSB   | 4.97 Volts        | ok
Baseboard 12V    | 12.03 Volts       | ok
Baseboard 12VRM  | 12.01 Volts       | ok
Baseboard -12V   | -11.91 Volts      | ok
Baseboard VBAT   | 3.17 Volts        | ok
Baseboard Temp   | 28 degrees C      | ok
Front Panel Temp | 18 degrees C      | ok
Basebrd FanBoost | 28 degrees C      | ok
FP Amb FanBoost  | 18 degrees C      | ok
Sys Fan 1        | 3726 RPM          | ok
Sys Fan 2        | 3933 RPM          | ok
Sys Fan 3        | 3174 RPM          | ok
Sys Fan 4        | 3795 RPM          | ok
Sys Fan 5        | 3036 RPM          | ok
SCSI A Term Pwr  | 4.78 Volts        | ok
SCSI B Term Pwr  | 4.78 Volts        | ok
Power Cage Fan 1 | 4260 RPM          | ok
Power Cage Fan 2 | 4320 RPM          | ok
Power Cage Temp  | 25 degrees C      | ok
Processor 1 Temp | 26 degrees C      | ok
Processor 2 Temp | 24 degrees C      | ok
Proc1 FanBoost   | 26 degrees C      | ok
Proc2 FanBoost   | 24 degrees C      | ok
Processor Vccp   | 1.50 Volts        | ok
HSBP A Temp      | 0 degrees C       | ok
HSBP B Temp      | 0 degrees C       | ok
Pwr Unit Status  | 0x00              | ok
Pwr Unit Redund  | 0x01              | ok
BMC Watchdog     | 0x00              | ok
Scrty Violation  | 0x00              | ok
Physical Scrty   | 0x00              | ok
POST Error       | 0x00              | ok
Critical Int     | 0x00              | ok
Memory           | 0x00              | ok
Logging Disabled | 0x00              | ok
Power Supply 1   | 0x01              | ok
Power Supply 2   | 0x01              | ok
Power Supply 3   | 0x01              | ok
Proc Missing     | 0x00              | ok
ACPI State       | 0x01              | ok
System Event     | 0x00              | ok
Button           | 0x00              | ok
SMI Timeout      | 0x00              | ok
Sensor Failure   | 0x00              | ok
NMI State        | 0x00              | ok
SMI State        | 0x00              | ok
FSB Mismatch     | 0x00              | ok
Processor 1 Stat | Present           | ok
Processor 2 Stat | Present           | ok
CPU Therm Ctrl   | 0x01              | ok
Fan Redundancy   | 0x01              | ok
Fan1 Presence    | Installed         | ok
Fan2 Presence    | Installed         | ok
Fan3 Presence    | Installed         | ok
Fan4 Presence    | Installed         | ok
Fan5 Presence    | Installed         | ok
DIMM 1           | Installed         | ok
DIMM 2           | Installed         | ok
DIMM 3           | Not Installed     | ok
DIMM 4           | Not Installed     | ok
DIMM 5           | Not Installed     | ok
DIMM 6           | Not Installed     | ok
HSBP A Drv Stat  | 0x01              | ok
HSBP A Drv Pres  | 0x00              | ok
HSBP B Drv Stat  | 0x01              | ok
HSBP B Drv Pres  | 0x00              | ok
Power Cage FRU   | Phy FRU @01h 15.1 | ok
Pwr Supply 1 FRU | Phy FRU @02h 0a.1 | ok
Pwr Supply 2 FRU | Phy FRU @03h 0a.2 | ok
Pwr Supply 3 FRU | Phy FRU @04h 0a.3 | ok
DIMM 1 SPD       | Phy FRU @05h 20.1 | ok
DIMM 2 SPD       | Phy FRU @06h 20.2 | ok
DIMM 3 SPD       | Phy FRU @07h 20.3 | ok
DIMM 4 SPD       | Phy FRU @08h 20.4 | ok
DIMM 5 SPD       | Phy FRU @09h 20.4 | ok
DIMM 6 SPD       | Phy FRU @0Ah 20.4 | ok
Basbrd Mgmt Ctlr | Dynamic MC @ 10h  | ok
Chs Bridge Ctlr  | Static MC @ 14h   | ok
HSBP A           | Dynamic MC @ 60h  | ok
HSBP B           | Dynamic MC @ 61h  | ok

Again many thanks for the quick help!

Regards,
Holger
