Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUEMMLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUEMMLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUEMMLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:11:17 -0400
Received: from main.gmane.org ([80.91.224.249]:46295 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264160AbUEMMLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:11:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: 2.6.6-mm-rc3-mm2 USB 2.0 after suspend issue
Date: Thu, 13 May 2004 08:11:13 -0400
Message-ID: <c7voku$jh8$1@sea.gmane.org>
References: <20040513032736.40651f8e.akpm@osdl.org> <40A353A0.9060907@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <40A353A0.9060907@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That reminds me, I seem to be having problems with EHCI in 2.6.6-rc3-mm2 
after a resume. With this: "0000:00:1d.7 USB Controller: Intel Corp. 
82801DB (ICH4) USB2 EHCI Controller (rev 01)" if I suspend & resume with 
APM, then plug in a USB 2.0 device, it won't work at all until I "rmmod 
ehci_hcd; modprobe ehci_hcd". I'd imagine it has something to do with 
these messages:
uhci_hcd 0000:00:1d.1: suspend_hc
ehci_hcd 0000:00:1d.7: suspend D0 --> D3
ehci_hcd 0000:00:1d.7: No PM capability
uhci_hcd 0000:00:1d.2: suspend D4 --> D3
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.1: suspend D4 --> D3
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.0: suspend D4 --> D3
uhci_hcd 0000:00:1d.0: suspend_hc
uhci_hcd 0000:00:1d.0: resume from state D4
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.1: resume from state D4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.2: resume from state D4
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ehci_hcd 0000:00:1d.7: resume from state D0
ehci_hcd 0000:00:1d.7: can't resume, not suspended!

Granted, this isn't a huge problem because I can easily work around it 
by reloading the ehci_hcd module. But it's still a little annoying. It 
doesn't look like this has changed as of 2.6.6-mm2 either.

Prakash K. Cheemplavam wrote:
> Please look at the end of dmesg output.
> 
> There appear lines like
> 
> usb usb2: string descriptor 0 read error: -108
> 
> bug or feature? They weren't there with 2.6.6-mm1. I have no usb2.0 
> stuff to actually test. My usb1 stuff seems to work though.
> 
> Prakash

