Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWDMWpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWDMWpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWDMWpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:45:35 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:35222 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751155AbWDMWpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:45:34 -0400
Date: Fri, 14 Apr 2006 00:45:33 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>, Sam Vilain <sam@vilain.net>,
       devel@openvz.org, Kir Kolyshkin <kir@sacred.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060413224533.GA11178@MAIL.13thfloor.at>
Mail-Followup-To: Cedric Le Goater <clg@fr.ibm.com>,
	Kirill Korotaev <dev@openvz.org>, Sam Vilain <sam@vilain.net>,
	devel@openvz.org, Kir Kolyshkin <kir@sacred.ru>,
	linux-kernel@vger.kernel.org
References: <1143588501.6325.75.camel@localhost.localdomain> <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru> <1143668273.9969.19.camel@localhost.localdomain> <443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at> <443DF523.3060906@openvz.org> <20060413134239.GA6663@MAIL.13thfloor.at> <443EC399.2040307@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443EC399.2040307@fr.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:33:13PM +0200, Cedric Le Goater wrote:
> Herbert Poetzl wrote:
> 
> > well, if the 'results' and 'methods' will be made
> > public, I can, until now all I got was something
> > along the lines:
> > 
> >  "Linux-VServer is not stable! WE (swsoft?) have
> >   a secret but essential test suite running two 
> >   weeks to confirm that OUR kernels ARE stable,
> >   and Linux-VServer will never pass those tests,
> >   but of course, we can't tell you what kind of
> >   tests or what results we got"
> > 
> > which doesn't help me anything and which, to be 
> > honest, does not sound very friendly either ...
> 
> Recently, we've been running tests and benchmarks in different
> virtualization environments : openvz, vserver, vserver in a minimal
> context and also Xen as a reference in the virtual machine world.
> 
> We ran the usual benchmarks, dbench, tbench, lmbench, kernerl build,
> on the native kernel, on the patched kernel and in each virtualized
> environment. We also did some scalability tests to see how each
> solution behaved. And finally, some tests on live migration. We didn't
> do much on network nor on resource management behavior.

I would be really interested in getting comparisons
between vanilla kernels and linux-vserver patched
versions, especially vs2.1.1 and vs2.0.2 on the
same test setup with a minimum difference in config

I doubt that you can really compare across the
existing virtualization technologies, as it really
depends on the setup and hardware 

> We'd like to continue in an open way. But first, we want to make sure
> we have the right tests, benchmarks, tools, versions, configuration,
> tuning, etc, before publishing any results :) We have some materials
> already but before proposing we would like to have your comments and
> advices on what we should or shouldn't use.

In my experience it is extremely hard to do 'proper'
comparisons, because the slightest change of the
environment can cause big differences ...

here as example, a kernel build (-j99) on 2.6.16
on a test host, with and without a chroot:

without:

 451.03user 26.27system 2:00.38elapsed 396%CPU
 449.39user 26.21system 1:59.95elapsed 396%CPU
 447.40user 25.86system 1:59.79elapsed 395%CPU

now with:

 490.77user 24.45system 2:13.35elapsed 386%CPU
 489.69user 24.50system 2:12.60elapsed 387%CPU
 490.41user 24.99system 2:12.22elapsed 389%CPU

now is chroot() that imperformant? no, but the change
in /tmp being on a partition vs. tmpfs makes quite
some difference here

even moving from one partition to another will give
measurable difference here, all within a small margin

an interesting aspect is the gain (or loss) you have
when you start several guests basically doing the
same thing (and sharing the same files, etc)

> Thanks for doing such a great job on lightweight containers,

you're welcome!

best,
Herbert

> C.
