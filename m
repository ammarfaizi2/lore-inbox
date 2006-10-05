Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWJEWww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWJEWww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWJEWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:52:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:12206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932410AbWJEWwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:52:51 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Fri, 6 Oct 2006 00:52:46 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <452564B9.4010209@garzik.org> <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060052.46538.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In other words, right now we have
> 
> 	int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
> 
> and maybe we will simply have to add a totally new function like
> 
> 	int pci_read_mmio_config_byte(struct pci_dev *dev, int where, u8 *val)
> 
> for drivers that literally _require_ the mmio accesses for one reason or 
> another.

That's easy to decide: if (where >= 256) mmconfig is required. 

I'm just afraid it probably won't help if the MCFG is totally broken and
points to some other devices (like on the Intel boards). Then these drivers will 
just hang and all of Alan's warning  messages won't help with that.

-Andi
