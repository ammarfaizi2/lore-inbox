Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbULHOcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbULHOcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULHOcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:32:00 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:13253 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261228AbULHOb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:31:56 -0500
Date: Wed, 8 Dec 2004 15:32:12 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
Message-ID: <20041208143212.GL1371@postel.suug.ch>
References: <1102380430.6103.6.camel@buffy> <20041206224441.628e7885.akpm@osdl.org> <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net> <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net> <1102480044.1050.9.camel@jzny.localdomain> <1102480913.1049.24.camel@jzny.localdomain> <41B68E5D.2080009@trash.net> <1102509111.1051.54.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102509111.1051.54.camel@jzny.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal <1102509111.1051.54.camel@jzny.localdomain> 2004-12-08 07:31
> On Wed, 2004-12-08 at 00:17, Patrick McHardy wrote:
> 
> > I think these tests are a waste of time. struct tcf_police is not
> > userspace-visible, so it's highly unlikely that the tc version matters.
> > Why an old kernel needs to be tested is beyond me. 
> 
> Regression testing. 
> You need both backward and forward compatibility.
> Old kernels must continue to work with new tc for the policer using the
> old syntax.
> new kernels must continue to work with old tc for policer management
> using old syntax.
> Policer existed before any tc action code was written and has a very
> different layout of the structure. User tools and classifiers (accessed
> from user tools) do touch that code.
> These kind of tests constitute about 50% or more of my testing.

I invested some time to ease testing since this was primarly my fault
by overlooking the special case of tcf_police.

I've put together a small testsuite allowing to easly run tests for
multiple versions of iproute2. It can be found at:
	http://people.suug.ch/~tgr/iproute2/tc-testsuite.tar.gz

One simply extracts various iproute2 versions into iproute2/ and
sets KERNEL_INCLUDE if needed for older versions. 'make compile' on
the top level compiles all the versions.

The tests are defined in tests/ and are simple shell scripts and get
invoked for every iproute2 verison in iproute2 with $TC and $IP
set to the version currently being tested. The output of every test
run is stored in results/$TEST.$IPVERSION.out respectively .dmesg.

'make clean' removes all the results again.

'make liststests' lists all the available tests.

'make alltests' runs all the tests.

I've run all the tests on my patch with the following kernels and
iproute2 versions:

 - 2.6.10-rc2-bk13 (actions compiled in)
 - 2.6.10-rc2-bk13-no-act (old policer compiled in)
 - 2.4.28-rc1-bk1

 - iproute2-2.6.9-tgr (with all my patches in)
 - iproute2-2.4.7

iproute-2.6.9 was sucessful with all kernels. I couldn't test with the
old 2.4.7 iproute2 yet since the syntax has changed and I need to adopt
the tests first. I will create better tests and run it on patrick's
patch when I get home.
