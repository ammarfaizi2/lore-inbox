Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVCWWaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVCWWaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVCWWaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:30:05 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:49604 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262405AbVCWW3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:29:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389)
Date: Wed, 23 Mar 2005 23:29:49 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>
References: <20050322013535.GA1421@elf.ucw.cz> <20050322110126.GB1780@elf.ucw.cz> <200503222249.54091.rjw@sisk.pl>
In-Reply-To: <200503222249.54091.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503232329.50461.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 22 of March 2005 22:49, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tuesday, 22 of March 2005 12:01, Pavel Machek wrote:
> > Hi!
> > 
> > > Will this do it for the moment?
> > 
> > Its certainly better.
> 
> With the Len's patch applied I have to unload the modules:
> 
> ohci_hcd
> ehci_hcd
> yenta_socket
> 
> before suspend as each of them hangs the box solid during either
> suspend or resume.  Moreover, when I tried to load the ehci_hcd
> module back after resume, it hanged the box solid too.

This behavior is apparently caused by the call to pci_write_config_word() with
pmcsr = 0 in drivers/pci/pci.c:pci_set_power_state().

Well, I don't think I can do anything more about it myself. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
