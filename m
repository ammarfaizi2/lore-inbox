Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUFJBhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUFJBhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUFJBhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:37:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16865 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266063AbUFJBhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:37:35 -0400
Date: Thu, 10 Jun 2004 02:37:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Markus.Lidel@shadowconnect.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/message/i2o/i2o_config.c: user/kernel pointer bugs
Message-ID: <20040610013734.GZ12308@parcelfarce.linux.theplanet.co.uk>
References: <1086822062.32052.129.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086822062.32052.129.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 04:01:02PM -0700, Robert T. Johnson wrote:
> Since arg is a user pointer, accessing values like cmd->iop requires an 
> unsafe user pointer dereference.
> 
> QUESTION: Does ioctl_passthru mean arg is a kernel pointer?  If so, then
> disregard this bug report.

No - we have ->ioctl [== cfg_ioctl()] -> ioctl_passthru() chain in there,
so at the very least it can get arbitrary pointers straight from userland.

And yes, these cmd->iop and cmd->msg dereferences are broken.

> +	if (copy_from_user(&cmd, (void *)arg, sizeof(cmd)))
> +	  return -EFAULT;

Fix the indentation, please.

> -	memset(&msg, 0, MSG_FRAME_SIZE*4);
> +	memset(msg, 0, MSG_FRAME_SIZE*4);

Not needed; they are equivalent and both legitimate.  So that just clutters
the patch.

> -		memset(&msg, 0, MSG_FRAME_SIZE*4);
> +		memset(msg, 0, MSG_FRAME_SIZE*4);

Ditto.
