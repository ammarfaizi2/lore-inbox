Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTIBXpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTIBXpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:45:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:19356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbTIBXpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:45:30 -0400
Date: Tue, 2 Sep 2003 16:45:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dale E Martin <dmartin@cliftonlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more details)
Message-ID: <20030902164525.A11944@osdlab.pdx.osdl.net>
References: <20030902003146.GA870@cliftonlabs.com> <20030901182335.4c2e220f.akpm@osdl.org> <20030902123050.GA854@cliftonlabs.com> <20030902130323.41d2fdca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030902130323.41d2fdca.akpm@osdl.org>; from akpm@osdl.org on Tue, Sep 02, 2003 at 01:03:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Looks like it.  Please add a DB() to the start of i8042_interrupt(),
> see if we locked up in an interrupt storm.  Also sprinkle some in 
> request_irq() I guess.  You know the deal ;)

I have similar issue with:
floppy_init()
  floppy_grab_irq_and_dma()
    fd_request_irq()
      request_irq()

      floppy_hardint()
      ...
      floppy_hardint()

This causes interrupt storm, hanging the machine on bootup.  Booting with
pci=noacpi fixes this.  So, I'm assuming acpi pci irq routing problem.
This is irq 6, which ACPI is disabling.  Perhaps disabling leaves it in
a bogus state?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
