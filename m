Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUHWPgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUHWPgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHWPe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:34:29 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:58508 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S265108AbUHWPab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:30:31 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Mon, 23 Aug 2004 09:30:18 -0600
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
References: <20040819092654.27bb9adf.akpm@osdl.org> <200408191603.55327.bjorn.helgaas@hp.com> <20040819225848.GE1263@hygelac>
In-Reply-To: <20040819225848.GE1263@hygelac>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408230930.18659.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 4:58 pm, Terence Ripperda wrote:
> but in Kevin's original email[1], he's hitting an oops within the
> pci_enable_device call. is that likely due to pci_enable_device being
> called late?

[1] http://www.uwsg.indiana.edu/hypermail/linux/kernel/0408.1/0127.html

Kevin, I suspect the oops you're seeing is due to the problem mentioned
here (add_pin_to_irq() is __init but shouldn't be):

    http://groups.google.com/groups?dq=&start=75&hl=en&lr=&ie=UTF-8&group=fa.linux.kernel&c2coff=1&selm=fa.j8igrci.1fgg680%40ifi.uio.no

Can you try Randy's patch without using "pci=routeirq" and see whether
it resolves the oops?  Of course, the nvidia driver still won't work
because it's looking at pci_dev->irq before calling pci_enable_device(),
but that's a separate issue.
