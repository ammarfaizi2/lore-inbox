Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269152AbUJTXKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269152AbUJTXKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJTXFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:05:25 -0400
Received: from baikonur.stro.at ([213.239.196.228]:49887 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S269152AbUJTXB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:01:28 -0400
Date: Thu, 21 Oct 2004 01:01:28 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       sailer@ife.ee.ethz.ch, perex@suse.cz, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 cmipci.c] [8/8] Replace pci_find_device with pci_dev_present
Message-ID: <20041020230128.GB1953@stro.at>
References: <28440000.1096502897@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28440000.1096502897@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Hanna Linder wrote:

> 
> The pci_find_device function is going away so I have replace it with pci_dev_present.
> I also just used the macros it should have been using in the first place. I have compile tested it.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>
> 
> ---
> diff -Nrup linux-2.6.9-rc2-mm4cln/sound/pci/cmipci.c linux-2.6.9-rc2-mm4patch2/sound/pci/cmipci.c
> --- linux-2.6.9-rc2-mm4cln/sound/pci/cmipci.c	2004-09-12 22:32:55.000000000 -0700
> +++ linux-2.6.9-rc2-mm4patch2/sound/pci/cmipci.c	2004-09-29 16:32:30.000000000 -0700
> @@ -2573,6 +2573,10 @@ static int __devinit snd_cmipci_create(s
>  	long iomidi = mpu_port[dev];
>  	long iosynth = fm_port[dev];
>  	int pcm_index, pcm_spdif_index;
> +	static struct pci_device_id intel_82437vx[] = {
> +		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX) },
> +		{ },
> +	};
>  
>  	*rcmipci = NULL;
>  
> @@ -2648,8 +2652,7 @@ static int __devinit snd_cmipci_create(s
>  	switch (pci->device) {
>  	case PCI_DEVICE_ID_CMEDIA_CM8738:
>  	case PCI_DEVICE_ID_CMEDIA_CM8738B:
> -		/* PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX */
> -		if (! pci_find_device(0x8086, 0x7030, NULL))
> +		if (!pci_dev_present(intel_82437vx)) 
                                                    ^
>  			snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_TXVX);
>  		break;
>  	default:
> 
> 

a second one with small whitespace damage.
fixed for next kjt.

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

