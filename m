Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVCCEqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVCCEqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCCEpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:45:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:33211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261401AbVCCEi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:38:56 -0500
Date: Wed, 2 Mar 2005 20:38:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, jgarzik@pobox.com, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302203812.092f80a0.akpm@osdl.org>
In-Reply-To: <20050303002733.GH10124@redhat.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Mar 02, 2005 at 04:00:46PM -0800, Linus Torvalds wrote:
> 
>  > I would not keep regular driver updates from a 2.6.<even> thing. 
> 
> Then the notion of it being stable is bogus, given how many regressions
> the last few kernels have brought in drivers.  Moving from 2.6.9 -> 2.6.10
> broke ALSA, USB, parport, firewire, and countless other little bits and
> pieces that users tend to notice.

Grump.  Have all these regressions received the appropriate level of
visibility on this mailing list?

I too am a little put off by the number of regressions which certain
(admittedly tricky) subsystems keep on introducing.  One does wonder how
careful people are being at the development stage.  And that's a thing
which we can surely fix.

For example, here's today's crop (so far):

include/linux/soundcard.h:195: warning: `_PATCHKEY' redefined
include/linux/awe_voice.h:33: warning: this is the location of the previous definition
drivers/i2c/chips/ds1337.c:60: `I2C_DRIVERID_DS1337' undeclared here (not in a function)
drivers/i2c/chips/ds1337.c:60: initializer element is not constant
drivers/i2c/chips/ds1337.c:60: (near initialization for `ds1337_driver.id')
drivers/i2c/chips/ds1337.c: In function `ds1337_get_datetime':
drivers/i2c/chips/ds1337.c:155: structure has no member named `id'
drivers/i2c/chips/ds1337.c: In function `ds1337_set_datetime':
drivers/i2c/chips/ds1337.c:206: structure has no member named `id'
drivers/i2c/chips/ds1337.c: In function `ds1337_detect':
drivers/i2c/chips/ds1337.c:333: structure has no member named `id'
drivers/i2c/chips/ds1337.c:343: structure has no member named `id'
make[3]: *** [drivers/i2c/chips/ds1337.o] Error 1
make[2]: *** [drivers/i2c/chips] Error 2
make[1]: *** [drivers/i2c] Error 2
make[1]: *** Waiting for unfinished jobs....
sound/pci/als4000.c: In function `snd_als4000_create_gameport':
sound/pci/als4000.c:572: warning: `r' might be used uninitialized in this function
drivers/char/watchdog/alim1535_wdt.c:319: warning: `ali_pci_tbl' defined but not used
drivers/char/sx.c:255: warning: `sx_pci_tbl' defined but not used
drivers/char/applicom.c:68: warning: `applicom_pci_tbl' defined but not used
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
sound/pci/trident/trident_main.c: In function `snd_trident_gameport_trigger':
sound/pci/trident/trident_main.c:3125: warning: `return' with a value, in function returning void

> For it to truly be a stable kernel, the only patches I'd expect to
> drivers would be ones fixing blindingly obvious bugs. No cleanups.
> No new functionality. I'd even question new hardware support if it
> wasn't just a PCI ID addition.

Agree.
