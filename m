Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbULUDP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbULUDP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 22:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbULUDP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 22:15:59 -0500
Received: from fmr14.intel.com ([192.55.52.68]:38593 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261414AbULUDPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 22:15:47 -0500
Subject: Re: ACPI race querying battery status in 2.6.9+swsusp2 IBM TP R50P
From: Len Brown <len.brown@intel.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <16828.26177.871076.493877@chiark.greenend.org.uk>
References: <16828.26177.871076.493877@chiark.greenend.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1103598924.11833.3761.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Dec 2004 22:15:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-12 at 10:39, Ian Jackson wrote:
> If I read /proc/acpi/battery/BAT0/info simultaneously in several
> different processes, it (usually) fails.  One of the processes sees
> .../info containing
>   present:                 yes
>   ERROR: Unable to read battery information
> 
> and I get messages like this in my kernel logs:
> 
> Dec 12 02:58:03 liberator kernel:  dswload-0292: *** Error: Looking up
> [SERN] in namespace, AE_ALREADY_EXISTS
> Dec 12 02:58:03 liberator kernel:  psparse-1133: *** Error: Method
> execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node dff01ca8),
> AE_ALREADY_EXISTS
> 
> Dec 12 02:58:03 liberator kernel:  dswload-0641: *** Error: Looking up
> [SERN] in namespace, AE_NOT_FOUND
> Dec 12 02:58:03 liberator kernel:  psparse-1133: *** Error: Method
> execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node dff01ca8),
> AE_NOT_FOUND
> 
> Dec 12 02:58:03 liberator kernel:  psparse-1133: *** Error: Method
> execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node dff01628),
> AE_NOT_FOUND
> 
> I can trigger this easily and reliably with
>   cd /proc/acpi/battery/
>   cat info & cat info & cat info & cat info &
> I haven't checked whether the other virtual files in the same
> directory have the same problem.
> 
> The problem seems superficially similar to bugzilla.kernel.org 1791
>  http://bugzilla.kernel.org/show_bug.cgi?id=1791
> although looking at my copy of exstore.c the `proposal' patch there
> seems already to have had something similar but more complex done.
> (Bizarrely, the `revised simpler patch' there seems from its RCS
> filename to be a diff against a BSD source tree!)
> 
> The machine is an IBM Thinkpad R50P (type 1832 aka TJ22AUK).  I'm
> running:
>   * Linux 2.6.9
>   * Software Suspend 2, software-suspend-2.1.5-for-2.6.9.tar.bz2
>   * Intel 2100 wifi driver, ipw2100-1.0.1.tgz & ipw2100-fw-1.3.tgz
>   * IBM ACPI driver module, ibm-acpi-0.8.tar.gz
>   * Debian sarge (testing) including acpid 1.0.4-1, acpi 0.07-3,
>     with some of the automatic boot-time module loading disabled.
>   * In case it matters, X server is X11R6.8.1 from x.org sources
>     with radeon.c patched to call INT 10 at every VC switch to help
>     with resuming from suspend:
>  http://www.doesi.gmxhome.de/linux/tm800s3/resources/radeon_driver.c.patch
> 
> All of the other ACPI functionality seems fine: ACPI suspend to RAM,
> and swsusp2 to disk, both work properly (aside from the need to switch
> out of X before suspending).  The battery information is usually
> reported properly in /proc/acpi.  etc.
> 

Still a problem when you boot with "acpi_serialize"?

Possible to test with a 2.6.10 -mm kernel?

Please be encouraged to file a bug here
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
component: Power-battery

thanks,
-Len



