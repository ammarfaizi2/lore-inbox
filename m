Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWCVVuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWCVVuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbWCVVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:50:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932349AbWCVVuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:50:06 -0500
Date: Wed, 22 Mar 2006 13:46:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: kernel@kolivas.org, johnstul@us.ibm.com, andi@rhlx01.fht-esslingen.de,
       bert.hubert@netherlabs.nl, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not
 buggy
Message-Id: <20060322134633.46389249.akpm@osdl.org>
In-Reply-To: <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp>
	<200603221121.16168.kernel@kolivas.org>
	<87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> 
> ...
>
> This patch adds blacklist of buggy chip, and if chip is not buggy,
> this uses fast normal version instead of slow workaround version.
> 
> If chip is buggy, warnings "pmtmr is slow". But sounds like there is
> gray zone. I found the PIIX4 errata, but I couldn't find the ICH4
> errata.  But some motherboard seems to have problem.
> 
> So, if found a ICH4, also warnings, and uses a workaround version.  If
> user's ICH4 is good actually, user can specify the "pmtmr_good" boot
> parameter to use fast version.
> 
> ...
>
> +static int __init pmtmr_bug_check(void)
> +{
> +	static struct pci_device_id gray_list[] __initdata = {
> +		/* these chipsets may have bug. */
> +		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0) },
> +		{ },
> +	};
>
> ...
>
> +	dev = pci_get_device(PCI_VENDOR_ID_INTEL,
> +			     PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
>
> ...
>
> +device_initcall(pmtmr_bug_check);

Can this code use the PCI quirk infrastructure?
