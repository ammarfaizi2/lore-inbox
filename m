Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUENO65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUENO65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUENO65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:58:57 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:47781 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261474AbUENO6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:58:23 -0400
Subject: Re: oops ACPI in Linux-2.6.6-bk1
From: Pat LaVarre <p.lavarre@ieee.org>
To: len.brown@intel.com
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <1084511992.12354.256.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615FB4FE@hdsmsx403.hd.intel.com
	 ><1084511992.12354.256.camel@dhcppc4>
Content-Type: text/plain
Organization: 
Message-Id: <1084546675.7796.12.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2004 08:57:55 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2004 14:58:22.0509 (UTC) FILETIME=[E6B2A5D0:01
	C439C3]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:37.31947 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There were no ACPI changes between 2.6.6 and 2.6.6-bk1.

The change my newbie eye sees here is that the effect of CONFIG_ACPI=y
changes from imperceptible in 2.6.6 to kernel won't boot in 2.6.6-bk1.

> Does 2.6.6 work for you?

2.6.6 works for me, yes, as did 2.6.5, 2.6.4, etc. ...

$ grep 'CONFIG_ACPI=' .config
CONFIG_ACPI=y
$ grep 'ACPI.*=y$' .config | grep -v '^#' | wc -l
     16
$

The motherboard labels in front of me include:

"INTEL DESKTOP BOARD"
"D865GBF/D865PERC".

> > > ACPI: Subsystem revision 20040326 ...
> > > [<c01eef72>] acpi_ev_save_method_info+0x44/0x75 ...
> > > Unable to handle kernel NULL pointer dereferencec01e1194 ...
> > > Kernel panic: Aiee, killing interrupt handler! ...
> > > Unable <o ha1dleUn kernel NULL pointer dereferenceer
> > dereferenceOoops: ...
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > ...
> > 
> > Theory confirmed:
> > 
> > Deleting CONFIG_ACPI=y etc. via `make xconfig` fixes this.
> 
> what theory?

Thanks for making the time to say I was unclear.

In launching a thread titled "oops ACPI" I was guessing that lossy dmesg
spew appearing immediately past "ACPI: Subsystem revision 20040326" was
caused by me living too close to `make defconfig`.  I then revisited
`make xconfig`, asked to turn off ACPI, and suddenly life got better.

I'm working from local copies of the kernel.org files:

$ ls -l *2.6.6*
-rw-rw-r--    1 pat      pat      34896138 May 10 11:14 linux-2.6.6.tar.bz2
-rw-------    1 pat      pat       1072216 May 12 08:47 patch-2.6.6-bk1.bz2
$

I can fsck the containing volume, but I haven't yet otherwise learned
how to crc-check their integrity.

Pat LaVarre


