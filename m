Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbULFBo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbULFBo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 20:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULFBo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 20:44:26 -0500
Received: from imap.gmx.net ([213.165.64.20]:18125 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261445AbULFBoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:44:19 -0500
X-Authenticated: #19846908
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
From: Sebastian Heutling <sheutlin@gmx.de>
Reply-To: sheutlin@gmx.de
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Sven Hartge <hartge@ds9.argh.org>
In-Reply-To: <41B34863.3090007@g-house.de>
References: <41B23DF2.4010303@g-house.de>
	 <1102207299.6778.16.camel@weizen.left.earth>  <41B34863.3090007@g-house.de>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 02:46:14 +0100
Message-Id: <1102297574.7138.17.camel@weizen.left.earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 18:41 +0100, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Sebastian Heutling schrieb:
> > You got the powerstack booting from scsi (reading and interpreting the
> 
> yes, but now the disk is gone and i have to use nfsroot.
> 
> > bug report). I had problems booting 2.6 kernels as well (never tested
> > any 2.5 kernels). It turned out that the pci slot numbering has changed
> > sometime and this wasn't reflected in arch/ppc/platforms/prep_pci.c.
> > After having set up the slot0...slot8 using the values of
> > slot10...slot18 (except for slot1 which got value 4 so IDE is usable out
> > of the box), the machine booted a 2.6 kernel (2.6.8).
> 
> boy! this *is* an early christmas present, for sure! how did you come to
> this conclusion? something *must* have changed in the pci setup after

:-)

Pure trial and error in the first time. When realising that something is
wrong with the assigned interrupts (looking at the kernel output) we
tried to set the ones that were working in a 2.4 kernel. When the
machine finally booted a "lspci" showed that the slot number changed.



> 2.5.30, because the problem did not go away when i used a different NIC
> driver. but i could not fiddle out the changeset to blame here, because i
> failed to compile many kernels > 2.5.30.
> 
> changing one line in arch/ppc/platforms/prep_pci.c made my PReP booting a
> recent 2.6-BK, patch attached.
> 
> it's booting now, "init=/bin/bash" is working, but i still can't ping to
> the outside world, which is still a bit strange, but i hope i can work it out.

Is it that onboard network tulip kind of thingy? Do you have some other
PCI cards installed?
I used to have an extra symbios logic scsi-host-adapter installed.
On high network load and loading/writing to a HD (using onboard scsi), I
noticed a lot of problems: either the scsi-host-adapter lost the
interrupt or the network driver lost some packets or both. After having
removed the extra scsi-host-adapter it works fine now.

> 
> tausend dank (really),

You are welcome!


Sebastian


