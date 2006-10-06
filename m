Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWJFHUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWJFHUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWJFHUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:20:07 -0400
Received: from holoclan.de ([62.75.158.126]:152 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1161077AbWJFHUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:20:05 -0400
Date: Fri, 6 Oct 2006 09:18:12 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: 2.6.19-rc1 lost ACPI events after suspend
Message-ID: <20061006071812.GD21470@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-thinkpad@linux-thinkpad.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  *Waving hallo again* After partially solving one problem
	another occurs... With my most recent kernel [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*Waving hallo again*

After partially solving one problem another occurs...

With my most recent kernel 

commit d223a60106891bfe46febfacf46b20cd8509aaad
tree ca81ba555de7a9a68605ef98f13fbc027439cdd2
parent 77dc2db6d1d2703ee4e83d4b3dbecf4e06a910e6
author Linus Torvalds <torvalds@g5.osdl.org> Wed, 04 Oct 2006 19:57:05 -0700

with additional patch tp_smapi 0.30 

I can suspend exactly twice. will say, after second wakeup I don't get 
any ACPI events. I already searched for error messages in the logs and 
found this:

Oct  6 08:49:09 gimli kernel: [45058.156000] ACPI Exception (evxface-0545):
AE_BAD_PARAMETER, Removing notify handler [20060707]

it occurs on unloading ibm_acpi module after resume
reloading ibm_acpi dosen't change anything

one message that is in the log for the first suspend/resume but not in the
second is 
- Breaking affinity for irq 219

and in the second I see this, which I guess has nothing to do with my
problem...

+ e1000: eth0: e1000_watchdog: NIC Link is Down
+ BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
+  [<c0103bbd>] dump_trace+0x69/0x1af
+  [<c0103d1b>] show_trace_log_lvl+0x18/0x2c
+  [<c01043ba>] show_trace+0xf/0x11
+  [<c01044bd>] dump_stack+0x15/0x17
+  [<c0208d36>] pci_enable_msi+0x78/0x22e
+  [<c025808b>] e1000_open+0x64/0x176
+  [<c029b281>] dev_open+0x2b/0x62
+  [<c0299d8f>] dev_change_flags+0x47/0xe4
+  [<c02cde47>] devinet_ioctl+0x252/0x556
+  [<c0290ffa>] sock_ioctl+0x19e/0x1c2
+  [<c01697df>] do_ioctl+0x1f/0x62
+  [<c0169a67>] vfs_ioctl+0x245/0x257
+  [<c0169ac5>] sys_ioctl+0x4c/0x67
+  [<c0102da7>] syscall_call+0x7/0xb
+ DWARF2 unwinder stuck at syscall_call+0x7/0xb
+
+ Leftover inexact backtrace:
+
+  =======================

the complete logs are attached


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
