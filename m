Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSJaLWX>; Thu, 31 Oct 2002 06:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSJaLWX>; Thu, 31 Oct 2002 06:22:23 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64900 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264856AbSJaLWW>; Thu, 31 Oct 2002 06:22:22 -0500
Subject: Re: post-halloween 0.2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031004710.GB10329@suse.de>
References: <20021030171149.GA15007@suse.de>
	<1036006381.5297.108.camel@irongate.swansea.linux.org.uk> 
	<20021031004710.GB10329@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 11:48:45 +0000
Message-Id: <1036064925.8584.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 00:47, Dave Jones wrote:
> On Wed, Oct 30, 2002 at 07:33:01PM +0000, Alan Cox wrote:
> 
>  > > (Things not expected to work just yet)
>  > > - The hptraid/promise RAID drivers are currently non functional.
>  > [These hopefully can be converted to use device mapper..]
> 
> Thats a fairly large 'mandatory' requirement for existing users
> of hptraid and friends.

Whether its a userspace thing or DM is simply told by the hptraid driver
to do the work for it is an open question yes

>  > > (Note that the OSS drivers are also still functional, and
>  > >  still present)
>  > Kind of work in some cases, they are deprecated and may vanish before
>  > 2.6 or may vanish the release after.
> 
> I'd agree that it would make sense to at least remove some of the
> lesser maintained drivers. Linus didnt seem to keen on the idea
> last time I proposed it.

OSS hasnt worked on SMP between about 2.5.35 and 2.5.44 so I dont think
its that major 8)

> BTW: How's i2o shaping up in 2.5 ?

It compiles I've got to put stuff together to do the full test runs on
it yet. The code is actually a lot cleaner with the new block layer,
much more scalable and also Al Viro took a hatchet to bits of it when
tidying the block layer so the disk add/remove and other stuff has also
improved dramatically. The fast path for I/O now executes a mere four
instructions within the driver under a spinlock on i2o_block 8)

Mostly I'm working on the NCR5380 first. That happens to be attached to
my scanner so spinning for 15 seconds in IRQ context is annoying me 8)

