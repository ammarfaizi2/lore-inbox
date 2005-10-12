Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVJLJwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVJLJwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJLJwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:52:47 -0400
Received: from ozlabs.org ([203.10.76.45]:42469 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751348AbVJLJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:52:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17228.56384.469138.175618@cargo.ozlabs.ibm.com>
Date: Wed, 12 Oct 2005 19:49:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas <linas@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 15/22] ppc64: PCI Error Recovery: PPC64 core recovery routines
In-Reply-To: <20051006234742.GP29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
	<20051006234742.GP29826@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas writes:

> +	/* We might not have a pci device, if it was a config space read
> +	 * that failed.  Find the pci device now.  */
> +	if (!dev) {
> +		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> +			if (pci_device_to_OF_node(dev) == event->dn)
> +				break;
> +		}
> +	}

Couldn't we just use PCI_DN(event->dn)->pcidev here?  Is there some
reason why this would not work in some circumstances?  It would be
nice to avoid this linear search.

Paul.
