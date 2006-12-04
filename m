Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937318AbWLDTRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937318AbWLDTRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937320AbWLDTRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:17:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45497 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937318AbWLDTRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:17:33 -0500
Subject: Re: [PATCH] Export current_is_keventd() for libphy
From: Steve Fox <drfickle@linux.vnet.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, macro@linux-mips.org,
       afleming@freescale.com
In-Reply-To: <20061203011625.60268114.akpm@osdl.org>
References: <1165125055.5320.14.camel@gullible>
	 <20061203011625.60268114.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Dec 2006 13:17:16 -0600
Message-Id: <1165259836.23190.48.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 01:16 -0800, Andrew Morton wrote:
> On Sun, 03 Dec 2006 00:50:55 -0500
> Ben Collins <ben.collins@ubuntu.com> wrote:
> 
> > Fixes this problem when libphy is compiled as module:
> >
> > WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 17c2f03..1cf226b 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -608,6 +608,7 @@ int current_is_keventd(void)
> >  	return ret;
> >
> >  }
> > +EXPORT_SYMBOL_GPL(current_is_keventd);
> >
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  /* Take the work from this (downed) CPU. */
> 
> wtf?  That code was merged?  This bug has been known for months and after
> several unsuccessful attempts at trying to understand what on earth that
> hackery is supposed to be doing I gave up on it and asked Jeff to look after
> it.
> 
> Maciej, please, in very small words written in a very large font, explain to
> us what is going on in phy_stop_interrupts()?  Include pictures.

Unfortunately Maciej didn't get cc'ed correctly on your mail. Hopefully
I've added the right person to this post as well as Andy who has also
recently changed this code.

We're also hitting this on one of the test.kernel.org machines, bl6-13.

-- 

Steve Fox
IBM Linux Technology Center
