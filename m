Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVCRBZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVCRBZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVCRBVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:21:49 -0500
Received: from fmr19.intel.com ([134.134.136.18]:2440 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261418AbVCRBTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:19:23 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Li Shaohua <shaohua.li@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Grzegorz Kulewski <kangur@polcom.net>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <1111082914.11380.30.camel@eeyore>
References: <1110989436.8378.19.camel@eeyore>
	 <1111023217.15278.7.camel@sli10-desk.sh.intel.com>
	 <1111082914.11380.30.camel@eeyore>
Content-Type: text/plain
Message-Id: <1111108150.22239.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 18 Mar 2005 09:09:10 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 02:08, Bjorn Helgaas wrote:
> On Thu, 2005-03-17 at 09:33 +0800, Li Shaohua wrote:
> > The comments in previous quirk said it's required only in PIC mode.
> ...
> > I feel we concerned too much. Changing the interrupt line isn't harmful,
> > right? Linux actually ignored interrupt line. Maybe just a
> > PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq) is
> > sufficient.
> 
> I think it's good to limit the scope of the quirk as much as
> possible because that makes it easier to do future restructuring,
> such as device-specific interrupt routers.
> 
> The comment (before quirk_via_acpi(), nowhere near quirk_via_irqpic())
> says *on-chip devices* have this unusual behavior when the interrupt
> line is written.  That makes sense to me.
> 
> Writing the interrupt line on random plug-in Via PCI devices does
> not make sense to me, because for that to have any effect, an
> upstream bridge would have to be snooping the traffic going through
> it.  That doesn't sound plausible to me.
> 
> What about this:
Hmm, this looks like previous solution. We removed the specific via
quirk is because we don't know how many devices have such issue. Every
time we encounter an IRQ issue in a VIA PCI device, we will suspect it
requires quirk and keep try. This is a big overhead. 

Thanks,
Shaohua

