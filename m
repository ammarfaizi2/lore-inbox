Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUDAPZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUDAPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:25:10 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:20199 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262920AbUDAPY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:24:57 -0500
Date: Thu, 1 Apr 2004 07:22:32 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: replace cpumask_t implementation [3/22]
Message-Id: <20040401072232.798d98c8.pj@sgi.com>
In-Reply-To: <1080611340.6742.147.camel@arrakis>
References: <20040329041256.0f27e8c4.pj@sgi.com>
	<1080611340.6742.147.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  #define	cpu_online_map			cpumask_of_cpu(0)
> >  #define	cpu_possible_map		cpumask_of_cpu(0)
> >  ...
> Might it make more sense to actually define a cpu_online_map &
> cpu_possible_map for UP, rather than generating this code:
> 
> #define mask_of_bit(bit, T)                                            \
> ({                                                                     \
>        typeof(T) m;                                                    \
>        mask_clearall(m);                                               \
>        mask_setbit((bit), m);                                          \
>        m;                                                              \
> })
> 
> every time some code references cpu_online_map?  It'll only cost us 2
> unsigned longs on 32-bit == 8 bytes...

Perhaps.

When I looked at the code just now, this only seemed to take a
couple of instructions.  Do you think that there is much to gain?
Better a couple of inline instructions than a possible uncached
memory reference, I suspect.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
