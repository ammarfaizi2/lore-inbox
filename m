Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWHIO4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWHIO4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWHIO4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:56:43 -0400
Received: from smtp.enter.net ([216.193.128.24]:39693 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750934AbWHIO4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:56:42 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Horms <horms@verge.net.au>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Date: Wed, 9 Aug 2006 10:56:38 -0400
User-Agent: KMail/1.9.3
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>, vgoyal@in.ibm.com, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <m18xlz8zdo.fsf@ebiederm.dsl.xmission.com> <20060808075849.GA11285@verge.net.au>
In-Reply-To: <20060808075849.GA11285@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091056.39770.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 03:58, Horms wrote:
> On Tue, Aug 08, 2006 at 01:23:15AM -0600, Eric W. Biederman wrote:
> > Horms <horms@verge.net.au> writes:
<snip>
> > For maintenance reasons I propose we introduce CONFIG_PHYSICAL_ALIGN.
> > Which will round our load address up to the nearest aligned address
> > and run the kernel there.  That is roughly what I am doing on x86_64
> > at this point.
> >
> > s/CONFIG_PHYSICAL_START/CONFIG_PHYSICAL_ALIGN/ gives me well defined
> > behavior and allows the alignment optimization without getting into
> > weird semantics.
> >
> > Before CONFIG_PHYSICAL_START we _always_ ran the arch/i386 kernel
> > where it was loaded and I assumed we always would.  Since people have
> > realized better aligned kernels can run better this assumption became
> > false.  Going to CONFIG_PHYSICAL_ALIGN allows us to return to the
> > simple assumption of always running the kernel where it is loaded
> > modulo a little extra alignment.
>
> That sounds reasonable to me. Though it is a little less flexible,
> do you think that could be a problem? Perhaps we could have both,
> though that would probably be quite confusing.

More than reasonable. By changing this it seems that the kernel would still 
work with older bootloaders, function properly under kexec and might actually 
lead to a way to potentially recover a system from a crash without a reboot 
by allowing the kexec'd kernel to reset the system.

Of course the last is only a wish... Never happen because of the complexity 
involved. It would require a lot of work (I'd do this, but I'm currently 
arguing with the kernel over my attempts at building a functional DRM backed 
console) in having to switch back to real-mode to make the proper BIOS calls 
to reset the busses et. al. before switching *back* to kernel mode to run the 
standard startup.

Still, by letting a kernel run where it's loaded plus some modulo to get it 
properly aligned in memory solves several problems. It removes the need for 
CONFIG_PHYSICAL_START and the code involved in handling that. The kexec code 
that reserves memory for the new kernel image can be tweaked to always 
allocate the memory *aligned*...

Anyway, I'd better get back to the DRMCon code...

DRH
