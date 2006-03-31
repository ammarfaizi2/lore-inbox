Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWCaFvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWCaFvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWCaFvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:51:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:58851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750921AbWCaFvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:51:45 -0500
Date: Thu, 30 Mar 2006 21:46:54 -0800
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during reset.
Message-ID: <20060331054654.GA6632@kroah.com>
References: <20060330213928.GQ2172@austin.ibm.com> <20060331000208.GS2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331000208.GS2172@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 06:02:08PM -0600, Linas Vepstas wrote:
> -	/* Prevent stats update while adapter is being reset */
> +	/* Prevent stats update while adapter is being reset,
> +	 * or if the pci connection is down. */
>  	if (adapter->link_speed == 0)
>  		return;
> +   if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +		return;

Coding style is still wrong here :(

(hint, use a tab...)

thanks,

greg k-h
