Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVCSNFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVCSNFB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVCSNEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:04:38 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:30948 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262460AbVCSNEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:04:08 -0500
Date: Sat, 19 Mar 2005 13:44:26 +0100
From: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: 2.6.11-mm3, mm4, usb, suspend 2 ram
Message-ID: <20050319124426.GA3316@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi usb developers!

Since 2.6.11-mm3 I have problems with the usb system after resume (in
fact already while suspending). In 2.6.11-mm2 I could S2R without
stopping hotplug/unloading usb modules, with mm3 and above I get the
following:
uhci_hcd 0000:00:1d.0: host system error, PCI problems?
uhci_hcd 0000:00:1d.0: host controller process error, something bad happened!

If I unload usb modules prior to going to s3 and loadin gafterwards
there is no problem.

THe problems start with "Stopping tasks": THere is one line in the
syslog:
Stopping tasks: _hcd 0000:00:1d.0: host system error, PCI problems?
which hints at this.


Here a commented syslog excerpt:

suspendtoram.sh called

## go to sleep
Mar 18 18:22:27 gandalf vmunix: PM: Preparing system for suspend

## here the problems start 
Mar 18 18:22:44 gandalf vmunix: Stopping tasks: _hcd 0000:00:1d.0: host system error, PCI problems?
Mar 18 18:22:44 gandalf vmunix: uhci_hcd 0000:00:1d.0: host controller process error, something bad happened!

# quite a lot (around 20) of the following messages:
...
Mar 18 18:22:44 gandalf vmunix: uhci_hcd 0000:00:1d.0: host system error, PCI problems?
Mar 18 18:22:44 gandalf vmunix: uhci_hcd 0000:00:1d.0: host controller process error, something bad happened!
Mar 18 18:22:44 gandalf kernel: ===========================================================================================|

# after coming back everything works, but tausands of these messages ...
Mar 18 18:22:44 gandalf vmunix: uhci_hcd 0000:00:1d.0: host system error, PCI problems?
Mar 18 18:22:44 gandalf vmunix: uhci_hcd 0000:00:1d.0: host controller process error, something bad happened!

# interspersed with these log entries
Mar 18 18:22:44 gandalf kernel: PM: Entering state.
Mar 18 18:22:44 gandalf kernel: Back to C!
Mar 18 18:22:44 gandalf vmunix: Yenta O2: res at 0x94/0xD4: 00/ea
Mar 18 18:22:44 gandalf vmunix: Yenta O2: enabling read prefetch/write burst
Mar 18 18:22:44 gandalf kernel: hub 2-0:1.0: resubmit --> -108
Mar 18 18:22:44 gandalf vmunix: ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Mar 18 18:22:44 gandalf vmunix: ehci_hcd 0000:02:09.2: USB 2.0 restarted, EHCI 0.95, driver 10 Dec 2004
Mar 18 18:22:44 gandalf vmunix: Restarting tasks...<3>hub 2-0:1.0: over-current change on port 1
Mar 18 18:22:44 gandalf vmunix:  done
Mar 18 18:22:44 gandalf kernel: hub 4-0:1.0: resubmit --> -108
Mar 18 18:22:44 gandalf kernel: hub 3-0:1.0: resubmit --> -108
Mar 18 18:22:44 gandalf kernel: hub 1-0:1.0: resubmit --> -108
Mar 18 18:22:44 gandalf kernel: wifi0: hfa384x_cmd_issue: cmd reg was busy for 5000 usec
Mar 18 18:22:44 gandalf kernel: wifi0: hfa384x_cmd_issue - timeout - reg=0xffff
Mar 18 18:22:44 gandalf kernel: wifi0: hfa384x_cmd: entry still in list? (entry=d5f85180, type=0, res=-1)
Mar 18 18:22:44 gandalf kernel: wifi0: hfa384x_cmd: interrupted; err=-110
Mar 18 18:22:44 gandalf kernel: wifi0: hfa384x_get_rid: CMDCODE_ACCESS failed (res=-110, rid=fd51, len=6)
Mar 18 18:22:44 gandalf kernel: PM: Finishing up.
Mar 18 18:22:44 gandalf kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Mar 18 18:22:44 gandalf kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Mar 18 18:22:44 gandalf kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Mar 18 18:22:44 gandalf kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Mar 18 18:22:44 gandalf kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Mar 18 18:22:44 gandalf kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Mar 18 18:22:44 gandalf kernel: PCI: Setting latency timer of device 0000:00:1f.6 to 64
Mar 18 18:22:44 gandalf kernel: PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Mar 18 18:22:44 gandalf kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
Mar 18 18:22:46 gandalf kernel: hub 2-0:1.0: connect-debounce failed, port 1 disabled
Mar 18 18:22:46 gandalf kernel: hub 2-0:1.0: over-current change on port 2
Mar 18 18:22:46 gandalf vmunix: usb 2-2: USB disconnect, address 2
Mar 18 18:22:46 gandalf udev[4540]: removing device node '/dev/sdcard'
Mar 18 18:22:46 gandalf udev[4540]: removing all_partitions '/dev/sdcard[1-15]'
Mar 18 18:22:47 gandalf kernel: hub 2-0:1.0: connect-debounce failed, port 2 disabled
Mar 18 18:22:48 gandalf vmunix: hub 1-0:1.0: over-current change on port 1
Mar 18 18:22:49 gandalf kernel: hub 1-0:1.0: connect-debounce failed, port 1 disabled
Mar 18 18:22:49 gandalf kernel: hub 1-0:1.0: over-current change on port 2
Mar 18 18:22:51 gandalf kernel: hub 1-0:1.0: connect-debounce failed, port 2 disabled



If I can help you in any way tracking down the problem, just tell me.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CHENIES (pl.n.)
The last few sprigs or tassels of last Christmas's decoration you
notice on the ceiling while lying on the sofa on an August afternoon.
			--- Douglas Adams, The Meaning of Liff
