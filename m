Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265744AbUADQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbUADQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:08:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37472 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265744AbUADQHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:07:54 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
References: <20040103030814.GG18208@waste.org>
	<m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
	<20040104084005.GU18208@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2004 09:02:28 -0700
In-Reply-To: <20040104084005.GU18208@waste.org>
Message-ID: <m1y8snhfcb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Sun, Jan 04, 2004 at 12:42:43AM -0700, Eric W. Biederman wrote:
> > Matt Mackall <mpm@selenic.com> writes:
> > 
> > > Contributions and suggestions are encouraged. In particular, it would
> > > be helpful if people with non-x86 hardware could take a stab at
> > > extending some of the stuff that's currently only been done for X86 to
> > > other architectures.
> > 
> > I just tried a kernel build with as much as possible turned off.  This
> > uncovered a couple of bugs, which I fixed with the attached diff.  But
> > it looks like there finally is a light at the end of the rainbow.
> 
> Thanks. I actually cleaned up all this stuff earlier today, will
> probably do another release shortly.
>  
> > 220K compressed and 371K uncompressed.  This is a serious reduction from
> > previous versions.  There is still a huge amount of code I can't compile
> > out but this is certainly progress.  Thank you.
> 
> Suggestions? I'm rapidly exhausting a lot of the obvious candidates.
> My target build at the moment is ide + ext2 + proc + ipv4 + console, and
> that's currently at around 800K uncompressed, booting in a little less
> than 2.5MB. Hoping to get that under 2.

Nice.  I have a 386 I really should try this out on.

Of note IPv4 is about 90K compressed.  And I know you can do a minimal
IPv4 stack in about 8K compressed.

My target is a minimal kernel that can be used as a bootloader.  But
what I am looking for at first is to be able to turn as many things
off as possible so that we can test to see how much individual pieces
add.

If you look at ELKS or one of the old unix like kernels you can get
those down to 64K and still be usable.

I'm currently looking at removing the buffer cache, since I most
of the time I don't care about disks.  This is complicated by the fact
that many of the default paths in the kernel when they don't have a
better implementation use buffer cache methods.  But I'm making
headway.

Proc is one of things that frequently has loads of crap that are
not needed in a minimal setup.

Until I find more candidates to turn off I can't see any low hanging
fruit for shrinking in size.

Eric
