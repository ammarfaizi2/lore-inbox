Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWGaTgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWGaTgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGaTgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:36:05 -0400
Received: from web81206.mail.mud.yahoo.com ([68.142.199.110]:40280 "HELO
	web81206.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750904AbWGaTf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:35:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UGJBu6MzJ2EFmEGClh0uIrrg0zehVDohrOb79mojTHlwx8QftUkNcLD774lmi+/XGuiqiJSJzYzwRJrr8CWWuwXK+Lej2WcwDblRzR1ulmWBD66I4kBKzX+xG3ZeJtball95I78z4ari1E9sAnfkr1mqyVpmhP66uU1IUBoAfLU=  ;
Message-ID: <20060731193544.71481.qmail@web81206.mail.mud.yahoo.com>
Date: Mon, 31 Jul 2006 12:35:44 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0607311450120.8671-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, 31 Jul 2006, Aleksey Gorelov wrote:
> 
> > > Why do you need to change the bus glue?  Wouldn't it be a lot simpler just 
> > > to add ehci_shutdown as a member of ehci_pci_driver, for instance, with 
> > > similar changes to ehci_hcd_au1xxx_driver and ehci_hcd_fsl_driver?
> > > 
> > > Alan Stern
> > 
> >   This avoids code duplication for common for both ehci and ohci code
> 
> What code duplication?  Doing it the way I suggested doesn't require 
> adding any new code at all.  You, on the other hand, added several 
> routines for bus glue that does virtually nothing.

  But you can not use exactly same shutdown function with both pci and platform glue. You need to
convert pci/platform device to hcd anyway, right ? So this will add 2 doing 'virtually nothing'
routines anyway (unless you just want to duplicate the code of shutdown routine for for platform
glue). For ohci, you would need to do the same, hence 2 more routines, 4 total. With bus glue, I
added just 2. Am I missing something here ?

> 
> > (and possibly for uhci, but
> > it currently does not have any notifier/shutdown handler),
> 
> Yes it does.  From uhci-hcd.c:

My bad. I did not find notifier, but shutdown handler is indeed there. However, uhci is different
in a way it does not use platform driver.

Aleks.
