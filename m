Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318937AbSIDPaZ>; Wed, 4 Sep 2002 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318947AbSIDPaZ>; Wed, 4 Sep 2002 11:30:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:35215 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318937AbSIDPaX>; Wed, 4 Sep 2002 11:30:23 -0400
Date: Wed, 04 Sep 2002 08:32:15 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Tom Rini <trini@kernel.crashing.org>, Craig Arsenault <penguin@wombat.ca>
cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Message-ID: <137715274.1031128333@[10.10.2.3]>
In-Reply-To: <20020904142636.GL761@opus.bloom.county>
References: <20020904142636.GL761@opus.bloom.county>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In 2.4.x (currently using 2.4.18), for PPC, there is a value for
>> "MAX_LOW_MEM" defined in "arch/ppc/mm/pgtable.c" as 768MB RAM.  Any
>> memory above 768MB is considered "high" memory.  Now our problem is
>> that we have 1024MB of onboard RAM on our card.  I do *NOT* wish to
>> compile with "CONFIG_HIGHMEM" set to true (see below for why), but i
>> do wish to have full use of the 1024MB of RAM onboard, or at least
>> 992MB which is the minimum for our app.
>> So what I did was just change "MAX_LOW_MEM" to be 0x3E000000
>> (0x30000000), ie. change it to 992 from 768.   I recompiled and tested
>> our application.  Things seemed to be running normal with a max of
>> 992MB of RAM.
>> 
>> Is this a potential problem, or will this cause some lurking bug that
>> anyone can think of?  (ie. I'm sure "MAX_LOW_MEM" was set to 768MB for
>> a reason, but what is that reason).   We don't want to move higher
>> than 1Gig RAM for now, so are we going to be okay doing what I
>> describe above?  Any suggestions or comments as to why that's a very
>> bad idea would be greatly appreciated.  Again, this is for a
>> PPC-specific board, I'm not sure what the x86 architecture's low
>> memory max is.

I think you'll find yourself with no virtual address space left to 
do vmalloc / fixmap / kmap type stuff. Or at least you would on i386, 
I presume it's the same for ppc. Sounds like you may have left 
yourself enough space for fixmap & kmap, but any calls to vmalloc
will probably fail ?

M.

