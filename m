Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269702AbUINUSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbUINUSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUINTXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:23:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:32206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269730AbUINTMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:12:41 -0400
Date: Tue, 14 Sep 2004 11:55:31 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Patch for 3 ub bugs in 2.6.9-rc1-mm4
Message-ID: <20040914185531.GB20942@kroah.com>
References: <20040911202525.1fd6c206@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911202525.1fd6c206@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 08:25:25PM -0700, Pete Zaitcev wrote:
> Hi, Greg,
> 
> Actual users of ub quickly found problems, so here's a patch to address
> some of them.
> 
> #1: An attempt to mount a CF card, pull the plug, then unmount causes a
> message "getblk: bad sector size 512" and an oops. This is caused by
> trying to do put_disk from disconnect instead of using a reference count.
> The sd.c does it this way (it uses kref).
> 
> #2: The hald fills /var/log/messages with block device errors. It seems
> that it happens because ub allowed opens of known offline devices, and
> then partition checking produced those errors. I hope taking code from
> sd.c should fix it.
> 
> Also I replaced usb_unlink_urb with usb_kill_urb.

Applied, thanks.

(oops, you forgot the Signed-off-by: line...)

greg k-h
