Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbUK0EOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUK0EOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUK0EMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:12:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:30657 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262238AbUKZTQa (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:16:30 -0500
Date: Fri, 26 Nov 2004 18:37:49 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Colin Leroy <colin@colino.net>,
       Linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second
 take)
Message-ID: <20041126183749.1a230af9@jack.colino.net>
In-Reply-To: <200411260928.18135.david-b@pacbell.net>
References: <20041126113021.135e79df@pirandello>
	<200411260928.18135.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs172.1 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2004 at 09h11, David Brownell wrote:

Hi, 

> So instead of waiting a moment for the ED to finish
> its normal processing and move from state ED_UNLINK
> into ED_IDLE, you want to always clobber the whole
> USB device tree attached to that bus?  That'd happen
> quite routinely.

Yeah. Sorry. Also, just noticed that this patch seemed
to work because I overlooked the unsigned bit, makeing my
hack not go though sanitize - which changes eb->state and 
thus does not get back to the ED_UNLINK path. Duh... I must
have been tired.
 
> This isn't a good patch either... maybe your best
> bet would be to find out why the IRQs stopped getting
> delivered.

It's probably a linux-wlan-ng issue... What do you think 
of these logs ?

#resume logs... 
#disconnecting the stick:
usb 4-1: USB disconnect, address 2
ohci_hcd 0001:10:1b.1: IRQ INTR_SF lossage
hfa384x_usbin_callback: Fatal, failed to resubmit rx_urb. error=-19
hfa384x_dorrid: ctlx failure=REQ_TIMEOUT
prism2sta_mlmerequest: Failed to read eth1 statistics: error=-5
#reconnecting the stick:
usb 4-1: new full speed USB device using address 3
usb 4-1: control timeout on ep0out

maybe the lwlan driver should catch these and kill the urbs or
something? 
Thanks for your help, I'm not an expert at all in the usb world...
-- 
Colin
