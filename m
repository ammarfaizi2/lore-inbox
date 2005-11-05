Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVKEGLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVKEGLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 01:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVKEGLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 01:11:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:5331 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751250AbVKEGLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 01:11:50 -0500
Date: Fri, 4 Nov 2005 22:11:14 -0800
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051105061114.GA27016@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104005035.GA26929@mail.gnucash.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 06:50:35PM -0600, Linas Vepstas wrote:
> +/* ---------------------------------------------------------------- */
> +/** PCI error recovery infrastructure.  If a PCI device driver provides
> + *  a set fof callbacks in struct pci_error_handlers, then that device driver
> + *  will be notified of PCI bus errors, and will be driven to recovery
> + *  when an error occurs.
> + */
> +
> +enum pcierr_result {
> +	PCIERR_RESULT_NONE=0,        /* no result/none/not supported in device driver */
> +	PCIERR_RESULT_CAN_RECOVER=1, /* Device driver can recover without slot reset */
> +	PCIERR_RESULT_NEED_RESET,    /* Device driver wants slot to be reset. */
> +	PCIERR_RESULT_DISCONNECT,    /* Device has completely failed, is unrecoverable */
> +	PCIERR_RESULT_RECOVERED,     /* Device driver is fully recovered and operational */
> +};

No, do not create new types of error or return codes.  Use the standard
-EFOO values.  You can document what they should each return, and mean,
but do not create new codes.

Also, you create an enum, but yet do not use it in your function
callback definition, which means you really didn't want to create it in
the first place...

I'll add 15 and 16 to my tree for now, so they will show up in -mm, but
I want to see updated versions before sending them off to Linus.

thanks,

greg k-h
