Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbTILVS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTILVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:17:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12928 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261908AbTILVRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:17:40 -0400
Date: Fri, 12 Sep 2003 22:24:49 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309122124.h8CLOnxS000232@81-2-122-30.bradfords.org.uk>
To: ak@suse.de, bunk@fs.tum.de
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: akpm@osdl.org, azarah@gentoo.org, ebiederm@xmission.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From linux-kernel-owner+john=40bradfords.org.uk@vger.kernel.org  Fri Sep 12 21:59:55 2003
> Envelope-To: john@bradfords.org.uk
> Date: 	Fri, 12 Sep 2003 22:00:23 +0200
> From: Adrian Bunk <bunk@fs.tum.de>
> To: Andi Kleen <ak@suse.de>
> Cc: Martin Schlemmer <azarah@gentoo.org>, jgarzik@pobox.com,
>    ebiederm@xmission.com, akpm@osdl.org, richard.brunner@amd.com,
>    linux-kernel@vger.kernel.org, torvalds@osdl.org
> Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> References: <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com> <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com> <20030912182216.GK27368@fs.tum.de> <20030912202851.3529e7e7.ak@suse.de> <1063393505.3371.207.camel@workshop.saharacpt.lan> <20030912213016.47a4e5de.ak@suse.de>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> In-Reply-To: <20030912213016.47a4e5de.ak@suse.de>
> User-Agent: Mutt/1.4.1i
> Sender: linux-kernel-owner@vger.kernel.org
> Precedence: bulk
> X-Mailing-List: 	linux-kernel@vger.kernel.org
>
> On Fri, Sep 12, 2003 at 09:30:16PM +0200, Andi Kleen wrote:
> >...
> > I think it's useful to keep kernels booting everywhere, it makes it a lot easier
> > to test a single kernel on multiple systems.
>
> Different people have different needs:
>
> Sometimes you want kernels booting everywhere, e.g. a distribution might
> want to support all CPUs from an 386 to an Opteron with one kernel for
> their boot floppies.
>
> For a system administrator with only Pentium 3 and Pentum 4 machines
> support for 386 and Opteron isn't of much worth.
>
> In some embedded systems people are happy about every kB their kernel is 
> smaller.

As I understand it:

* For maximum optimisation, compile for your specific CPU.
* To get compatibility for everything except a 386 CPU, with almost
  optimum performance, compile for 486.
* To get full compatibility, with possibly significantly less than
  optimum performance, compile for 386.
* Only optimise for Pentium if the kernel is intended to be run on a
  Pentium CPU, as the resulting code is less optimal for many other
  processors than code optimised for a 486.

Recently, there have been efforts to make a universally compatible
kernel, with optimisations for all CPUs that don't significantly
adversely affect any other CPUs.  The logic behind this seems to be
that users can then use their distribution's kernel on any CPU, and
get reasonable performance.

Nothing wrong with that in principle, but there are also a lot of
users who are happy to compile one kernel for one machine, and want it
as optimised as possible.  This often includes embedded systems
developers, but certainly isn't limited to them.

John.
