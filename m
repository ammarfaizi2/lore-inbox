Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWCMTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWCMTzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWCMTzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:55:03 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:39876 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932404AbWCMTzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:55:00 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux v2.6.16-rc6
Date: Mon, 13 Mar 2006 12:54:53 -0700
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060312090305.GA18134@infradead.org>
In-Reply-To: <20060312090305.GA18134@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131254.53838.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 02:03, Christoph Hellwig wrote:
> On Sat, Mar 11, 2006 at 03:58:12PM -0800, Linus Torvalds wrote:
> > Bjorn Helgaas:
> >       [IA64] don't report !sn2 or !summit hardware as an error
> >       [IA64] SGI SN drivers: don't report !sn2 hardware as an error
> 
> These should be reverted.  They return success from initcalls when they
> should report failure.  In the mmtimer case this is a real bug as it can
> be modular, in others it's just cosmetic but provides people wrong examples
> to cut & paste from.

Do you want all the drivers that just return pci_register_driver(&foo)
to be changed as well?  I haven't heard a compelling argument either way,
but there are certainly many drivers that return 0 when they successfully
register a driver that didn't find any devices, e.g., 

    static int __init serial8250_pci_init(void)
    {
        return pci_register_driver(&serial_pci_driver);
    }
