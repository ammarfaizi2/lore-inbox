Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUJ3Rwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUJ3Rwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUJ3Rwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:52:49 -0400
Received: from canuck.infradead.org ([205.233.218.70]:61452 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261224AbUJ3Rwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:52:47 -0400
Subject: Re: PCI changes kill USB PM
From: Arjan van de Ven <arjan@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200410301044.25476.david-b@pacbell.net>
References: <1099095245.29689.191.camel@gaston>
	 <200410301044.25476.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1099158753.3883.6.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 30 Oct 2004 19:52:33 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 10:44 -0700, David Brownell wrote:

> Where "now" is "after a change from Arjan in May";
> recent changes made it a more significant problem.
> 
> I agree with the guts of your patch -- adding the
> missing "else" in:
> 
> 	if (pci_driver && pci_driver->suspend)
> 		pci_driver->suspend(pdev, state);
> 	else
> 		pci_save_state(pdev);
> 
> That makes Arjan's patch only affect PCI drivers
> which don't know how to suspend/resume themselves;
> that's all his patch was supposed to affect.

well the idea back then was to just always save so that drivers could be lazy and only provide a specialized restore. However I agree with this change now that the API changed where regular state saves use the same storage area. 

