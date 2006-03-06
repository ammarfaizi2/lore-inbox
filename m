Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWCFQfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWCFQfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWCFQfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:35:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11751 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751471AbWCFQfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:35:19 -0500
Date: Mon, 6 Mar 2006 13:50:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060306125018.GA1673@elf.ucw.cz>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060301043353.GJ28434@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 28-02-06 23:33:53, Dave Jones wrote:
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

Well, blacklisting "new" machines is a problem -- their number
grows. Would not it be better to blacklist machines broken by APIC
("old" ones, presumably)?

> The big problem the patch solves is allowing it to be possible
> to build a kernel with UP APIC code, but disabled by default
> (Because there a lot of older machines that die horribly if it
>  was enabled by default).

Is adding "noapic nolapic" to default command line a big problem?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
