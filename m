Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSIDSiZ>; Wed, 4 Sep 2002 14:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSIDSiZ>; Wed, 4 Sep 2002 14:38:25 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:28562 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S314529AbSIDSiY>; Wed, 4 Sep 2002 14:38:24 -0400
Date: Wed, 4 Sep 2002 12:04:10 -0700
From: Matt Porter <porter@cox.net>
To: Craig Arsenault <penguin@wombat.ca>
Cc: Matt Porter <porter@cox.net>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Message-ID: <20020904120410.B27144@home.com>
References: <20020904142636.GL761@opus.bloom.county> <137715274.1031128333@[10.10.2.3]> <20020904095743.A27144@home.com> <Pine.LNX.4.44L.0209041428420.6883-100000@tabmow.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44L.0209041428420.6883-100000@tabmow.ca.nortel.com>; from penguin@wombat.ca on Wed, Sep 04, 2002 at 02:35:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 02:35:27PM -0400, Craig Arsenault wrote:
> 
> On Wed, 4 Sep 2002, Matt Porter wrote:
> > Correct.  The solution, in the context of the linuxppc_2_4_devel tree,
> > is to do the following:
> >
> >         Enable "Prompt for advanced kernel configuration options"
> >         Enable "High memory support"
> >         Enable "Set maximum low memory" and set to 0x40000000
> >         Enable "Set custom kernel base address" and set to 0xa0000000
> >
> > Note that highmem support will not be used in his case (he didn't
> > want to use it), because PAGE_OFFSET is at 0xa0000000 and
> > MAX_LOW_MEM is at 1GB.  With this configuration, VMALLOC_START
> > will be at 0xe0000000 + VMALLOC_OFFSET leaving ample vmalloc
> > space for most applications.  All system memory is mapped as
> > lowmem .
> >
> 
> Matt,
>   That looks exactly like what I'd need.  Thanks.
> I grabbed the "2.4.20-pre5" source of linuxppc_2_4_devel, and
> I do see those options in there.
> However, my problem is that I cannot move to a development kernel for
> this application -> i have to stick on the stable tree.  So i could
> either wait for 2.4.20 to come out, OR could i just look at where
> "CONFIG_LOWMEM_SIZE" and "CONFIG_KERNEL_START" are used in 2.4.20-pre5
> and patch them back myself to 2.4.18?

_devel is pretty stable.  You don't have to use the latest, just
clone up to the changeset including 2.4.18/19 if you like.  Or,
as you suggest, just use it as a reference to make a one-off
mod in your own tree.  I put in these options because of the
numbers of times I had to hack these things for specific embedded
applications. :)
 
> Regardless, thanks very much to everyone who replied for the info.

np

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
