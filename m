Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVHEXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVHEXDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVHEXDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:03:52 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:3706 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262026AbVHEXDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:03:21 -0400
Date: Fri, 5 Aug 2005 16:03:00 -0700
From: Greg KH <gregkh@suse.de>
To: yhlu <yhlu.kernel@gmail.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <rolandd@cisco.com>,
       linville@tuxdriver.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
Message-ID: <20050805230300.GA4363@suse.de>
References: <86802c440508051103500f6942@mail.gmail.com> <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com> <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com> <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org> <20050805220015.GA3524@suse.de> <86802c4405080515257ddaa8d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c4405080515257ddaa8d2@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:25:02PM -0700, yhlu wrote:
> In LinuxBIOS, We can allocate 64 bit region ( 0xfc0000000....) to the
> mellanox Infiniband card. Some range above 4G.  So the mmio below 4G
> is some smaller only 128M, Otherwise need 512M. If 4 IB cards are
> used, the mmio will be 2G. For new opteron E stepping, We could use
> hareware memhole support. But if the CPU is before opteron E, We only
> can use SW mem mapping ( will lose some performance) or lose (2G RAM).
> at such case We need 64bit pref mem. We only lose 128M even four IB
> card are installed.
> 
> yesterday, someone add pci_restore_bars...., that will call
> pci_update_resource, and it will overwirte upper 32 bit of BAR2 and
> BAR4 of IB card.

Hm, perhaps that change should not do this?

Dominik, care to weigh in here?  That was your patch...

> So the patch make pci_restore_resource
> 1. don't touch BAR3, and BAR5, if BAR2, and BAR4 are 64 bit MEM IO
> 2. not assume BAR2 and BAR4 upper 32bit is 0 if if BAR2, and BAR4 are
> 64 bit MEM IO


thanks,

greg k-h
