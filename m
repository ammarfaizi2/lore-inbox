Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbUKZTPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbUKZTPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUKZTPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:15:36 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:739 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262220AbUKZTPJ
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:15:09 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second take)
Date: Fri, 26 Nov 2004 09:28:17 -0800
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, Linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
References: <20041126113021.135e79df@pirandello>
In-Reply-To: <20041126113021.135e79df@pirandello>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411260928.18135.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 November 2004 02:30, Colin Leroy wrote:
> @@ -375,6 +375,11 @@
>  		spin_unlock_irqrestore (&ohci->lock, flags);
>  		set_current_state (TASK_UNINTERRUPTIBLE);
>  		schedule_timeout (1);
> +		if (limit < 1000) {
> +			ohci_warn (ohci, "Can't recover, restarting.\n");
> +			ohci_restart(ohci);
> +			return;
> +		}

So instead of waiting a moment for the ED to finish
its normal processing and move from state ED_UNLINK
into ED_IDLE, you want to always clobber the whole
USB device tree attached to that bus?  That'd happen
quite routinely.

This isn't a good patch either... maybe your best
bet would be to find out why the IRQs stopped getting
delivered.

- Dave
