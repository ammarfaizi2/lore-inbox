Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWEIMsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWEIMsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWEIMsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:48:53 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:7567 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932488AbWEIMsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:48:53 -0400
Date: Tue, 9 May 2006 13:45:40 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Message-ID: <20060509124540.GB5407@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org> <20060509100547.GL3570@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509100547.GL3570@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:05:47PM +0200, Adrian Bunk wrote:
> On Tue, May 09, 2006 at 12:00:01AM -0700, Chris Wright wrote:
> > --- linus-2.6.orig/kernel/Kconfig.hz
> > +++ linus-2.6/kernel/Kconfig.hz
> > @@ -3,7 +3,7 @@
> >  #
> >  
> >  choice
> > -	prompt "Timer frequency"
> > +	prompt "Timer frequency" if !XEN
> >  	default HZ_250
> >  	help
> >  	 Allows the configuration of the timer frequency. It is customary
> > @@ -40,7 +40,7 @@ endchoice
> >  
> >  config HZ
> >  	int
> > -	default 100 if HZ_100
> > +	default 100 if HZ_100 || XEN
> >  	default 250 if HZ_250
> >  	default 1000 if HZ_1000
> >...
> 
> Why?

Because the hypervisor sends timer interrupts to the guest at a rate
of 100 Hz while the guest is running.  We might add support to have
an adjustable rate in the future but so far 100 Hz has worked quite
well for us.

    christian

