Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVERFuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVERFuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVERFuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:50:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:23952 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262100AbVERFuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:50:16 -0400
Date: Tue, 17 May 2005 22:56:02 -0700
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Kay Sievers <Kay.Sievers@vrfy.org>
Subject: Re: [PATCH] fix error handling in bus_add_device
Message-ID: <20050518055602.GA11123@kroah.com>
References: <428365EC.80906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428365EC.80906@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 04:19:24PM +0200, Hannes Reinecke wrote:
> Hi Greg,
> 
> this patch fixes the error handling in bus_add_device() and
> device_attach(). Previously it was 'interesting'.
> And totally confusing to boot.

I agree, that's why it has been rewritten in the -mm tree :)

Anyway, your patch doesn't take into account that device_attach()'s
return value is tested in the bus_rescan_devices_helper(), so if you
change the return value, that also needs to be changed.

But even in the -mm tree, the bus_add_devices() function has not had the
error handling added to it that you provided, is there any devices that
you are seeing that need this?

thanks,

greg k-h
