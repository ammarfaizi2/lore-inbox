Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVAYBb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVAYBb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVAYBb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:31:26 -0500
Received: from fmr16.intel.com ([192.55.52.70]:28328 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261686AbVAYBat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:30:49 -0500
Subject: Re: 2.6.11-rc2-mm1 (AE_AML_NO_OPERAND)
From: Len Brown <len.brown@intel.com>
To: Brice.Goglin@ens-lyon.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41F59A50.1090203@ens-lyon.fr>
References: <41F59A50.1090203@ens-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1106616636.2399.202.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Jan 2005 20:30:37 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 20:01, Brice Goglin wrote:
> Andrew Morton a écrit :

> 
> ACPI does not work anymore on my Compaq Evo N600c
> (no thermal zone, no fan, no battery, ...).
> It works great on Linus' 2.6.11-rc2, and (from what I remember)
> it was working on the last -mm releases I tried.
> 
> Here's a bunch of lines from dmesg.
...
> 
> 
> exresnte-0133 [24] ex_resolve_node_to_val: No object attached to node
> e7fcd548
>   dswexec-0446 [21] ds_exec_end_op        : [Acquire]: Could not
> resolve operands, AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed
> [\_SB_.C03E.C053.C0D1.C12A] (Node c15e5788), AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed [\_SB_.C1A2._PSR]
> (Node c15ed8c8), AE_AML_NO_OPERAND
>   acpi_ac-0098 [12] acpi_ac_get_state     : Error reading AC Adapter
> state
> ACPI: Battery Slot [C19F] (battery absent)
> ACPI: Battery Slot [C1A0] (battery absent)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [C1A3]
> ACPI: Lid Switch [C1A4]
> ACPI: Fan [C1F6] (off)
> ACPI: Fan [C1F7] (off)
> ACPI: Fan [C1F8] (off)
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> exresnte-0133 [31] ex_resolve_node_to_val: No object attached to node
> e7fcd548
>   dswexec-0446 [28] ds_exec_end_op        : [Acquire]: Could not
> resolve operands, AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed
> [\_SB_.C03E.C053.C0D1.C11A] (Node c15e5b48), AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed [\_TZ_.C11A] (Node
> c15ef3c8), AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed [\_TZ_.C1F1] (Node
> c15ef0c8), AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed [\_TZ_.TZ1_._TMP]
> (Node c15f05c8), AE_AML_NO_OPERAND
> ACPI wakeup devices:
> C052 C17E C185 C0A4 C0AA C19F C1A0 C1A3 C1A4
> ACPI: (supports S0 S1 S3 S4 S4bios S5)
> exresnte-0133 [26] ex_resolve_node_to_val: No object attached to node
> e7fcd548
>   dswexec-0446 [23] ds_exec_end_op        : [Acquire]: Could not
> resolve operands, AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed
> [\_SB_.C03E.C053.C0D1.C119] (Node c15e5b88), AE_AML_NO_OPERAND
>   psparse-1138: *** Error: Method execution failed [\_GPE._L10] (Node
> c15f0248), AE_AML_NO_OPERAND
>     evgpe-0552: *** Error: AE_AML_NO_OPERAND while evaluating method
> [_L10] for GPE[ 0]

Please patch -Rp1 this file:
http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/bk-acpi.patch
to verify that the issue goes away when backing out the ACPI part of the
latest mm patch.

We'll likely need your acpidmp output to bottom out on this.
Please open a bug here:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
Category: AML-interpreter

and attach (don't paste) the output from acpidmp, available in /usr/sbin
or in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
along with the complete dmesg -s64000 output of the failure case.

thanks,
-Len


