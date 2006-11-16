Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162021AbWKPSA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162021AbWKPSA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162073AbWKPSA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:00:29 -0500
Received: from mmail.enter.net ([216.193.128.40]:46298 "EHLO mmail.enter.net")
	by vger.kernel.org with ESMTP id S1162021AbWKPSA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:00:28 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Thu, 16 Nov 2006 13:00:26 -0500
User-Agent: KMail/1.9.5
Cc: "Olivier Nicolas" <olivn@trollprod.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Mws" <mws@twisted-brains.org>,
       "Jeff Garzik" <jeff@garzik.org>, "Krzysztof Halasa" <khc@pm.waw.pl>,
       "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
References: <5986589C150B2F49A46483AC44C7BCA4907209@ssvlexmb2.amd.com>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907209@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161300.27005.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 23:25, Lu, Yinghai wrote:
> I think the root cause in hda_intel driver's self.
>
> It gets io-apic irq initialized at first, and it will use
> azx_acquire_irq to install handler after check if MSI can be enabled.
> And when it try to enable the MSI, that will start the int in the chip.
> Even handler for MSI is not installed.
>
> YH

That seems rather stupid. Perhaps installing a conditional handler before 
doing anything with MSI will solve that problem... The problem then just 
revolves around replacing the conditional handler with the real one when MSI 
is fully enabled. If I understood the code for this driver better I'd try to 
make this work. As it stands I'm still trying to recover from the loss of the 
work I did on another project. (DRM based uniform kernel graphics interface - 
had a blackout here that caused my devel machine to crash and left me with a 
trashed drive)

DRH
