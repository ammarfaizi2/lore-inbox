Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVKGViB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVKGViB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbVKGViB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:38:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:26063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965245AbVKGVh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:37:59 -0500
Date: Mon, 7 Nov 2005 13:37:29 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>, linux-sparse@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7]: PCI revised (2) [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051107213729.GA24700@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com> <20051107200352.GB22524@kroah.com> <20051107212128.GH19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107212128.GH19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:21:28PM -0600, linas wrote:
> +typedef int __bitwise pci_channel_state_t;

Closer but...

>  enum pci_channel_state {
> -	pci_channel_io_normal = 0,	/* I/O channel is in normal state */
> -	pci_channel_io_frozen = 1,	/* I/O to channel is blocked */
> -	pci_channel_io_perm_failure,	/* PCI card is dead */
> +	pci_channel_io_normal = (__force pci_channel_state_t) 0,	/* I/O channel is in normal state */
> +	pci_channel_io_frozen = (__force pci_channel_state_t) 1,	/* I/O to channel is blocked */
> +	pci_channel_io_perm_failure = (__force pci_channel_state_t) 2,	/* PCI card is dead */
>  };

You don't have to use an enum anymore, just use a #define.

Sparse developers, I see code in the kernel that that does both 
(__force foo_t) and (foo_t __force).  Which one is correct?


> +typedef int __bitwise pers_result_t;

Ugh, I don't like that name, but I can't think of anything better right
now.  You should at least keep "pci" at the beginning to make it make
more sense to people looking at it for the first time.

thanks,

greg k-h
