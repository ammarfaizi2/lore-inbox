Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311234AbSCLPX4>; Tue, 12 Mar 2002 10:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311235AbSCLPXr>; Tue, 12 Mar 2002 10:23:47 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:53400 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311234AbSCLPXg>; Tue, 12 Mar 2002 10:23:36 -0500
Date: Tue, 12 Mar 2002 16:23:16 +0100
From: Andi Kleen <ak@muc.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: __get_user usage in mm/slab.c
Message-ID: <20020312162316.A3505@averell>
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 12:58:53PM +0100, Roman Zippel wrote:
> Hi,
> 
> The way __get_user is currently used in mm/slab.c is not portable. It
> breaks on arch which have seperate user/kernel memory space. It still
> works during boot or from kernel threads, but /proc/slabinfo shows only 
> broken entries or if a module creates a slab cache, I got lots of
> warnings.
> We have to at least insert a "set_fs(get_fs())", but IMO a separate
> interface would be better. Any opinions?

I agree that a separate interface would be better, one that guarantees to
handle exceptions on the m68k and other archs with separate address spaces too.
I use that facility quite regularly in architecture specific code, sorry
for letting it slip into portable code. 
I guess set_fs(KERNEL_DS); __*_user() will not catch exceptions on m68k
currently, right? 

-Andi

