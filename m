Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319180AbSIDOWP>; Wed, 4 Sep 2002 10:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319181AbSIDOWP>; Wed, 4 Sep 2002 10:22:15 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:42707
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S319180AbSIDOWN>; Wed, 4 Sep 2002 10:22:13 -0400
Date: Wed, 4 Sep 2002 07:26:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Craig Arsenault <penguin@wombat.ca>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Message-ID: <20020904142636.GL761@opus.bloom.county>
References: <Pine.LNX.4.44L.0209040744170.6536-100000@tabmow.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209040744170.6536-100000@tabmow.ca.nortel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ed linuxppc-dev, which is where you should probably have asked
this..]

On Wed, Sep 04, 2002 at 09:12:31AM -0400, Craig Arsenault wrote:

> Hi all,
>   Now I'll explain "why" i want to do what I'm asking below, but if
> anyone has any reasons/explanations why it won't work, I'd love to
> hear it.
> 
> In 2.4.x (currently using 2.4.18), for PPC, there is a value for
> "MAX_LOW_MEM" defined in "arch/ppc/mm/pgtable.c" as 768MB RAM.  Any
> memory above 768MB is considered "high" memory.  Now our problem is
> that we have 1024MB of onboard RAM on our card.  I do *NOT* wish to
> compile with "CONFIG_HIGHMEM" set to true (see below for why), but i
> do wish to have full use of the 1024MB of RAM onboard, or at least
> 992MB which is the minimum for our app.
> So what I did was just change "MAX_LOW_MEM" to be 0x3E000000
> (0x30000000), ie. change it to 992 from 768.   I recompiled and tested
> our application.  Things seemed to be running normal with a max of
> 992MB of RAM.
> 
> Is this a potential problem, or will this cause some lurking bug that
> anyone can think of?  (ie. I'm sure "MAX_LOW_MEM" was set to 768MB for
> a reason, but what is that reason).   We don't want to move higher
> than 1Gig RAM for now, so are we going to be okay doing what I
> describe above?  Any suggestions or comments as to why that's a very
> bad idea would be greatly appreciated.  Again, this is for a
> PPC-specific board, I'm not sure what the x86 architecture's low
> memory max is.
>
>
> REASON for asking:
> Currently, one piece of hardware on our card (a PMC card) is using a
> closed-source driver, and they have less-than stellar linux drivers
> and support.  Their driver has problems with CONFIG_HIGHMEM turned on
> (they are using kiobuf's and they are getting messed up), so as a hack
> until they fix their driver, we were contemplating moving MAX_LOW_MEM.
> Yes, I know closed-source drivers are bad in some cases, but we had
> little choice in this product, and our goal is to move away from it
> and use something else.

Well, in the linuxppc_2_4_devel tree
(http://penguinppc.org/dev/kernel.shtml), it's possible to change all of
these parameters for custom applications, like what you describe later.

One important thing to keep in mind, is that MAX_LOW_MEM cannot be
bigger than 0xF00000000 - KERNELBASE (which by default is 0xC0000000) or
bad things can happen.  And if you modify KERNELBASE, there's other
things you need to be aware of, so if you're going to do this, please
look at the linuxppc_2_4_devel tree (or in 2.5) to see all of the
interdependancies.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
