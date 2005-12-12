Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVLLU0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVLLU0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVLLU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:26:47 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:21904 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750936AbVLLU0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:26:47 -0500
Date: Mon, 12 Dec 2005 13:26:43 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ak@muc.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 2/4] i386/x86-64: Implement fallback for PCI mmconfig to type1
Message-ID: <20051212202643.GG9286@parisc-linux.org>
References: <20051212192030.873030000@press.kroah.org> <20051212200123.GC27657@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212200123.GC27657@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 12:01:23PM -0800, Greg Kroah-Hartman wrote:
> When there is no entry for a bus in MCFG fall back to type1.  This is
> especially important on K8 systems where always some devices can't be
> accessed using mmconfig (in particular the builtin northbridge doesn't
> support it for its own devices)
[...]
> -static int pci_conf1_read(unsigned int seg, unsigned int bus,
> +int pci_conf1_read(unsigned int seg, unsigned int bus,

I don't like this at all.  We already have a mechanism to use different
accessors per-bus (bus->ops->read()); calling the type1 accessors from
the mmconfig accessors just seems wrong.

> +	if (!base)
> +		return pci_conf1_read(seg,bus,devfn,reg,len,value);

Should be space after commas.

