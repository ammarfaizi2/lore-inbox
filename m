Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUKYBSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUKYBSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUKYBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:16:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16014 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262909AbUKYBOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:14:55 -0500
Subject: Re: Suspend 2 merge: 26/51: Kconfig and makefile.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411241718400.1284@scrub.home>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296580.5805.292.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411241718400.1284@scrub.home>
Content-Type: text/plain
Message-Id: <1101330674.3895.30.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:11:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:34, Roman Zippel wrote:
> Hi,
> 
> On Wed, 24 Nov 2004, Nigel Cunningham wrote:
> 
> > +menu "Software Suspend 2"
> > +
> > +config SOFTWARE_SUSPEND2_CORE
> > +	tristate "Software Suspend 2"
> > +	depends on PM
> > +	select SOFTWARE_SUSPEND2
> > +	---help---
> > +	  Software Suspend 2 is the 'new and improved' suspend support. You
> > +	  can now build it as modules, but be aware that this requires
> > +	  initrd support (the modules you use in saving the image have to
> > +	  be loaded in order for you to be able to resume!)
> > +	  
> > +	  See the Software Suspend home page (softwaresuspend.berlios.de)
> > +	  for FAQs, HOWTOs and other documentation.
> > +
> > +	config SOFTWARE_SUSPEND2
> > +	bool
> > +
> > +	if SOFTWARE_SUSPEND2
> > +		config SOFTWARE_SUSPEND2_WRITER
> > +		bool
> > +
> 
> Please don't use such indentations.

I'm not sure exactly what 'such indentations' means. Could you please
give me a pointer to how it should look (I was blindly following what I
thought was the pattern to follow and will happily follow something else
:>).

> There is no need to use to select here either. If you really want to make 
> it modular (and you can convince Christoph), you want to do something like 
> this:

Okay. I've struggled a bit with the config language, and again looked to
other places to see how to achieve things. I've obviously missed better
code. Will give this a try.

Thanks very much!

Nigel

> config SOFTWARE_SUSPEND2
> 	tristate "Software Suspend 2"
> 	depends on PM
> 
> config SOFTWARE_SUSPEND2_BUILTIN
> 	def_bool SOFTWARE_SUSPEND2
> 
> and let everything else depend on SOFTWARE_SUSPEND2.
> 
> > +		config SOFTWARE_SUSPEND_SWAPWRITER
> > +			tristate '   Swap Writer'
> > +			depends on SWAP && SOFTWARE_SUSPEND2_CORE
> > +			select SOFTWARE_SUSPEND2_WRITER
> 
> This select is also bogus.
> 
> > +
> > +ifeq ($(CONFIG_SOFTWARE_SUSPEND2),y)
> > +obj-y	+= suspend_builtin.o proc.o
> > +endif
> 
> Use SOFTWARE_SUSPEND2_BUILTIN here without the ifeq.
> 
> bye, Roman
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

