Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWCAEeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWCAEeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWCAEeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:34:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751696AbWCAEeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:34:06 -0500
Date: Tue, 28 Feb 2006 23:33:53 -0500
From: Dave Jones <davej@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060301043353.GJ28434@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
	Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 02:57:05PM +1100, Michael Ellerman wrote:
 > On 1/20/06, Darrick J. Wong <djwong@us.ibm.com> wrote:
 > > Hi there,
 > >
 > > Some old i386 systems have flaky APIC hardware that doesn't always work
 > > right.  Right now, enabling the APIC code in Kconfig means that the APIC
 > > code will try to activate the APICs unless 'noapic nolapic' are passed
 > > to force them off.  The attached patch provides a config option to
 > > change that default to keep the APICs off unless specified otherwise,
 > > disables get_smp_config if we are not initializing the local APIC, and
 > > makes init_apic_mappings not init the IOAPICs if they are disabled.
 > > Note that the current behavior is maintained if
 > > CONFIG_X86_UP_APIC_DEFAULT_OFF=n.
 > Did this hit the floor?

It's still being kicked around.  I saw one patch off-list earlier this
week that has some small improvements over the variant originally posted,
but still had 1-2 kinks.

 > It strikes me as a pretty good solution. This
 > is pretty nasty for newbies installing distro kernels, they get some
 > of the way through an install and then their machine just locks - not
 > good PR.

The number of systems that actually *need* APIC enabled are in the
vast (though growing) minority, so it's unlikely that most newbies
will hit this.  The problem is also the inverse of what you describe.
Typically the distros have DMI lists of machines that *need* APIC
to make it enabled by default so everything 'just works'.

The big problem the patch solves is allowing it to be possible
to build a kernel with UP APIC code, but disabled by default
(Because there a lot of older machines that die horribly if it
 was enabled by default).

		Dave

