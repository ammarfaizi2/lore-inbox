Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUJBK67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUJBK67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 06:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUJBK67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 06:58:59 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:41132 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S267401AbUJBK64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 06:58:56 -0400
Date: Sat, 2 Oct 2004 12:58:53 +0200
From: Tim Cambrant <cambrant@acc.umu.se>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-ID: <20041002105853.GD11386@shaka.acc.umu.se>
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <20041002105038.GB2470@stusta.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002105038.GB2470@stusta.mhn.de>
User-Agent: Mutt/1.4.1i
X-Operating-System: SunOS shaka.acc.umu.se 5.8 Generic_117000-05 sun4u sparc SUNW,Ultra-250 Solaris
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 12:50:38PM +0200, Adrian Bunk wrote:
> On Sat, Oct 02, 2004 at 02:29:21AM -0700, Andrew Morton wrote:
> > Norbert Preining <preining@logic.at> wrote:
> > >
> > > ..
> > >    LD      .tmp_vmlinux1
> > >  arch/i386/kernel/built-in.o(.text+0x111f5): In function `end_level_ioapic_irq':
> > >  : undefined reference to `irq_mis_count'
> > >  kernel/built-in.o(.text+0x1eba7): In function `ack_none':
> > >  : undefined reference to `ack_APIC_irq'
> > >  make[1]: *** [.tmp_vmlinux1] Fehler 1
> > >  make[1]: Leaving directory `/usr/src/linux-2.6.9-rc3-mm1'
> > 
> > hm, that's clever.
> > 
> > See if arch/i386/kernel/io_apic.c needs
> 
> s/io_apic.c/irq.c/ and it should solve Norberts problem.
> 
> > #include <asm/io_apic.h>
> >...
> 

Sorry, forgot to cc LKML. The following patch works for me.


--- linux-2.6.9-rc3-mm1/arch/i386/kernel/irq.c.orig     2004-10-02 12:52:57.833294096 +0200
+++ linux-2.6.9-rc3-mm1/arch/i386/kernel/irq.c  2004-10-02 12:53:14.935694136 +0200
@@ -17,6 +17,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
+#include <asm/io_apic.h>
 
 #ifdef CONFIG_4KSTACKS
 /*


-- 

        Tim Cambrant
     cambrant@acc.umu.se
http://www.acc.umu.se/~cambrant/
