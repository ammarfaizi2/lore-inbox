Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272140AbTGYPDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTGYPCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:02:48 -0400
Received: from dhcp065-024-128-253.columbus.rr.com ([65.24.128.253]:29330 "EHLO
	doug.hunley.homeip.net") by vger.kernel.org with ESMTP
	id S272141AbTGYPAx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:00:53 -0400
From: Douglas J Hunley <doug@hunley.homeip.net>
Organization: Linux StepByStep
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.0: Badness in pci_find_subsys!!
Date: Fri, 25 Jul 2003 11:15:56 -0400
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307241326.04656.doug@hunley.homeip.net> <200307250345.h6P3jTDE011119@turing-police.cc.vt.edu>
In-Reply-To: <200307250345.h6P3jTDE011119@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307251116.00714.doug@hunley.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu shocked and awed us all by speaking:
> On Thu, 24 Jul 2003 13:26:01 EDT, Douglas J Hunley <doug@hunley.homeip.net>  
said:
> > Just had my athlon box lock-up solid. needed SysRq to reboot the thing..
> > kernel info follows:
> > Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at
> > drivers/pci/search.c:132
> > Jul 24 13:08:23 doug kernel: Call Trace:
> > Jul 24 13:08:23 doug kernel:  [<c02064a1>] pci_find_subsys+0x111/0x120
> > Jul 24 13:08:23 doug kernel:  [<c02064df>] pci_find_device+0x2f/0x40
> > Jul 24 13:08:23 doug kernel:  [<c0206368>] pci_find_slot+0x28/0x50
> > Jul 24 13:08:23 doug kernel:  [<f8a2ada4>] os_pci_init_handle+0x3a/0x67
>
> The 'badness in pci_find_subsys' may not be related to your hang.
>
> The NVidia msgs are basically caused by the fact that pci_find_slot() is
> getting called in an interrupt, so we trigger the WARN_ON in
> pci_find_subsys(). The worry here is that we may be walking the PCI list on
> the interrupt side while something else is hotplugging a new device into
> existence, causing it to walk off the end of a inconsistent list.  Unless
> you actually crapped out right at 13:08:23, it's probably unrelated.

OK. But I don't have any hot-plugging enabled on this machine. Unless the 
kernel is internally doing things...

It crapped out within a matter of seconds. Started chewing up all available 
system RAM, then went totally non-responsive to anything but SysRQ (couldn't 
even kill X with CTRL-ALT-BKSP)

>
> (I was getting the same NVidia traceback on a regular basis (3-4 at every
> start of the X server, and 1 at X server shutdown) under 2.5.72-mm3, they
> stopped when I went to 2.5.73-mm1.  If you're still seeing them in
> 2.6.0-test1, I would suspect something different in the -mm series is
> fixing them for me - first place to look is what got added between 72-mm3
> and 73-mm1.

I try to stick w/ Linus' tree, but I'll attempt to decipher the changelogs on 
the -mm tree...
- -- 
Douglas J Hunley (doug at hunley.homeip.net) - Linux User #174778
http://doug.hunley.homeip.net && http://www.linux-sxs.org

It takes 47 muscles to frown, but only 4 to pull the trigger of a finely tuned 
sniper rifle.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IUms2MO5UukaubkRArquAJ9uQPVhVSXeyORENJtJxm3ROL9HxgCcDETj
5SXTjSq70hlgXz56TErFDlk=
=EKbw
-----END PGP SIGNATURE-----

