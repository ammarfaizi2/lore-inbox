Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbUKDSN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbUKDSN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUKDSKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:10:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:63136 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262357AbUKDSGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:06:19 -0500
Date: Thu, 4 Nov 2004 10:05:50 -0800
From: Greg KH <greg@kroah.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com,
       herbert@gondor.apana.org.au, rml@ximian.com,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: netlink vs kobject_uevent ordering
Message-ID: <20041104180550.GA16744@kroah.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 02:43:17AM +1100, Anton Blanchard wrote:
> 
> Hi,
> 
> I noticed kobject_uevent was failing to init on my box. It looks like
> both netlink and kobject_uevent are marked core_initcall and we may not
> do them in the correct order.
> 
> I guess the recent changes to netlink caused this:
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@41896b1dIiNgXpwhgimeurIqPpofbw?nav=index.html|ChangeSet@-2d

Hm, I don't think that patch caused the reversal, it seems like we've
always linked this in the opposite order as my System.map before this
patch went in shows:
	c04b016c t __initcall_kobject_uevent_init
	c04b0170 t __initcall_netlink_proto_init

So, Robert and Kay, any thoughts as to how this has ever worked at boot
time in the past?

thanks,

greg k-h
