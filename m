Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWDSQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWDSQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWDSQ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:26:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750995AbWDSQ0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:26:55 -0400
Date: Wed, 19 Apr 2006 09:26:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: James.Smart@Emulex.Com
Cc: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
Message-ID: <20060419092645.29cb0420@localhost.localdomain>
In-Reply-To: <444633B5.5030208@emulex.com>
References: <1145306661.4151.0.camel@localhost.localdomain>
	<20060418160121.GA2707@us.ibm.com>
	<444633B5.5030208@emulex.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006 08:57:25 -0400
James Smart <James.Smart@Emulex.Com> wrote:

> Folks,
> 
> To take netlink to where we want to use it within the SCSI subsystem (as
> the mechanism of choice to replace ioctls), we're going to need to pass
> user-space buffer pointers.

This changes the design of netlink. It is desired that netlink
can be done remotely over the network as well as queueing.
The current design is message based, not RPC based. By including a
user-space pointer, you are making the message dependent on the
context as it is process.

Please rethink your design.

> What is the best, portable manner to pass a pointer between user and kernel
> space within a netlink message ?  The example I've seen is in the iscsi
> target code - and it's passed between user-kernel space as a u64, then
> typecast to a void *, and later within the bio_map_xxx functions, as an
> unsigned long. I assume we are going to continue with this method ?
> 
> -- james s
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
