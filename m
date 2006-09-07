Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWIGLUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWIGLUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIGLUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:20:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:11301 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751697AbWIGLUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:20:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ogiM/jn8S1MhSwBuUqthjerpHjom4n7HibSAx+GErDrwRCwgu0f3B4gRVMcUM6jLtjdy8KYZ1SwGX/8eC09y6Rh+r2SKVDKCz9bSePMXyIlcxRP2TL8u2CtyCMC+ZuQusH+PAd8sVGNblK/B9LzC2cRwIhab4nfKlgKvXC1iVQU=
Message-ID: <45000076.4070005@gmail.com>
Date: Thu, 07 Sep 2006 13:20:22 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org>
In-Reply-To: <20060907111120.GL2558@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Just call pci_set_mwi(), that'll make sure the cache line size is set
> correctly.

Sounds simple enough.  Just two small worries though.

* It has an apparent side effect of setting PCI_COMMAND_INVALIDATE, 
which should be okay in sil3124's case.

* The controller might have some restrictions on configurable cache line 
size.  This is the same for MWI, so I guess this problem is just imaginary.

For the time being, I'll go with pci_set_mwi() but IMHO it would be 
better to have a pci helper for this purpose - 
pci_config_cacheline_size() or something.

Thanks.

-- 
tejun
