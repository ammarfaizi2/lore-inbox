Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUJKRjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUJKRjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUJKRjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:39:12 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:33542 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S269097AbUJKRjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:39:08 -0400
Date: Mon, 11 Oct 2004 19:39:01 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
Message-ID: <20041011173901.GA66749@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org> <20041011145628.GA2672@elf.ucw.cz> <Pine.LNX.4.58.0410110826380.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410110826380.3897@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 08:30:16AM -0700, Linus Torvalds wrote:
> That's the one. suspend-to-disk works, but suspend-to-ram leaves the fam 
> going, and does not come back no matter how many times you press the power 
> button. You need to kill it (twice) by holding the power button for five 
> seconds (which is the "hard-power-off" signal to the southbridge, when 
> everything else is locked up).

I had a somewhat equivalent problem with suspend-to-ram (working but
no wakeup) which required two patches:
- add PWRB and LID0 as wakeup devices[1]
- ignore PRWF since it doesn't send acpi events [2]

It was with a 2.6.8-rc2 kernel, so the situation may have changed since then.

  OG.

[1] Seems added now, did you check the contents of /proc/acpi/wakeup_devices ?
[2] http://bugzilla.kernel.org/show_bug.cgi?id=1920
