Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSIDSbq>; Wed, 4 Sep 2002 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSIDSbq>; Wed, 4 Sep 2002 14:31:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:9402 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S314514AbSIDSbm>; Wed, 4 Sep 2002 14:31:42 -0400
Date: Wed, 4 Sep 2002 14:35:27 -0400 (EDT)
X-Sybari-Space: 00000000 00000000 00000000
From: Craig Arsenault <penguin@wombat.ca>
X-X-Sender: craig@tabmow.ca.nortel.com
To: Matt Porter <porter@cox.net>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
In-Reply-To: <20020904095743.A27144@home.com>
Message-ID: <Pine.LNX.4.44L.0209041428420.6883-100000@tabmow.ca.nortel.com>
References: <20020904142636.GL761@opus.bloom.county> <137715274.1031128333@[10.10.2.3]>
 <20020904095743.A27144@home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Matt Porter wrote:

> On Wed, Sep 04, 2002 at 08:32:15AM -0700, Martin J. Bligh wrote:
> >
> > >> In 2.4.x (currently using 2.4.18), for PPC, there is a value for
> > >> "MAX_LOW_MEM" defined in "arch/ppc/mm/pgtable.c" as 768MB RAM.  Any
> > >> memory above 768MB is considered "high" memory.  Now our problem is
> > >> that we have 1024MB of onboard RAM on our card.  I do *NOT* wish to
> > >> compile with "CONFIG_HIGHMEM" set to true (see below for why), but i
> > >> do wish to have full use of the 1024MB of RAM onboard, or at least
> > >> 992MB which is the minimum for our app.
> > >> So what I did was just change "MAX_LOW_MEM" to be 0x3E000000
> > >> (0x30000000), ie. change it to 992 from 768.   I recompiled and tested
>
<snip>

> Correct.  The solution, in the context of the linuxppc_2_4_devel tree,
> is to do the following:
>
>         Enable "Prompt for advanced kernel configuration options"
>         Enable "High memory support"
>         Enable "Set maximum low memory" and set to 0x40000000
>         Enable "Set custom kernel base address" and set to 0xa0000000
>
> Note that highmem support will not be used in his case (he didn't
> want to use it), because PAGE_OFFSET is at 0xa0000000 and
> MAX_LOW_MEM is at 1GB.  With this configuration, VMALLOC_START
> will be at 0xe0000000 + VMALLOC_OFFSET leaving ample vmalloc
> space for most applications.  All system memory is mapped as
> lowmem .
>

Matt,
  That looks exactly like what I'd need.  Thanks.
I grabbed the "2.4.20-pre5" source of linuxppc_2_4_devel, and
I do see those options in there.
However, my problem is that I cannot move to a development kernel for
this application -> i have to stick on the stable tree.  So i could
either wait for 2.4.20 to come out, OR could i just look at where
"CONFIG_LOWMEM_SIZE" and "CONFIG_KERNEL_START" are used in 2.4.20-pre5
and patch them back myself to 2.4.18?


Regardless, thanks very much to everyone who replied for the info.


--
Craig.
+------------------------------------------------------+
http://www.wombat.ca/rpmon.html    RP Music Monitor
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.44*=--------------------+



