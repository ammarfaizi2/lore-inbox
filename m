Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266596AbUGUTJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUGUTJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 15:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266588AbUGUTJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 15:09:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51615 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266596AbUGUTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 15:09:43 -0400
To: Mike Snitzer <snitzer@gmail.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BUG] e1000 on reboot/boot path.
References: <20040719181115.86378.qmail@web52302.mail.yahoo.com>
	<m1y8le3cto.fsf@ebiederm.dsl.xmission.com>
	<170fa0d2040720180741cfa783@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jul 2004 13:09:11 -0600
In-Reply-To: <170fa0d2040720180741cfa783@mail.gmail.com>
Message-ID: <m1hds12n54.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@gmail.com> writes:

So you have a problem that the e1000 driver does not properly
shutdown the e1000 in the reboot path (no code).  But it does properly
cleanup when you remove the module.

>  I've been bitten by this issue
> with the e1000 (<= 5.2.52-k4) driver.  With an "Ethernet controller:
> Intel Corp. 82546EB Gigabit Ethernet Controller", device id# 1010, I
> get:
> 
> Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
> Copyright (c) 1999-2004 Intel Corporation.
> PCI: Enabling device 04:05.0 (0000 -> 0003)
> Uhhuh. NMI received for unknown reason 31.
> Dazed and confused, but trying to continue
> Do you have a strange power saving mode enabled?
> The EEPROM Checksum Is Not Valid
> PCI: Enabling device 04:05.1 (0000 -> 0003)
> The EEPROM Checksum Is Not Valid
> 
> The 5.2.52-k4 has toned down, yet basically the same, errors.  This
> message results when kexec'ing from a 2.6.7 kernel with the e1000
> builtin; once I made the e1000 a module and unloaded it prior to
> kexec'ing all was fine.
> 
> Looking at the e1000 source it is clear that removing the e1000 module
> triggers e1000_remove() via module_exit()'s pci_unregister_driver(). 
> Once the e1000 let go of the PCI resources the kexec'd kernel's e1000
> driver was happy.  Kexec looks to call all loaded modules' shutdown()
> routine.  The e1000 doesn't have shutdown(); but it does have a
> remove().
> 

Eric
