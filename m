Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWGaS20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWGaS20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWGaS20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:28:26 -0400
Received: from web81214.mail.mud.yahoo.com ([68.142.199.43]:9602 "HELO
	web81214.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030308AbWGaS2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:28:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Y1kaXfHgSGyNgAmfHoZtPe4Rx3q5hNlFLqhRLt8XhhOqtz5g6yif2wvfyOB61y/O39BEYt8qpjvm6UbB44vmyZmx3ZxoTxCStB2Xc2lbTAYl6UYpeYR70JdcSD0FmW++lR3f/Ccu8kRUZjyGKHY1QtfA610gpR4S013fU/bBW1g=  ;
Message-ID: <20060731182824.51600.qmail@web81214.mail.mud.yahoo.com>
Date: Mon, 31 Jul 2006 11:28:24 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0607311414360.8047-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, 31 Jul 2006, Aleksey Gorelov wrote:
> 
> >   If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
> > tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to
> crash on
> > reboot/poweroff. The following patch resolves this problem by not using reboot notifiers
> anymore,
> > but instead making ehci/ohci driver get its own shutdown method. For PCI, it is done through
> pci
> > glue, for everything else through platform driver glue.
> 
> Why do you need to change the bus glue?  Wouldn't it be a lot simpler just 
> to add ehci_shutdown as a member of ehci_pci_driver, for instance, with 
> similar changes to ehci_hcd_au1xxx_driver and ehci_hcd_fsl_driver?
> 
> Alan Stern

  This avoids code duplication for common for both ehci and ohci code (and possibly for uhci, but
it currently does not have any notifier/shutdown handler), and is consistent with other functions
there.

Aleks.
