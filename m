Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbWCRB7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWCRB7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbWCRB7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:59:16 -0500
Received: from sccrmhc12.comcast.net ([204.127.200.82]:1943 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932757AbWCRB7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:59:16 -0500
Date: Fri, 17 Mar 2006 20:59:32 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, ericvh@hera.kernel.org,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Subject: Re: [V9fs-developer] Re: [RESEND][PATCH] v9fs: print v9fs module address
Message-ID: <20060318015932.GA2121@ionkov.net>
References: <200603171909.k2HJ9BiD006068@hera.kernel.org> <20060317194113.GA8848@infradead.org> <20060317130311.0477454f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317130311.0477454f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it looks like funciton_name+0xoffset is enough for debugging. We can
even calculate the module address if we need it.

You can ignore the patch.

Thanks,
	Lucho

On Fri, Mar 17, 2006 at 01:03:11PM -0800, Andrew Morton said:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Mar 17, 2006 at 07:09:14PM +0000, Eric Van Hensbergen wrote:
> >  > Subject: [PATCH] print v9fs module address
> >  > From: Latchesar Ionkov <lucho@ionkov.net>
> >  > Date: 1141313037 -0500
> >  > 
> >  > This patch prints v9fs module address when the module is initialized. It is
> >  > useful to have it in the logs -- if the kernel crashes the address can be
> >  > used together with the oops print to find out the exact place (presumably in
> >  > the v9fs code) that cause the oops.
> > 
> >  NACK.
> > 
> >  This just clutters the log.  The information is provided in /proc/modules
> >  for all modules.
> 
> But it's not printed out in an oops record and it can be hard to read
> /proc/modules when the kernel is dead.
> 
> That being said...
> 
> If we really want this info then it should be printed out by the oops code,
> where it prints the names of all the loaded modules - add "(0xc0123456)"
> after each module name.
> 
> But I can't say I've ever felt a need for this feature - the symbolic info
> in the oops trace tells you function_name+0xoffset/0xsize [*] which is
> sufficient info for debugging.
> 
> IOW: what's the use case here, Eric?
> 
> 
> 
> [*] unless it's x86_64, which randomly prints some of these things in
>     decimal or sanskrit or something.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
