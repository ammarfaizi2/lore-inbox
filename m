Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWEILFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWEILFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWEILFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:05:22 -0400
Received: from mail.aei.ca ([206.123.6.14]:60923 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751411AbWEILFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:05:21 -0400
From: Ed Tomlinson <edt@aei.ca>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Date: Tue, 9 May 2006 07:06:48 -0400
User-Agent: KMail/1.8.3
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org> <20060509100547.GL3570@stusta.de>
In-Reply-To: <20060509100547.GL3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605090706.49780.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 06:05, Adrian Bunk wrote:
> On Tue, May 09, 2006 at 12:00:01AM -0700, Chris Wright wrote:
> >...
> > --- linus-2.6.orig/arch/i386/Kconfig
> > +++ linus-2.6/arch/i386/Kconfig
> >...
> >  config X86_IO_APIC
> >  	bool
> > -	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
> > +	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER || X86_XEN))
> >  	default y
> >...
> 
> <nitpick>not required</nitpick>
> 
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

Guessing, but its probably to limit the number of parahypervisor calls.

Ed Tomlinson
