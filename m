Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUBIUEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUBIUEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:04:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8454 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265350AbUBIUEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:04:51 -0500
Date: Mon, 9 Feb 2004 21:04:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Athol Mullen <me@privacy.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Message-ID: <20040209200427.GF29363@alpha.home.local>
References: <1mLsS-6Oq-7@gated-at.bofh.it> <1mLsS-6Oq-9@gated-at.bofh.it> <1mLsS-6Oq-5@gated-at.bofh.it> <1mRHV-4Xn-7@gated-at.bofh.it> <c06jlm$13ju4j$1@ID-215292.news.uni-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06jlm$13ju4j$1@ID-215292.news.uni-berlin.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 09, 2004 at 02:50:31AM +0000, Athol Mullen wrote:
 
> This patch inserts the piix code into eighty_ninty_three() - obviously
> this is for testing purposes only.  The patch was diff'd against 2.4.22,
> but patches okay to 2.6.1 with:
>     Hunk #1 succeeded at 719 (offset -10 lines).

OK, I will try it ASAP on 2.4.25-rc1.

BTW, are you sure that the trick is needed for all the chipsets below,
or should it be necessary only for some of them ? perhaps word93 is already
OK for a few ones ?

> +		switch(hwif->pci_dev->device) {
> +			case PCI_DEVICE_ID_INTEL_82801BA_8:
> +	    		case PCI_DEVICE_ID_INTEL_82801BA_9:
> +	    		case PCI_DEVICE_ID_INTEL_82801CA_10:
> +	    		case PCI_DEVICE_ID_INTEL_82801CA_11:
> +	    		case PCI_DEVICE_ID_INTEL_82801E_11:
> +	    		case PCI_DEVICE_ID_INTEL_82801DB_10:
> +			case PCI_DEVICE_ID_INTEL_82801DB_11:
> +			case PCI_DEVICE_ID_INTEL_82801EB_11:
> +			case PCI_DEVICE_ID_INTEL_82801AA_1:
> +			case PCI_DEVICE_ID_INTEL_82372FB_1:
> +			    {
> +			    pci_read_config_word(dev, 0x54, &reg54);
> +			    return ((reg54 & cr_flag) ? 1 : 0);
> +			    }
> +		}

Regards,
Willy

