Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWF3Gyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWF3Gyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWF3Gyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:54:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:15659 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751215AbWF3Gyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:54:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eakmUX4akZYqFOZm5P6l8XiKxuLO1NiB7wa+MfWsOi/Vxy044mx106WfnK4O3zYU0ufzqrYY6eO5uyFBIrXFOje4KiMTYuSBcw6m59lCCe0J5arHy2PaNNvA4+X6mdc6AckDkRQJN2ww+IER72f2hHvTkC4RoymUFOzgqGofYHs=
Message-ID: <aec7e5c30606292354x3831f550y9ac2387f2fa56679@mail.gmail.com>
Date: Fri, 30 Jun 2006 15:54:52 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: .exit.text section in vmlinux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I understand why ".exit.text" is present in the case of modules, but I
can't get my head around why it is included in the vmlinux file.
Functions like the ones below puzzle me:

kernel/configs.c: static void __exit ikconfig_cleanup(void)
drivers/net/ne2k-pci.c: static void __exit ne2k_pci_cleanup(void)
drivers/net/ne2k-pci.c: static void __devexit ne2k_pci_remove_one
(struct pci_dev *pdev)

I can see how the last "__devexit" function might be called during
some hotplug event, but are the two "__exit" functions ever going to
be called from the kernel? Since my kernel is configured without
CONFIG_HOTPLUG both both "__exit" and "__devexit"  end up in the
".exit.text" section.

The linker script arch/i386/kernel/vmlinux.lds.S mentions the following:

  /* .exit.text is discard at runtime, not link time, to deal with references
     from .altinstructions and .eh_frame */

The text above seems to answer my question, but I cannot say I fully
understand the comment. I'd appreciate if someone could explain a bit
more if possible.

Ok, so the section should be discarded at runtime. Sounds ok. But
where in the code is this section discarded? -ENOSYS?

Thanks,

/ magnus
