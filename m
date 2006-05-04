Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWEDJog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWEDJog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWEDJog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:44:36 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:44237 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751468AbWEDJof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:44:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LquUfSEHzYz1jdyqDyL1T6mBrMm+F2XZzi2HPrrnB0oWBPIlWGbzpt6e0VegpnZMCUd4yc3ax+U0wL+kRR4qNZj7PFSDB5ja9xJY52vm+KZDfuHFMliYbXglpfHePovR5Ck7852wbLwVsrbT+cXXDJ/3TXOr/hrBqWZcrjGGtoM=
Message-ID: <4459CCF5.9080106@gmail.com>
Date: Thu, 04 May 2006 17:44:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Rajesh Shah <rajesh.shah@intel.com>, gregkh@suse.de, ak@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i386/x86_84: disable PCI resource decode on device disable
References: <20060503152747.A29327@unix-os.sc.intel.com> <21d7e9970605032016w2a092ce9qb2bff38e739bca5@mail.gmail.com>
In-Reply-To: <21d7e9970605032016w2a092ce9qb2bff38e739bca5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
>>
>> When a PCI device is disabled via pci_disable_device(), it's still
>> left decoding its BAR resource ranges even though its driver
>> will have likely released those regions (and may even have
>> unloaded). pci_enable_device() already explicitly enables
>> BAR resource decode for the device being enabled. This patch
>> disables resource decode for the PCI device being disabled,
>> making it symmetric with the enable call.
>>
>> I saw this while doing something else, not because of a
>> problem report. Still, seems to be the correct thing to do.
> 
> I'm just wondering how this will react with VGA devices being run by
> fbdev or the drm, I know the DRM never calls pci_disable_device, as
> the card might require the bars enabled so it can do VGA, and which if
> it is your primary VGA card, can cause you all kinds of troubles...
> (like losing text mode)..

Most, if not all PCI-based framebuffer drivers call pci_disable_device()
in their unload routine. Although it's very rare that framebuffer drivers
are unloaded, if you do, and the the resources are also disabled, it will
kill the VGA core of the card.  You lose your text console and even
hang the machine.

> 
> Alan Cox mentioned this somewhere before in relation to video cards..

Alan Cox, if I remember correctly, advises against calling pci_disable_device()
for video drivers when they unload.

Tony
 

