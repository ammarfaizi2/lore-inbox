Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVI0HMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVI0HMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVI0HMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:12:24 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54242 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964839AbVI0HMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:12:23 -0400
Message-Id: <200509270711.j8R7BunP014387@death.nxdomain.ibm.com>
To: Florin Malita <fmalita@gmail.com>
cc: nsxfreddy@gmail.com, akpm@osdl.org, davem@davemloft.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, bonding-devel@lists.sourceforge.net
Subject: Re: [PATCH] channel bonding: add support for device-indexed parameters 
In-Reply-To: Message from Florin Malita <fmalita@gmail.com> 
   of "Tue, 27 Sep 2005 01:24:44 EDT." <20050927012444.be5d5311.fmalita@gmail.com> 
X-Mailer: MH-E 7.83; nmh 1.0.4; GNU Emacs 21.4.2
Date: Tue, 27 Sep 2005 00:11:56 -0700
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Florin Malita <fmalita@gmail.com> wrote:
[...]
>How can you load a module multiple times on _any_ distro?

	modprobe -obond0 bonding mode=your-favorite-mode
	modprobe -obond1 bonding mode=some-other-mode

	and so on.  This is in the modprobe man page, and is described
in the bonding documentation (found in the kernel documentation or at
http://sourceforge.net/projects/bonding).  It is admittedly somewhat
grotty, but it works.  The current planned API path that allow one
module load (or compiling bonding into the kernel) to create multiple
discrete bonding devices is sysfs.

[...]
>> 	In any event, your patch does not provide enough flexibility to
>> allow the distro scripts to switch to it (it omits arp_ip_target), so
>> the init scripts will be unable to switch.
>
>The patch is not forcing the scripts to switch since the old syntax/ABI
>still works (one reason I didn't touch arp_ip_target was to preserve
>that). It's simply providing an additional (saner) approach to bonding
>configuration which can easily co-exist with the sysfs solution.

	It's not about forcing use; it's about adding an incomplete and
inconsistent feature, and the attendant maintenance and documentation
load.

	In general, I can see the value of allowing users to specify all
of the parameters for some number of bonding devices on a single module
load line.  However, the syntax provided by your patch does not parse
the arp_ip_target parameter consistently with the other parameters, and
has no backwards-compatible way to add support for all possible bonding
configurations that I can think of right offhand.

	I don't see the value in a new module parameter syntax that is
not both backwards compatible and allows for specifying any possible set
of bonding module options.

>Not being able to set a (different) preferred
>interface/primary for each bond device makes it unacceptable for
>deployment in our environment.

	How are you configuring bonding?  The current SuSE distros, for
example, will do the multiple module load stuff automatically in the
sysconfig scripts.  This is described in the current bonding
documentation.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
