Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbVJYHCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVJYHCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbVJYHCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:02:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:11665 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751475AbVJYHCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:02:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <435DD86F.3090702@s5r6.in-berlin.de>
Date: Tue, 25 Oct 2005 09:02:07 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, rob@janerob.com, akpm@osdl.org
Subject: Re: [PATCH] ohci1394 PCI fixup for Toshiba laptops
References: <200510241857.33257.jbarnes@virtuousgeek.org>
In-Reply-To: <200510241857.33257.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.084) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> +static void __devinit pci_post_fixup_toshiba_ohci1394(struct pci_dev *dev)
> +{
> +	if (dmi_check_system(toshiba_ohci1394_dmi_table))
> +		return; /* only applies to certain Toshibas (so far) */
> +
> +	/* Restore config space on Toshiba laptops */
> +	mdelay(10);
> +	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_line_size);

Shouldn't this read

         if (!dmi_check_system(toshiba_ohci1394_dmi_table))
                 return;
             ^ ?

dmi_check_system returns the number of matches.
-- 
Stefan Richter
-=====-=-=-= =-=- ==--=
http://arcgraph.de/sr/
