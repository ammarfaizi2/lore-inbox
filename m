Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWE3N0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWE3N0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWE3N0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:26:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:20130 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751497AbWE3N0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:26:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rxo95GTtxhWQ/s/FZH2Lf/m9aTeGkqFPBYSwHE4ZJ68YKsCA6YmEiiase82XFDJoGoI58oSddczXwxlaYRjunApBS+h/UrZ/lLUgyJxYIWIiq7EUnRJOymwmzk2WVTe9NypbEojw507Tv0bKhQb8B6Pjwxe5IqyflUYFJqPj8aM=
Message-ID: <20f65d530605300626q33b420bfn1536aee2ce83b46c@mail.gmail.com>
Date: Wed, 31 May 2006 01:26:50 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "James Courtier-Dutton" <James@superbug.co.uk>
Subject: Re: IO APIC IRQ assignment
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <447C3B3D.10705@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <447C3B3D.10705@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You could try enabling "Bus Options" ->
> [*]   Message Signaled Interrupts (MSI and MSI-X)
>
> or in .config
> CONFIG_PCI_MSI=y
>
> It only works for PCI devices.
>

Yes, the 2 devices are PCI devices. We tried enabling CONFIG_PCI_MSI,
also tried pci=routeirq, but cat /proc/interrupts still show the
devices sharing the same IRQ. It is interesting how each of these
options (ie routeirq, CONFIG_PCI_MSI, noacpi, etc) causes the kernel
to assign a different IRQ each time, but the 2 devices are always
shared, eg

pci=noacpi -> 169: 5140 IO-APIC-level bttv0, uhci_hcd:usb1
pci=routeirq -> 153: 1253 IO-APIC-level bttv0, uhci_hcd:usb1

I guess there's no workaround for our problem. If there are any more
suggestions, please let me know, we hope the pci latency settings will
get us going for now.

Regards
Keith
