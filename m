Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUBLBe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUBLBe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:34:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42995 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266543AbUBLBeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:34:25 -0500
Message-ID: <402AD815.6050004@mvista.com>
Date: Wed, 11 Feb 2004 17:34:13 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: amitkale@emsyssoft.com, akpm@osdl.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>	<20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel>	<p73n07ykyop.fsf@verdi.suse.de>	<200402052320.04393.amitkale@emsyssoft.com>	<20040206032054.3fd7db8d.ak@suse.de>	<40295388.5080901@mvista.com> <20040213204227.0db612f7.ak@suse.de>
In-Reply-To: <20040213204227.0db612f7.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, 10 Feb 2004 13:56:24 -0800
> George Anzinger <george@mvista.com> wrote:
> 
> 
>>>Problem is that he did it without binutils support. I don't think that's a good
>>>idea because it makes the code basically unmaintainable for normal souls
>>>(it's like writing assembly code directly in hex) 
>>
>>Well, bin utils, at this time, makes it even worse in that it does not support 
>>the expression syntax.  Also, it is not asm but dwarf2 and it is written in, 
>>IMHO, useful macros (not hex :)
> 
> 
> The latest binutils should support .cfi_* for i386 too. I don't see much sense
> in making the code more ugly just for staying backwards compatible with older versions for the 
> debug case (without CONFIG_DEBUG_INFO it should be compatible though).
> You need a fairly new gdb too anyways for it.

Well, yes, the CVS version I mentioned in my patch is needed as I found a bug in 
the expression analizer.  I am NOT trying to say compatable with old tools.  I 
AM trying to do something the CURRENT tools make hard to impossible.

The problem with the gas CFI support is that it does not provide a way to define 
CFI expressions which are needed to determine if the CFI address should be zero 
(i.e. the return is to user space) or the current adjusted stack address.

I suppose the open ended .cfi_ thing could be used but it requires that you 
compute your own sleb128 and uleb128 values.  It is also not clear how you tell 
this thing if you want a word or a half word as the dwarf2 spec requires.  More 
info on this would be very "nice".  I really would like to do this with out the 
dwarf2 macros, but, please understand, one of the main reasons for the effort 
was to tie off the bottom of the stack and that seems to require an expression 
capability for the asm code in entry.S.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

