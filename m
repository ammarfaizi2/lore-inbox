Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWCHCqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWCHCqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWCHCqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:46:45 -0500
Received: from ozlabs.org ([203.10.76.45]:37538 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932329AbWCHCqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:46:45 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, greg@kroah.com, dsp@llnl.gov,
       arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060307024113.103bbf1c.akpm@osdl.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com>
	 <200603061301.37923.dsp@llnl.gov> <20060306213203.GJ27946@ftp.linux.org.uk>
	 <20060306215344.GB16825@kroah.com>
	 <20060306222400.GK27946@ftp.linux.org.uk>
	 <20060307024113.103bbf1c.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 13:46:54 +1100
Message-Id: <1141786014.5032.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 02:41 -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > On Mon, Mar 06, 2006 at 01:53:44PM -0800, Greg KH wrote:
> >  > > 	rmmod your_turd </sys/spew/from/your_turd
> >  > > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
> >  > 
> >  > To be fair, the only part of the kernel that supports the above process,
> >  > is the network stack.  And they implemented a special kind of lock to
> >  > handle just this kind of thing.
> >  > 
> >  > That is not something that I want the rest of the kernel to have to use.
> >  > If your code blocks when doing the above thing, that's fine with me.
> > 
> >  One word: fail.  With -EBUSY.
> 
> It seems quite simple to make wait_for_zero_refcount() interruptible? 
> Something like...

Al is correct.

It would have been so simple to implement rmmod as blocking, but it
seems that not what people want.  They want modprobe -r to fail if the
module is busy, without ever causing spurious failures.

Hope that clarifies?
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

