Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWHHH7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWHHH7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHHH7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:59:08 -0400
Received: from koto.vergenet.net ([210.128.90.7]:45711 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932546AbWHHH7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:59:06 -0400
Date: Tue, 8 Aug 2006 16:58:52 +0900
From: Horms <horms@verge.net.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, vgoyal@in.ibm.com, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060808075849.GA11285@verge.net.au>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com> <20060808033405.GA6767@verge.net.au> <44D813D7.3050004@zytor.com> <20060808060957.GC7681@verge.net.au> <m18xlz8zdo.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xlz8zdo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 01:23:15AM -0600, Eric W. Biederman wrote:
> Horms <horms@verge.net.au> writes:
> 
> > On Mon, Aug 07, 2006 at 09:32:23PM -0700, H. Peter Anvin wrote:
> >> Horms wrote:
> >> >
> >> >I also agree that it is non-intitive. But I wonder if a cleaner
> >> >fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
> >> >it just a work around for the kernel not being relocatable, or
> >> >are there uses for it that relocation can't replace?
> >> >
> >> 
> >> Yes, booting with the 2^n existing bootloaders.
> >
> > Ok, I must be confused then. I though CONFIG_PHYSICAL_START was
> > introduced in order to allow an alternative address to be provided for
> > kdump, and that previously it was hard-coded to some
> > architecture-specific value.
> >
> > What I was really getting as is if it needs to be configurable at
> > compile time or not. Obviously there needs to be some sane default
> > regardless.
> 
> CONFIG_PHYSICAL_START has had 2 uses.
> 1) To allow a kernel to run a completely different address for use
>    with kexec on panic.
> 2) To allow the kernel to be better aligned for better performance.

Thanks for making that clear

> For maintenance reasons I propose we introduce CONFIG_PHYSICAL_ALIGN.
> Which will round our load address up to the nearest aligned address
> and run the kernel there.  That is roughly what I am doing on x86_64
> at this point.
> 
> s/CONFIG_PHYSICAL_START/CONFIG_PHYSICAL_ALIGN/ gives me well defined
> behavior and allows the alignment optimization without getting into 
> weird semantics.
> 
> Before CONFIG_PHYSICAL_START we _always_ ran the arch/i386 kernel
> where it was loaded and I assumed we always would.  Since people have
> realized better aligned kernels can run better this assumption became
> false.  Going to CONFIG_PHYSICAL_ALIGN allows us to return to the
> simple assumption of always running the kernel where it is loaded
> modulo a little extra alignment.

That sounds reasonable to me. Though it is a little less flexible,
do you think that could be a problem? Perhaps we could have both,
though that would probably be quite confusing.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

