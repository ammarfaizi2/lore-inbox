Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264662AbUDVUfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbUDVUfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUDVUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:35:36 -0400
Received: from fmr02.intel.com ([192.55.52.25]:36253 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264662AbUDVUfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:35:25 -0400
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z aka
	Newisys 2100
From: Len Brown <len.brown@intel.com>
To: Shantanu Goel <Shantanu.Goel@lehman.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <408820D7.10400@lehman.com>
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
	 <1082653547.16336.335.camel@dhcppc4>  <408820D7.10400@lehman.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082666116.16336.391.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 16:35:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 15:45, Shantanu Goel wrote:

> This works ok though again with only one cpu coming up.  Here is the output:
> 
> Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
> debug acpi=off)
> Linux version 2.6.5-x86_64 (root@njlxlabstinger2) (gcc version 3.2.3 
> 20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Thu Apr 22 14:50:09 EDT 2004

> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> SMP mptable: bad signature [  ]!
> BIOS bug, MP table errors detected!...
> ... disabling SMP support. (tell your hw vendor)

This explains why MPS doesn't boot SMP when acpi=off...

> 
> >Anyway, try acpi=ht to get your cpus back.
> >  
> >
> 
> This hangs.  Here is the output:
> 
> Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
> debug acpi=ht)
> Linux version 2.6.5-x86_64 (root@njlxlabstinger2) (gcc version 3.2.3 
> 20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Thu Apr 22 14:50:09 EDT 2004
> BIOS-provided physical RAM map:

> ACPI: Subsystem revision 20040326
> ACPI: Interpreter enabled

oops, acpi=ht doesn't work on x86_64 -- yet.

> >More interesting would be if pci=noacpi works on 2.6.
> >
> 
> This hangs as well.  Here is the output:
> 
> Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
> debug pci=noacpi)
> Linux version 2.6.5-x86_64 (root@njlxlabstinger2) (gcc version 3.2.3 
> 20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Thu Apr 22 14:50:09 EDT 2004
> BIOS-provided physical RAM map:

> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> SMP mptable: bad signature [<3>BIOS bug, MP table errors detected!...
> ... disabling SMP support. (tell your hw vendor)

Broken BIOS/MPS tables own this failure.
See if you can disable MPS in the BIOS/SETUP.
that is, after you verify you've got the latest BIOS...

cheers,
-Len


