Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265150AbUELSUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUELSUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUELSUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:20:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:57225 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265160AbUELSTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:19:46 -0400
Date: Wed, 12 May 2004 11:19:03 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512181903.GG13421@kroah.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512020700.6f6aa61f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 02:07:00AM -0700, Andrew Morton wrote:
> drivers/usb/host/ehci.h:599: warning: `MSEC_TO_JIFFIES' redefined
> include/asm/param.h:9: warning: this is the location of the previous definition
> In file included from drivers/usb/host/ohci-hcd.c:127:
> drivers/usb/host/ohci.h:400: warning: `MSEC_TO_JIFFIES' redefined
> include/asm/param.h:9: warning: this is the location of the previous definition

Woah, that's new.  And wrong.  The code in include/asm-i386/param.h that
says:
	# define JIFFIES_TO_MSEC(x)     (x)
	# define MSEC_TO_JIFFIES(x)     (x)

Is not correct.  Look at kernel/sched.c for verification of this :)

Looks like we just messed with our carefully tuned scheduler...

We can blame the following changeset from Ingo:

	ChangeSet 1.1608.6.15 2004/05/10 13:26:09 akpm@osdl.org
	  [PATCH] sched: trivial fixes, cleanups
	  
	  From: Ingo Molnar <mingo@elte.hu>
	  
	  The trivial fixes.
	  
	  - added recent trivial bits from Nick's and my patches.
	  - hotplug CPU fix
	  - early init cleanup


thanks,

greg k-h
