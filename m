Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUBLHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUBLHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:07:25 -0500
Received: from ns.suse.de ([195.135.220.2]:14513 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265732AbUBLHHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:07:23 -0500
Date: Thu, 12 Feb 2004 09:33:49 +0100
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: amitkale@emsyssoft.com, akpm@osdl.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org, mludvig@suse.cz
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040212093349.3be06202.ak@suse.de>
In-Reply-To: <402AD815.6050004@mvista.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel>
	<p73n07ykyop.fsf@verdi.suse.de>
	<200402052320.04393.amitkale@emsyssoft.com>
	<20040206032054.3fd7db8d.ak@suse.de>
	<40295388.5080901@mvista.com>
	<20040213204227.0db612f7.ak@suse.de>
	<402AD815.6050004@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 17:34:13 -0800
George Anzinger <george@mvista.com> wrote:


> > The latest binutils should support .cfi_* for i386 too. I don't see much sense
> > in making the code more ugly just for staying backwards compatible with older versions for the 
> > debug case (without CONFIG_DEBUG_INFO it should be compatible though).
> > You need a fairly new gdb too anyways for it.
> 
> Well, yes, the CVS version I mentioned in my patch is needed as I found a bug in 
> the expression analizer.  I am NOT trying to say compatable with old tools.  I 
> AM trying to do something the CURRENT tools make hard to impossible.
> 
> The problem with the gas CFI support is that it does not provide a way to define 
> CFI expressions which are needed to determine if the CFI address should be zero 
> (i.e. the return is to user space) or the current adjusted stack address.

Michal, can you comment? 
 
> I suppose the open ended .cfi_ thing could be used but it requires that you 
> compute your own sleb128 and uleb128 values.  It is also not clear how you tell 
> this thing if you want a word or a half word as the dwarf2 spec requires.  More 
> info on this would be very "nice".  I really would like to do this with out the 
> dwarf2 macros, but, please understand, one of the main reasons for the effort 
> was to tie off the bottom of the stack and that seems to require an expression 
> capability for the asm code in entry.S.

The one issue that required expression support on x86-64 (switching between the
interrupt stack and the process stack) was handled by a dummy base register
with a single ifdef. This turned out to be relatively clean.

-Andi

