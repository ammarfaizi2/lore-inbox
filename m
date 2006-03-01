Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWCAGbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWCAGbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWCAGbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:31:46 -0500
Received: from fsmlabs.com ([168.103.115.128]:7900 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932514AbWCAGbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:31:45 -0500
X-ASG-Debug-ID: 1141194702-2997-77-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 28 Feb 2006 22:36:09 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>
cc: Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
X-ASG-Orig-Subj: Re: [PATCH] leave APIC code inactive by default on i386
Subject: Re: [PATCH] leave APIC code inactive by default on i386
In-Reply-To: <20060301043353.GJ28434@redhat.com>
Message-ID: <Pine.LNX.4.64.0602282234120.28074@montezuma.fsmlabs.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
 <20060301043353.GJ28434@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9306
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Dave Jones wrote:

> On Wed, Mar 01, 2006 at 02:57:05PM +1100, Michael Ellerman wrote:
>  > On 1/20/06, Darrick J. Wong <djwong@us.ibm.com> wrote:
>  > > Hi there,
>  > >
>  > > Some old i386 systems have flaky APIC hardware that doesn't always work
>  > > right.  Right now, enabling the APIC code in Kconfig means that the APIC
>  > > code will try to activate the APICs unless 'noapic nolapic' are passed
>  > > to force them off.  The attached patch provides a config option to
>  > > change that default to keep the APICs off unless specified otherwise,
>  > > disables get_smp_config if we are not initializing the local APIC, and
>  > > makes init_apic_mappings not init the IOAPICs if they are disabled.
>  > > Note that the current behavior is maintained if
>  > > CONFIG_X86_UP_APIC_DEFAULT_OFF=n.
>  > Did this hit the floor?
> 
> It's still being kicked around.  I saw one patch off-list earlier this
> week that has some small improvements over the variant originally posted,
> but still had 1-2 kinks.
> 
>  > It strikes me as a pretty good solution. This
>  > is pretty nasty for newbies installing distro kernels, they get some
>  > of the way through an install and then their machine just locks - not
>  > good PR.
> 
> The number of systems that actually *need* APIC enabled are in the
> vast (though growing) minority, so it's unlikely that most newbies
> will hit this.  The problem is also the inverse of what you describe.
> Typically the distros have DMI lists of machines that *need* APIC
> to make it enabled by default so everything 'just works'.
> 
> The big problem the patch solves is allowing it to be possible
> to build a kernel with UP APIC code, but disabled by default
> (Because there a lot of older machines that die horribly if it
>  was enabled by default).

The current policy is off if it was disabled by the BIOS. Is the intention 
of this patch to have it off unconditionally unless explicitely enabled by 
kernel parameter?

Thanks,
	Zwane
