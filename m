Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUFCNbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUFCNbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUFCNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:31:21 -0400
Received: from camus.xss.co.at ([194.152.162.19]:20997 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S262431AbUFCNbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:31:09 -0400
Message-ID: <40BF2815.8070509@xss.co.at>
Date: Thu, 03 Jun 2004 15:31:01 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre5
References: <20040603022432.GA6039@logos.cnet>
In-Reply-To: <20040603022432.GA6039@logos.cnet>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Marcelo Tosatti wrote:
> Hi,
>
> Here goes -pre5.
>
> This time we have merges from Jeff's -netdrivers tree, David's -net tree,
> including a fix for compilation error without CONFIG_SCTP set, SPARC64 update,
> i810_audio fixes, amongst others.
>
I just stepped into testing the 2.4.27pre series and found
a small problem with "make xconfig"

the following change in "drivers/hotplug/Config.in" breaks
the tcl/tk script:

+dep_mbool '    For AMD SHPC only: Use $HRT for resource/configuration' CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY $CONFIG_HOTPLUG_PCI_SHPC

It chokes on the $HRT which is an undefined variable.
I do not know what this variable is supposed to mean
(and if it is evensupposed to be interpreted as variable),
but as it is located in some string used as a user message
only I changed it to

+dep_mbool '    For AMD SHPC only: Use HRT for resource/configuration' CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY $CONFIG_HOTPLUG_PCI_SHPC

and now "make xconfig" works fine (one could also escape
the "$HRT" in the string, I guess).

Otherwise, 2.4.27pre5 compiles and boots fine on one of my
test systems (out of one I tested so far ;-)

One thing I noticed though: device numbering for the e1000
driver seems to have changed on this hardware: what was eth0
under 2.4.26 is now eth1 and vice versa.

The system has two Intel GBit ethernet NIC:

00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
01:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)

2.4.27pre5 uses PCI device 03:02.0 as eth0 while 2.4.26 uses
PCI device 00:02.0 as eth0 (both systems were booted with "pci=noacpi")

This is just a minor annoyance, though (I have to change
network cabling when rebooting the machine between 2.4.26
and 2.4.27pre5)

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAvygSxJmyeGcXPhERAi+lAJ9o35AC7j5hUAnQS4LWMgHrj+rsUQCfebKq
Ic/thokz1Zjb/6fTuhxEf3A=
=G7v2
-----END PGP SIGNATURE-----

