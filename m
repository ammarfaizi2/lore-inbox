Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVJCVYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVJCVYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVJCVYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:24:14 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:52829 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964780AbVJCVYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:24:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=F/6BVJcru6BW5jCsMk4CCOGkdYMFuygAWeE1FGxvT2ZPMlfYl9Q8+gpy7PwIiJVNNzbin2oBLMk9KmgzBKIDCpRxND/Hrj+xmSARbShoIkIwfWt1mlyVOFalhkqVVYDGIxNT/WQFJUb8w2EtL+7imTocnezVnHwZ0k8iuv5TcYI=
Date: Tue, 4 Oct 2005 01:34:30 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linas <linas@austin.ibm.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       johnrose@austin.ibm.com
Subject: Re: [PATCH] ppc64: Crash in DLPAR code on PCI hotplug add
Message-ID: <20051003213430.GD7554@mipter.zuzino.mipt.ru>
References: <20051003185739.GR29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003185739.GR29826@austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 01:57:39PM -0500, linas wrote:
> The root cause was that the phb was not marked "dynamic", and so instead
> of having kmalloc() being called, the __init __alloc_bootmem() was called,
> resulting in access of garage data.  The patch below fixes this crash,
> and adds some docs to clarify the code.

> +/** pci_devs_phb_init_dynamic -- setup pci devices under this PHB
> + *
> + * This routine is called both during boot, (before the memory
> + * subsystem is set up, before kmalloc is valid) and during the 
> + * dynamic lpar operation of adding a PHB to a running system.
> + */
>  void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)

Please, add docs in a proper way:

	/**
	 * foo - bar
	 * a: b
	 *
	 * Does bar.
	 */

