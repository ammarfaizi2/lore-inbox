Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbTJKA7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 20:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJKA7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 20:59:10 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:49160 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263188AbTJKA7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 20:59:07 -0400
Date: Fri, 10 Oct 2003 22:07:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: bug in init_i82365 wrt sysfs
Message-ID: <20031011010728.GA13304@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20031010035940.GA9668@conectiva.com.br> <20031010090104.A23806@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010090104.A23806@flint.arm.linux.org.uk>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 10, 2003 at 09:01:04AM +0100, Russell King escreveu:
> On Fri, Oct 10, 2003 at 12:59:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > Call Trace:
> >  [<c01dbf4c>] class_device_create_file+0x1c/0x30
> >  [<c2805188>] init_i82365+0xe8/0x1e8 [i82365]
> >  [<c0139cff>] sys_init_module+0x15f/0x2f0
> >  [<c0109897>] syscall_call+0x7/0xb
> 
> This oops has been caused by the need to register the class before
> registering any objects against it.  Unfortunately, the class needs
> to be registered asynchronously in a separate thread to avoid driver
> model deadlock with yenta with cardbus cards inserted or standard
> PCMCIA cards not being detected correctly due to a race.
> 
> I think the only real solution is to remove the class_device_create_file
> calls from all socket drivers.  This is just a simple commenting out of
> the calls, and should be suitable for the remainder of the -test kernels.
> 
> Due to the number of cases that we're encountering with PCMCIA, I'm
> beginning to wonder if the driver model could be fixed to be more kind
> to PCMCIA by avoiding some of these ordering dependencies.  None of this
> would be a problem if the driver model would allow PCI device drivers to
> register PCI devices while their probe or remove functions were executing.
> 
> Below is a completely untested patch.  Arnaldo - please test whether this
> fixes your problem.

Yes, it fixes, thanks.

- Arnaldo
