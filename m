Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTEIAdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTEIAdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:33:13 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:45064 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S262254AbTEIAdL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:33:11 -0400
Date: Thu, 08 May 2003 18:45:42 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Undo aic7xxx changes 
Message-ID: <2804790000.1052441142@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> I've undone aic7xxx changes which were locking up some machines on
> initialization.

Hmm.  It would have been nice to have the oportunity to fix this correctly.
As it stands now, I have really no idea what people were testing or not
since by taking Alan's patch you have lost the complete change history
and the ability to step people through the changes.  I have preserved
this history in the bk send output that is available on my site if at
some point that is useful to you.

> The new driver is now named drivers/scsi/aic79xx and is under
> CONFIG_AIC79XX.

So we now have an extra copy of the assembler, the Config files, and
the aiclib files.  This is not a solution.  If you wanted to selectively
update the aic79xx driver, all you had to do was ask me for the requisite
change sets.  This is what a mainatiner is for.

> Justin, unfortunately I can't even THINK about updating aic7xxx to your
> new driver at the current release stage. I will do so in the 2.4.22.

Does this mean that you will actually take BK changes form me instead of
from just about anyone else that sends you aic7xxx driver updates?  I had
pretty much given up on this.

> The update also contains a PCI posting flush fix from Arjan.

Which is completely unnecessary and in fact will cause hangs and crashes
on many Dell servers.  The "fix" for the VIA systems that violate the
PCI spec is to either:

1) Update the driver correctly so that it's detection logic will
   automatically disable memory mapped I/O for these broken systems.

or 

2) Just disable the BIOS options that configure the system to violate
   the PCI prefetching rules.

Slowing down all systems, even the ones that are *not broken* by doing
extra, random, PCI read cycles is not a fix.

If you want some verification of the Dell issue (which I'm sure will
cause problems on other "fast" systems too), just ask Matt Domsh.

Again, if you have concerns about the aic7xxx or aic79xx drivers, my
mail box is always open.  Waiting to contact me until the last minute
where I can only sit on the sidelines and watch another train wreck is
not the best way to ensure that the drivers function correctly in 2.4.X.

What this basically boils down to is trust.  If you don't trust me,
tell me how I can build that trust.  Without it, I can only continue
to tell most people that contact me with bug reports, "It's already
fixed in the official driver.  You can pull the latest from ..."

--
Justin

