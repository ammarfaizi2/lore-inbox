Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752162AbWCCCda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbWCCCda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCCCd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:33:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752162AbWCCCdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:33:16 -0500
Date: Thu, 2 Mar 2006 18:31:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH 13/15] EDAC: kobject/sysfs fixes
Message-Id: <20060302183153.452f93d9.akpm@osdl.org>
In-Reply-To: <200603021748.13853.dsp@llnl.gov>
References: <200603021748.13853.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> - After we unregister a kobject, wait for our kobject release method
>    to call complete().  This causes us to wait until the kobject
>    reference count reaches 0.  Otherwise, a task accessing the EDAC
>    sysfs interface can hold the reference count above 0 until after the
>    EDAC module has been unloaded.  When the reference count finally
>    drops to 0, this will result in an attempt to call our release
>    method inside the EDAC module after the module has already been
>    unloaded.

That's not really the way to do it.  If you have all the correct
module_get()s and try_module_get()s and module_put()s in all the right
places, kenrel/module.c:wait_for_zero_refcount() should do this for you.

