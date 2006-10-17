Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWJQUxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWJQUxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWJQUxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:53:17 -0400
Received: from web83109.mail.mud.yahoo.com ([216.252.101.38]:44666 "HELO
	web83109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750712AbWJQUxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:53:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GoXS1Hj++fdQsGWbwn6HBuiHTpqcfaF/yF1rQuc1l3UYc92aZkLYKdWa23vKMxZ1Mi9Dl/23eIJFKPYdfjYgOj5xi+f5JPnHAoOw0X0Hqx+S645FcSSIDojuaa/ie1z42nw3MNhpioPvEIhfYPt4JdqwhEgLZP0mMZ+Hvk699XA=  ;
Message-ID: <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com>
Date: Tue, 17 Oct 2006 13:53:15 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
To: Ryan Richter <ryan@tau.solarneutrino.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
In-Reply-To: <20061017180003.GB24789@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ryan Richter <ryan@tau.solarneutrino.net> wrote:
> 
> 2.6.19-rc1-git9 doesn't work any better for me.  I haven't tried
> unloading the e1000 module yet.  Since I run the machine off an nfsroot,
> it will require some creativity to test that.
> 
> -ryan

You may try the following patch instead if it's easier for you. It'll likely break suspend stuff,
but you won't need to play around with modules.

Aleks.

--- linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c.orig	2006-10-17 13:36:06.000000000 -0700
+++ linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c	2006-10-17 13:36:50.000000000 -0700
@@ -4847,6 +4847,7 @@
 static void e1000_shutdown(struct pci_dev *pdev)
 {
 	e1000_suspend(pdev, PMSG_SUSPEND);
+	pci_set_power_state(pdev, PCI_D0);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER



