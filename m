Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293639AbSCATFF>; Fri, 1 Mar 2002 14:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293625AbSCATDc>; Fri, 1 Mar 2002 14:03:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293622AbSCATCs>;
	Fri, 1 Mar 2002 14:02:48 -0500
Message-ID: <3C7FD059.E88C026F@mandrakesoft.com>
Date: Fri, 01 Mar 2002 14:02:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: akpm@zip.com.au, aferber@techfak.uni-bielefeld.de, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <3C7FADBB.3A5B338F@mandrakesoft.com>
		<20020301174619.A6125@devcon.net>
		<3C7FCC53.4E270646@zip.com.au> <20020301.105057.75255265.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Fri, 01 Mar 2002 10:45:39 -0800
> 
>    +#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
> 
>    Is this avoidable somehow?
> 
> It's stupid to have all the overhead when vlans aren't even
> being built into the kernel.
> 
> That was my original impetus.
> 
> It's costly in some cases, when you have the TXDs on the chip
> you can avoid an entire PIO for each packet.

I'm pretty sure Andrew realizes this.  I can see two valid complaints,

1) you don't need ugly ifdefs in the code itself -- define a no-op
static inline function for when !VLAN

2) IIRC Alan or somebody is trying to get rid of CONFIG_xxx_MODULE,
because it doesn't really cover the case of when somebody builds VLAN
"later on" as a module, but disables it initially.

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
