Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTL2CF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 21:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTL2CFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 21:05:43 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:20211 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262344AbTL2CFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 21:05:21 -0500
Message-ID: <18d001c3cdb0$2c083760$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
References: <173c01c3cceb$07352490$43ee4ca5@DIAMONDLX60> <20031228144707.GA1489@elf.ucw.cz>
Subject: Re: 2.6.0 swsusp
Date: Mon, 29 Dec 2003 11:04:47 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek replied to me:

> > 2.  When I forgot to say either "resume" or "noresume", the kernel detected
> > that it could not use the swap partition, but it did not offer the
> > possibility to resume.  Surely it could detect early enough that the swap
> > partition is not usable for swap but is usable for resume, and could ask the
> > user whether to do a "resume" or "noresume".
>
> At *that* point, it is no longer possible to resume safely.

Yes and no.  Junio C. Hamano explained the same thing to me, but he ALSO
explained a trick that he uses.  He ALWAYS tells the kernel to do a resume.
Then the kernel detects sufficiently early if a resume is really possible or
not.

Hmm, I guess I still see that if we wait for the kernel to mount / and read
/etc/fstab to find where the swap partition is then it will already be too
late to try resuming from the image in the swap partition.  But
theoretically it must be possible, because a certain famous monopoly
software maker can resume from an image stored in a FILE after starting its
boot sequence.

> > 3.  When swsusp completed its writing, it decided that my ACPI BIOS could
> > not power off automatically.  I wonder why.  No other OS has trouble
> > powering off this machine.  Also on machines with older APM BIOSes, no OS
> > had trouble powering off the machines, not even Linux with APM drivers.  So
> > I could hold the power switch for 4 seconds and the BIOS beeped a warning
> > before powering off, but I wonder why it was necessary.
>
> If regular halt is also unable to power off machine, fill the bug in
> ACPI bugzilla.

Exactly the opposite.  Regular halt works.  For some reason I hadn't tested
regular halt under Linux on this particular machine before first writing the
above (many reboots and suspends but not plain shutdowns).  But I tested a
regular halt later and it powered down automatically.  Only swsusp refuses
to power it down.

