Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWBUALj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWBUALj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWBUALj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:11:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161214AbWBUALj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:11:39 -0500
Date: Mon, 20 Feb 2006 16:09:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: efault@gmx.de, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       brlink@debian.org
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Message-Id: <20060220160955.3f0c4671.akpm@osdl.org>
In-Reply-To: <200602210102.47371.rjw@sisk.pl>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<200602210036.30836.rjw@sisk.pl>
	<20060220154025.0b547085.akpm@osdl.org>
	<200602210102.47371.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > > An unrelated problem is that USB host drivers (ohci-hcd, ehci-hcd) refuse to
> > > suspend.  [Investigating ...]
> > 
> > Me too.
> > 
> > Try reverting reset-pci-device-state-to-unknown-after-disabled.patch.
> 
> Heh, that actually helps. :-)  Still I have no idea why is that so ...

Because some PCI drivers do pci_disable_device() before
pci_set_power_state().  pci_set_power_state() sees PCI_UNKNOWN and runs
away in terror.

Whether those drivers _should_ be setting the power state of a disabled
device is an open question...
