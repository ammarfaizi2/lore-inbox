Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265793AbUFTLqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265793AbUFTLqN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUFTLqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 07:46:13 -0400
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:10908 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S265793AbUFTLpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 07:45:52 -0400
Date: Sun, 20 Jun 2004 14:45:51 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: linux-kernel@vger.kernel.org
cc: Acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.7 ACPI OOPS (random dereferrencing)
In-Reply-To: <1087571167.22483.20.camel@forum-beta.geizhals.at>
Message-ID: <Pine.LNX.4.58.0406201340560.1998@kai.makisara.local>
References: <Pine.LNX.4.60.0406180957470.977@hosting.rdsbv.ro>
 <1087571167.22483.20.camel@forum-beta.geizhals.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Thomas Zehetbauer wrote:

> Since at least 2.6.7-rc2 several people have hit this bug and posted
> here. Unfortunately I have not seen a single follow-up from the ACPI
> guys and somehow I doubt that they even read this list.
> 
> From: 	Thomas Zehetbauer <thomasz@hostmaster.org>
> Subject: 	Re: Linux 2.6.7 - ACPI still broken
> Date: 	Wed, 16 Jun 2004 19:42:57 +0200
> 
> From: 	Kevin P. Fleming <kpfleming@backtobasicsmgmt.com>
> Subject: 	Re: Linux 2.6.7 - ACPI still broken
> Date: 	Wed, 16 Jun 2004 21:15:05 -0700
> 
> From: 	Grzegorz Kulewski <kangur@polcom.net>
> Subject: 	2.6.7-rc3-mm1 problems (ACPI and others)
> Date: 	Thu, 10 Jun 2004 21:57:58 +0200 (CEST)
> 
> From: 	Pozsar Balazs <pozsy@uhulinux.hu>
> Subject: 	Re: 2.6.7-rc3-mm1 problems (ACPI and others)
> Date: 	Fri, 11 Jun 2004 01:10:34 +0200
> 
> From: 	Thomas Zehetbauer <thomasz@hostmaster.org>
> Subject: 	Re: Linux 2.6.7-rc3 / ACPI broken
> Date: 	Mon, 07 Jun 2004 23:37:01 +0200
> 
> From: 	Grzegorz Kulewski <kangur@polcom.net>
> Subject: 	modprobing ACPI(?) module gives oops (2.6.7-rc2-mm2)
> Date: 	Sat, 5 Jun 2004 23:33:57 +0200 (CEST)
> 
> From: 	Sebastian Ley <ley@debian.org>
> Subject: 	modprobe acpi segfaults
> Date: 	Sat, 05 Jun 2004 02:18:09 +0200
> 
I have a similar problem with one of my computers, too. The motherboard is 
Intel D875PBZLK with 2.6 GHz P4, BIOS P22. It hangs after "ACPI Namespace 
successfully loaded at root b04f60bc". There may be a message "Unable to 
handle kernel paging request" or some more or less garbled text (none with 
the latest kernel versions). An example:

eUtabha dle kedle kNUne  oULt p ierer rercee----1->-na-[ c4t aerv 
r-ual---d--ss 00e0n02 U  rt t
inguei/asm/s0ineock
:*6!
= nv0l0d0o
erand: 0000 [#1]
SMP 
CPU:    1
EIP:    0060:[<b011cda2>]    Not tainted

After this the kernel hangs tight. The magic keys don't work. Disabling  
ACPI (acpi=off) or using it only for HT detection (acpi=ht) allow normal 
booting and operation.

The reports in the list above do not all point to similar symptoms. The 
reports from Thomas, Kevin, Pozsar, and me seem to have two things in 
common:
- an Intel motherboard
- hang when enabling ACPI

I have made experiments with different kernels. First some experiments 
with 2.6.7 + csets up to now (should be equal to 2.6.7-bk3). The problem 
is still present with my standard configuration (SMP). Trying some 
different config options gives these results:
SMP                   hangs
UP                    works
UP lapic ioapic       works

Testing older versions reveals that my problems start at 2.6.6-bk1 (2.6.6 
works). It did not contain any ACPI changes that would explain this 
but it was a big patch (lots of scheduling patches).

The patch Pozsar posted on 11 Jun solves (hides) the problem. However, it 
reverts a change appearing at 2.6.6-bk8. Puzzling.

-- 
Kai
