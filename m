Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUGOGNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUGOGNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUGOGNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:13:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35978 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266081AbUGOGNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:13:05 -0400
To: fastboot@osdl.org
cc: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] [PATCH] 2.6.8-rc1-kexec1  (ppc & x86)
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jul 2004 00:12:52 -0600
Message-ID: <m1llhlajdn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally found some time to work on kexec again.
I have taken the time to break the patches apart again, because
with everything all in one patch things get unmaintainable.

But I have also lumped everything together in one big patch to make testing
easier.

While doing this I found a bug where I was not putting IOAPIC into
virtual wire mode where appropriate.  This allows kexec to work on Opterons
and other affected systems.

The files are available at:
lynx http://www.xmission.com/~ebiederm/files/kexec/2.6.8-rc1-kexec1


The first hunk of patches are essentially generic fixes to the boot
process.  That should be safe to apply in general.

i8259-shutdown.patch
apic-shutdown.patch
reboot-on-bsp.patch
ioapic-virtwire.patch


x86 does not like tlb flush or other generic code against the init_mm
this allows those to proceed.  I think long term I want to get away from
using init_mm, to many architectures make weird assumptions.

flush-init-mm.patch

The next are the kexec patches themselves.  The generic code and then
the architecture specific code.

kexec-generic.patch
i386-kexec.patch
ppc-gc-kexec.patch

Have fun with it, and please report what breaks.

Eric



