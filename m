Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTAEWnR>; Sun, 5 Jan 2003 17:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTAEWnR>; Sun, 5 Jan 2003 17:43:17 -0500
Received: from h-64-105-35-112.SNVACAID.covad.net ([64.105.35.112]:33975 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265351AbTAEWnP>; Sun, 5 Jan 2003 17:43:15 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 5 Jan 2003 14:51:39 -0800
Message-Id: <200301052251.OAA10215@adam.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, hell.surfers@cwctv.net,
       linux-kernel@vger.kernel.org, lm@bitmover.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
>Is everyone OK with treating the contents
>of header files in the same was as EXPORT_SYMBOL()? ie: LGPL? 

	I don't believe that anyone other than Linus has explicity
given their permission for the "EXPORT_SYMBOL_GPL / EXPORT_SYMBOL"
system.  However, I'm not trying to obstruct other people giving
what permissions they want with the code that they wrote, so I'd
like to point out a problem and suggest a fix to your proposal.

	Your proposal would prevent "EXPORT_SYMBOL_GPL" inline
functions.

	I can think of a solution which would
		(1) allow both kinds of functions and
		(2) which I think would be more legally defensible than
		    posting a message to a mailing list and asking "is
		    everyone OK with it]".

	Have the appropriate copyright owners move their "proprietary
callers OK" inline functions to files with the appropriate copyright
statements (such as LGPL or something similar), or submit changes to
the copyright statements of entire .h files in cases where you've got
the explicit agreement of all the copyright owners for that file.

	Along the same lines, those copyright owners (individuals,
companies, etc.) who seek to create a kernel that contains only
content that allows proprietary modules could start by explicitly
stating that they now irrevocably give the same permission that Linus
gave in his gnu.misc.discuss posting for their past contributions and
any future contributions that they make before they say otherwise.  At
least socially, it would come with better graces for people to grant
permissions on their copyrights before trying to interpret away other
contributors' copyrights.

	However, before you grant such permission, I recommend that
you consider whether permission that allows proprietary linking
against only EXPORT_SYMBOL functions really means allowing proprietary
modules to call *all* functions by just including a GPL-compatible
library module like so:

void loophole_ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d)
{
	return ide_setup_pci_device(dev, d);
	/* ide_setup_pci_device is an EXPORT_SYMBOL_GPL function in 2.5.54. */
}
EXPORT_SYMBOL(loophole_pci_hp_register);


	One could presumably do the same with an function that is not
even exported, and perhaps even avoid the subroutine jump by using
static inline declarations.  As far as I can tell, it would be
essentially equivalent to switching to the LGPL.  Come to think of it,
if this _is_ what you want, then maybe you find it simpler to just
grant permission to copy your code under the LGPL.

	I'm not a lawyer, so don't take this is as legal advice.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
