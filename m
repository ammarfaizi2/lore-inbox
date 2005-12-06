Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVLFTlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVLFTlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVLFTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:41:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:54948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030212AbVLFTlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:41:08 -0500
Date: Tue, 6 Dec 2005 11:40:41 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051206194041.GA22890@suse.de>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:56:10AM -0200, Luiz Fernando Capitulino wrote:
>  Greg,
> 
>  Don't get scared. :-)
> 
>  As showed by Eduardo Habkost some days ago, the spin lock 'lock' in the
> struct 'usb_serial_port' is being used by some USB serial drivers to protect
> the access to the 'write_urb_busy' member of the same struct.
> 
>  The spin lock however, is needless: we can change 'write_urb_busy' type
> to be atomic_t and remove all the spin lock usage.

But if you do that, you make things slower on non-smp machines, which
isn't very nice.  Why does the spinlock bother you?

thanks,

greg k-h
