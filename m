Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290322AbSAPBQ1>; Tue, 15 Jan 2002 20:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290321AbSAPBQR>; Tue, 15 Jan 2002 20:16:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290319AbSAPBQE>; Tue, 15 Jan 2002 20:16:04 -0500
Subject: Re: Oopses in scheduler on Linux-2.4.17-xfs
To: pwaechtler@loewe-komp.de (Peter =?iso-8859-1?Q?W=E4chtler?=)
Date: Wed, 16 Jan 2002 01:28:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C44B260.D1FA47BF@loewe-komp.de> from "Peter =?iso-8859-1?Q?W=E4chtler?=" at Jan 15, 2002 11:51:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Qerz-00070o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently get oopses on 2.4.14-xfs and 2.4.17-xfs.
> box is SMP with old Pentium Pro
> There were some changes with erratas of the Pro ans something
> with "cacheline alignment" and a fence.

Unrelated - in fact you have bugs before and after. The fixes in question
were two sets

1.	In certain bizarre situations the ppro violates store ordering. It
	needs lock based spin_unlock to avoid that. Ditto locks to ensure
	stores don't bypass stuff on pci_map interfaces. (This btw is the
	same errata as the FENCE stuff in libglide is all about)

2.	Certain address ranges must never be cached on the ppro due to an
	errata. We broke that in two ways - if there was RAM there, and
	if we mapped a card there and set MTRR's to write combine it.

Alan
