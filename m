Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVCKCWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVCKCWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVCKCWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:22:06 -0500
Received: from ozlabs.org ([203.10.76.45]:38628 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263089AbVCKCSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:18:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 13:18:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <20050311021248.GA20697@redhat.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<20050311021248.GA20697@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:

>  >  		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
>  > -		if (!cap_ptr) {
>  > -			pci_dev_put(device);
>  > -			continue;
>  > -		}
>  > -			cap_ptr = 0;
>  >  	}
> 
> This part I'm not so sure about.
> The pci_get_class() call a few lines above will get a refcount that
> we will now never release.

The point is that pci_get_class does a pci_dev_put() on the "from"
parameter, so your code ended up doing a double put.

> Unfortunatly, no-one with ppc64 tested it there it seems :-(

I have only recently got AGP and DRI working on my G5.  I'll post a
patch for AGP support on the G5 shortly.

Paul.
