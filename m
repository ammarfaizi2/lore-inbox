Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbRDRUrs>; Wed, 18 Apr 2001 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135320AbRDRUri>; Wed, 18 Apr 2001 16:47:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29193 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135318AbRDRUrZ>; Wed, 18 Apr 2001 16:47:25 -0400
Subject: Re: Linux 2.4.3-ac7
To: andrew.grover@intel.com (Grover, Andrew)
Date: Wed, 18 Apr 2001 21:08:55 +0100 (BST)
Cc: martin@net.lut.ac.uk ('Martin Hamilton'),
        linux-power@phobos.fachschaften.tu-muenchen.de ("Acpi-PM (E-mail)"),
        linux-kernel@vger.kernel.org
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9B@orsmsx35.jf.intel.com> from "Grover, Andrew" at Apr 18, 2001 11:54:16 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pyG2-0005c5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was wondering whether the swsusp work might form a useful basis for 
> > the eventual ACPI implementation of the to-disk hibernation stuff:
> 
> I (and others) have looked at it. It's a pretty cool patch, but it really
> isn't the right way to do things.

swsusp is most definitely the right way to do things. It works on my laptop
which has non suspend to disk APM, it even works on my MVP3 board where
ACPI bombs totally (BIOS bug).

It might not be the right thing to do if ACPI suspend is present though.

Actually swsusp has one minor problem. Because of implementation bugs in some
of the journalled file systems like ext3 using swsusp with those file systems
can corrupt your disks (they write to disk even when told to mount read only
rather than replaying the log to disk when the mount goes r/w - which is
really antisocial, breaks if you are trying to recover from a failed disk and
wants fixing.)

