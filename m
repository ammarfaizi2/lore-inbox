Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267472AbUHECRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267472AbUHECRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUHECRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:17:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54479 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267454AbUHECRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:17:14 -0400
To: Grant Grundler <iod00d@hp.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-ia64@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [Fastboot] Re: [BROKEN PATCH] kexec for ia64
References: <200407261524.40804.jbarnes@engr.sgi.com>
	<200407261536.05133.jbarnes@engr.sgi.com>
	<20040730155504.2a51b1fa.rddunlap@osdl.org>
	<m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
	<20040804233335.GD548@cup.hp.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Aug 2004 20:14:55 -0600
In-Reply-To: <20040804233335.GD548@cup.hp.com>
Message-ID: <m1hdri2uw0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler <iod00d@hp.com> writes:

> On Wed, Aug 04, 2004 at 07:07:04AM -0600, Eric W. Biederman wrote:
> > Initially that patch
> > was targeted for a kernel without device_shutdown(), so I was
> > likely considering the old trick of running through all of the PCI
> > devices and disabling their bus master bit.
> 
> Blindly disabling all PCI bus master bits will also kill VGA/serial
> console and any USB keyboard attached to the system.

VGA/serial console devices rarely need to do be bus masters so they
should be fine.

> I'll comment more on the "DMA is a Red Herring" when I can read
> more what it is about.

Most of those cases don't matter as the driver should always be calling
pci_set_master() on startup.  Disabling all the bus master bits on ioxapics
in pci space would likely cripple the system.  As they are architectural
hardware and rarely have pci drivers that can enable them.

In the general case it appears to be overkill, incorrect and
insufficient to disable bus mastering on all PCI devices.  Which is
why device_shutdown() calls device specific code.

Eric
