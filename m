Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWE0IHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWE0IHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 04:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWE0IHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 04:07:21 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:4249 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S1751445AbWE0IHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 04:07:19 -0400
Message-ID: <447808A2.2050709@myri.com>
Date: Sat, 27 May 2006 10:06:58 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, tom.l.nguyen@intel.com
Subject: Re: [RFC]disable msi mode in pci_disable_device
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com> <20060526125440.0897aef5.akpm@osdl.org> <44776491.1080506@myri.com> <20060526161043.A16912@unix-os.sc.intel.com>
In-Reply-To: <20060526161043.A16912@unix-os.sc.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah wrote:
> On Fri, May 26, 2006 at 10:26:57PM +0200, Brice Goglin wrote:
>   
>> I just tried, the patch fixes our problem (no need to restore right
>> after saving to reenable MSI).
>>
>>     
> Yeah, I agree this latest patch from Shaohua is the right thing,
> and that pci save/restore msi state functions should not have
> the side effect of disabling/enabling MSI. Shaohua, do drivers
> already call pci_disable_device() or will you have to patch
> them all to get the disable effect?
>   

We would have to patch if we knew that disabling was required. But these
drivers that do not call pci_disable_device (for instance tg3 and bnx2)
were already working before pci_save_msi_state was added by Shaohua in
2.6.17-rc:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=41017f0cac925e4a6bcf3359b75e5538112d4216
So they were working without any PCI core function disabling MSI for
them during suspend.

For these drivers, it might be a regression against 2.6.17-rc, but not
against 2.6.16. I'd say it's fine.

Brice

