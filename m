Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbUAVQpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUAVQpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:45:35 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:34695 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S266050AbUAVQpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:45:32 -0500
Date: Thu, 22 Jan 2004 09:45:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040122164521.GF15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org> <200401222136.10887.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401222136.10887.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 09:36:10PM +0530, Amit S. Kale wrote:
> On Thursday 22 Jan 2004 9:15 pm, Tom Rini wrote:
> > On Thu, Jan 22, 2004 at 09:25:19AM -0600, Hollis Blanchard wrote:
> > > On Jan 22, 2004, at 9:07 AM, Tom Rini wrote:
> > > >On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
> > > >>A question I have been meaning to ask:  Why is the arch/common
> > > >>connection
> > > >>via a structure of addresses instead of just calls?  I seems to me
> > > >>that
> > > >>just calling is a far cleaner way to do things here.  All the struct
> > > >>seems
> > > >>to offer is a way to change the backend on the fly.  I don't thing we
> > > >>ever
> > > >>want to do that.  Am I missing something?
> > > >
> > > >I imagine it's a style thing.  I don't have a preference either way.
> > >
> > > I think we in PPC land have gotten used to that "style" because we have
> > > one kernel that supports different "platforms", i.e. it selects the
> > > appropriate code at runtime as George says. In general that's a little
> > > bit slower and a little bit bigger.
> > >
> > > Unless you need to choose among PPC KGDB functions at runtime, which I
> > > don't think you do, you don't need it...
> >
> > That's certainly true, so if (and if I understand Georges question
> > right) Amit wants to change kgdb_arch into a set of required functions,
> > with stubs in, say, kernel/kgdbdummy.c, (and just keep the flags / etc
> > in the struct), that's fine with me.
> 
> The penalty of keeping them consolidated in a structure isn't so high. I 
> prefer to keep them that way. I'll work on reducing number of initialization 
> functions, though.
> 
> I have to do something about early connect though. Powerpc kgdb on 8260 is 
> definitely capable of starting debugging right at architecture setup time. 
> It's just that kgdbstub.c isn't ready yet.

FWIW, this is true of KGDB on all PPCs.  IIRC, so long as the serial
definitions are filled out statically, the stub currently in kernel.org
for PPC can do first-line-of-C already.

> How about changing the code in kgdbstub to allow kgdb to be configured in one 
> of the following ways:
> Late kgdb - kgdb comes up after smp_init in the kernel boot sequence. kgdb8250 
> can be used with more flexibility through kernel command line options. One 
> can boot a kgdb kernel without activating kgdb. Works with the interface 
> chosen by kernel command line (kgdb8250 and kgdbeth for the moment).

Which is basically how it goes now, right?

> Early kgdb - kgdb comes up right at the begining of start_kernel at the cost 
> of flexibility. It doesn't show any messages such as "waiting for gdb". All 
> configurations have to be compiled in through menuconfig. Once a kernel is 
> built, it'll always run with kgdb and with 8250 at a fixed port and speed.
> 
> i386 architecture will support both kgdb configuration.
> KGDB in powerpc 8260 will be of early kgdb type. Other powerpc arches (550 etc 
> will depend on whether the interface can be initialized early or later)

Again, there is nothing special about KGDB on 82xx (or 8xx for that
matter) over classic PPCs (which tend to have a 550, but this is not
always the case) or 4xx.

-- 
Tom Rini
http://gate.crashing.org/~trini/
