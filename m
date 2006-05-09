Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWEIUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWEIUiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWEIUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:38:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751130AbWEIUiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:38:51 -0400
Date: Tue, 9 May 2006 13:41:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: cw@f00f.org, linux-kernel@vger.kernel.org, masouds@masoud.ir,
       jeff@garzik.org, gregkh@suse.de
Subject: Re: [PATCH] VIA quirk fixup, additional PCI IDs
Message-Id: <20060509134101.32ef49c1.akpm@osdl.org>
In-Reply-To: <20060509201450.GK15257@redhat.com>
References: <20060430162820.GA18666@masoud.ir>
	<20060509191455.GA27503@taniwha.stupidest.org>
	<20060509125916.03c96efe.akpm@osdl.org>
	<20060509201450.GK15257@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Tue, May 09, 2006 at 12:59:16PM -0700, Andrew Morton wrote:
>  > Chris Wedgwood <cw@f00f.org> wrote:
>  > >
>  > > An earlier commit (75cf7456dd87335f574dcd53c4ae616a2ad71a11) changed
>  > > an overly-zealous PCI quirk to only poke those VIA devices that need
>  > > it.  However, some PCI devices were not included in what I hope is now
>  > > the full list.
>  > > 
>  > > This should I hope correct this.
>  > > 
>  > > Thanks to Masoud Sharbiani <masouds@masoud.ir> for pointing this out
>  > > and testing the fix.
>  > 
>  > This looks like a 2.6.17-worthy fix, but it's not clear.  Help.  What
>  > happens if 2.6.17 doesn't have this??
> 
> We won't run the quirk on machines that used to have it run,
> so we get buggered up irq routing.
> 

OK..

We used to have

DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);

and we now have

DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);

which is rather a step backwards, because we need to keep that list updated
now, and we'll fail to catch new devices.

What happens if we just revert 75cf7456dd87335f574dcd53c4ae616a2ad71a11?

It says

    Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
    on my system which has no VIA southbridge (but I do have a VIA IEEE
    1394 device).

but so what?  Did anything actually go wrong?  Is it likely to go wrong in
the future?

Is there was a problem, is there something we can do at runtime in
quirk_via_irq() to avoid the problem, rather than expanding out the fixup
list in this manner?
