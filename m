Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWFTNWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWFTNWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWFTNWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:22:19 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43703 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750797AbWFTNWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:22:18 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.2
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB
	issues]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Johny <kernel@agotnes.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20060620044003.4287426d.akpm@osdl.org>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 20 Jun 2006 14:22:04 +0100
Message-Id: <1150809726.7194.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

In first thread of this issue in LKML, some months ago, (right now, I
don't have the link). 
After some discussion, someone arrive the conclusion of that: 
You only need this quirks, if interrupts are in XT-PIC mode and is
harmless if don't (and "should only run for VIA southbridges"). So if
you are in XT-PIC mode, it is more probability that patch -R in
question, have some affect.
cat /proc/interrupts 
give you: IO-APIC-... or XT-PIC ?

and what PCI_IDs do you have ? (lspci -n)

Other issue, you can't revert this patch cleanly because after that we
have other patch that adds some more IDs. So just delete any declare of
PCI_DEVICE_ID_VIA_82C... and add one declare with PCI_ANY_ID

Thanks,
Sérgio M. B.

On Tue, 2006-06-20 at 04:40 -0700, Andrew Morton wrote:
> You could try a `patch -R' of the below.
> 
> commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11
> Author: Chris Wedgwood <cw@f00f.org>
> Date:   Tue Apr 18 23:57:09 2006 -0700 

