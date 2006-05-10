Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWEJKfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWEJKfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWEJKfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:35:42 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:31123 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964910AbWEJKfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:35:41 -0400
Date: Wed, 10 May 2006 11:35:20 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Message-ID: <20060510103520.GX7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <200605091831.37757.ak@suse.de> <20060509204207.GQ7834@cl.cam.ac.uk> <200605092356.28818.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605092356.28818.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:56:28PM +0200, Andi Kleen wrote:
> 
> > Everything[1] in line:
> > -rwxr-xr-x  1 cl349 cl349  2633640 May  9 19:42 vmlinux-inline-stripped
> > Everything out of line:
> > -rwxr-xr-x  1 cl349 cl349  2621352 May  9 19:45 vmlinux-outline-stripped
> > 
> > Additionally, I changed did a build with only __sti and __restore_flags
> > out of line and the others in line:
> > -rwxr-xr-x  1 cl349 cl349  2617256 May  9 19:50 vmlinux-hybrid-stripped
> > 
> > __sti and __restore_flags are the ones which generate more code,
> > so it seemed more sensible to make the out of line.
> > 
> > Any conlusions?
> 
> It looks like hybrid is a clear winner at least from the code size, isn't it?

Yes, which is why I measured that one as well.

Now, the original concern was that we have the five operations implemented
as multi-line macros and doing a hybrid solution doesn't really address
that.

Also, it's not quite clear to me what's the best way to turn three of
the five into functions, whether inline or not.

For measuring the sizes, I did the following:
add void ___restore_flags(unsigned long *x) with the implementation
and then:
#define __restore_flags(x) ___restore_flags(&(x))

Alternatively, would it make sense to change __restore_flags to take
a pointer to flags instead?  That would be quite an invasive change...

Any thoughts?

    christian

