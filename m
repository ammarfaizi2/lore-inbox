Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRIWQYY>; Sun, 23 Sep 2001 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271825AbRIWQYQ>; Sun, 23 Sep 2001 12:24:16 -0400
Received: from ns.caldera.de ([212.34.180.1]:25567 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271645AbRIWQYD>;
	Sun, 23 Sep 2001 12:24:03 -0400
Date: Sun, 23 Sep 2001 18:24:14 +0200
Message-Id: <200109231624.f8NGOEX24344@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: adam@yggdrasil.com ("Adam J. Richter"), linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.10-pre14/drivers/sound/maestro.c ignored pci_module_init results
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010922230237.A10872@baldur.yggdrasil.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010922230237.A10872@baldur.yggdrasil.com> you wrote:

> --M9NhX3UHpAaciwkO
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline

> 	The initialization routine in
> linux-2.4.10-pre14/drivers/sound/maestro.c ignores the return value
> from pci_module_init, and allows module initialization to succeed
> even if pci_module_init failed.  pci_module_init fails and unloads
> the driver if the caller is a module and there is no matching hardware.
> Because maestro.c ignored this failure, loading maestro.o on a system
> where the corresponding alsa driver was already loaded or on a system
> without matchin hardware would result in a kernel null pointer dereference
> in pci_unregister_driver when the module is unloaded or when one
> attempts to reboot the system (i.e., when the module attempt to
> unregister a PCI driver that is not registered).

Why and where does it Oops? The code for pci_unregister_driver in
drivers/pci/pci.c looks correct and should not Oops.

The reboot notifier might be problematic, but I have not checked it.

Ciao, Marcus
