Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTJIAD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJIAD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:03:28 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:13072 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261840AbTJIAD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:03:27 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 regression: ide-scsi no longer likes broken hardware
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Date: 09 Oct 2003 02:03:26 +0200
Message-ID: <tpoewrb7ld.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Antivirus: scanned by sophie at shiva.jussieu.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE chipset is Intel Corp. 82801DB ICH4 IDE (rev 01).

Both the CD-ROM on hdc and the CD-RW on hdd are broken, but work
flawlessly under 2.4.20.  According to cdrecord, they are:

  hdc: 'E-IDE   ' 'CD-ROM 56X/AKH  ' 'A8E ' Removable CD-ROM
  hdd: 'AOPEN   ' 'CD-RW CRW4048   ' '1.05' Removable CD-ROM

Both work under 2.4.22 as IDE devices.

Putting ide-scsi over hdc under 2.4.22 leads to a silent hang during
boot (just after the friendly ``ide-cd: passing drive...'' message).

With ide-scsi over hdd, on the other hand, the kernel gets into a loop
reporting that ``the scsi wants to send us more data than expected''.
I am sorry I didn't write the log down, I'll be glad to do that if
anyone thinks it can help.

In either case, a cold boot is necessary.

As an additional data point, cdrecord has the following complaints
about the drives:

  hdc: cdrecord.mmap: Warning: controller returns wrong size for CD capabilities page.  

  hdd: cdrecord.mmap: WARNING: Drive returns wrong startsec (0) using -150

I do realise that this is probably broken hardware.  However, 2.4.20
shows that it is possible to make it work, and I'm wondering what
happened that made 2.4.22 picky.

                                        Juliusz Chroboczek
