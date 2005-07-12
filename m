Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVGLAVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVGLAVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGLAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:21:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:50609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262294AbVGLAU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:20:29 -0400
Date: Mon, 11 Jul 2005 17:20:12 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Use device_for_each_child() to unregister devices in scsi_remove_target().
Message-ID: <20050712002011.GA9331@kroah.com>
References: <11193083662356@kroah.com> <11193083663269@kroah.com> <20050706003850.GA11542@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706003850.GA11542@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 05:38:50PM -0700, Patrick Mansfield wrote:
> Hi Greg / Patrick -
> 
> I'm getting an oops with current (pulled today) 2.6 git, the
> device_for_each_child() does not seem to be deletion safe.
> 
> We hold the klist in place via the n_ref, but the kobj (in the struct
> device for the struct scsi_target) containing it is freed when the
> kref->refcount goes to zero.

But we grab a reference to that object right before we call
device_for_each_child(), right?  Or am I missing something here?

thanks,

greg k-h
