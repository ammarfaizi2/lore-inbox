Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbUBQGhe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUBQGhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:37:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:9193 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266040AbUBQGhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:37:33 -0500
X-Authenticated: #5429946
From: Felix Seeger <felix.seeger@gmx.de>
To: Len Brown <len.brown@intel.com>
Subject: Re: Linux 2.6.3-rc4 (nforce2)
Date: Tue, 17 Feb 2004 07:49:48 +0100
User-Agent: KMail/1.6.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <A6974D8E5F98D511BB910002A50A6647615F262D@hdsmsx402.hd.intel.com> <1076999506.2510.36.camel@dhcppc4>
In-Reply-To: <1076999506.2510.36.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402170749.48575.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 07:31, Len Brown wrote:
> > Should NForce2 boards also work without patches and with acpi/apic ?
> > I saw a change in rc3.
>
> Some will, some will not.  Note that Maciej's patch didn't address the
> nforce2 timer configuration issue, which I believe requires a
> platform-specific nforce2 patch.
>
> > It just hangs again, so I switched back to my patched kernel.
> > But of course this could be another problem, kernel 2.6.2-rc1 is
> > running very
> > stable here with the apictack-rd and the ioapic-rd patches.
>
> Dunno what those are, but if you still require ACPI-related patches,
> please let me know.
>From the nforce2-apictack-rd-2.6.0.patch:
 /*
+ * Athlon nforce2 R.D.
+ * preset timer ack mode if desired
+ * e.g. static int apic_timerack = 2;

>From the nforce2-ioapic-rd-2.6.0.patch
+#if defined(CONFIG_ACPI_BOOT) && defined(CONFIG_X86_UP_IOAPIC)
+       /* for nforce2 try vector 0 on pin0
+        * Note 8259a is already masked, also by default
+        * the io_apic_set_pci_routing call disables the 8259 irq 0
+        * so we must be connected directly to the 8254 timer if this works
+        * Note2: this violates the above comment re Subtle but works!
+        */

I think I will need more patches, but I will test it today.

> thanks,
> -Len
Felix
