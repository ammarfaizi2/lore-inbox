Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUDFSgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbUDFSgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:36:14 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:57216 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263946AbUDFSgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:36:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16498.63623.379072.588962@gargle.gargle.HOWL>
Date: Tue, 6 Apr 2004 14:35:51 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "John Stoffel" <stoffel@lucent.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.6.5-rc3: cat /proc/ide/hpt366 kills disk on second channel
In-Reply-To: <200404061900.36497.bzolnier@elka.pw.edu.pl>
References: <16496.41345.341470.807320@gargle.gargle.HOWL>
	<16498.54669.886834.727923@gargle.gargle.HOWL>
	<200404061900.36497.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Bart,

I'm compiling 2.6.3 right now with that patch and I'll let you know
how it goes.

Could it be that someone just mixed up the outb() and meant to use
inb() in that section?  I don't know the driver (or much kernel stuff)
in any detail.  Hmm... looking at it, it seems like they expect that
reading the cable info then requires your to mask some bits off and
then re-read to get the other port.  Whee...

I wonder how hard it would be to put in locking there.  I'll let you
know ASAP how well this fix works in the short run.

Should I try to look through all the various *_get_info() routines to
see if any others are doing outb() calls as well?

Heh... just looking at the code for aec62xx.c, should we be really
using pci_read_config_byte() instead of inb() in the hpt366.c code?

John

