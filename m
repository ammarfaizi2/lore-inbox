Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVFIRTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVFIRTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVFIRTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:19:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60062 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262413AbVFIRTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:19:38 -0400
Date: Thu, 9 Jun 2005 18:20:35 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 03/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050609172035.GD24611@parcelfarce.linux.theplanet.co.uk>
References: <42A8386F.2060100@jp.fujitsu.com> <42A83B6D.8010703@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A83B6D.8010703@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 09:51:57PM +0900, Hidetoshi Seto wrote:
> +	switch (dev->hdr_type) {
> +	case PCI_HEADER_TYPE_NORMAL: /* 0 */
> +		pci_read_config_word(dev, PCI_STATUS, &status);
> +		break;
> +	case PCI_HEADER_TYPE_BRIDGE: /* 1 */
> +		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
> +		break;
> +	case PCI_HEADER_TYPE_CARDBUS: /* 2 */
> +	default:
> +		BUG();

If somebody plugs a cardbus card into an ia64 machine, we BUG()?
Unacceptable.  Just return 0 if you don't know what to do with a
particular device.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
