Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbTLSAc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 19:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbTLSAc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 19:32:28 -0500
Received: from b1.ovh.net ([213.186.33.51]:16607 "EHLO mail8.ha.ovh.net")
	by vger.kernel.org with ESMTP id S265393AbTLSAc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 19:32:26 -0500
Message-ID: <1071793964.3fe2472cd2861@ssl0.ovh.net>
Date: Fri, 19 Dec 2003 01:32:44 +0100
From: Miroslaw KLABA <totoro@totoro.be>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Double Interrupt with HT
References: <20031215155843.210107b6.totoro@totoro.be> <1071603069.991.194.camel@cog.beaverton.ibm.com> <1071615336.3fdf8d6840208@ssl0.ovh.net> <1071618630.1013.11.camel@cog.beaverton.ibm.com> <1071630228.3fdfc794eb353@ssl0.ovh.net> <1071717730.1117.26.camel@cog.beaverton.ibm.com> <20031218131437.239e69e5.totoro@totoro.be> <Pine.LNX.4.58.0312180849480.1710@montezuma.fsmlabs.com> <20031218173528.370211b6.totoro@totoro.be> <Pine.LNX.4.58.0312181219570.1710@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0312181219570.1710@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 193.253.41.166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch doesn't solve the problem.
`while true; do date; sleep 1; done` still counts twice the speed.

Thanks
Miro

Quoting Zwane Mwaikambo <zwane@arm.linux.org.uk>:

> On Thu, 18 Dec 2003, Miroslaw KLABA wrote:
> 
> > My fault...
> > It works now.
> > `while true; do date; sleep 1; done` counts well now.
> > Thanks.
> > But now, how may I help to find this bug in apic code?
> 
> Thanks for verifying that Miroslaw, could you also test the following
> patch (against 2.4.23) ?
> 
> Ta,
> 	Zwane
> 
> Index: linux-2.4.23/include/asm-i386/smpboot.h
> ===================================================================
> RCS file: /build/cvsroot/linux-2.4.23/include/asm-i386/smpboot.h,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 smpboot.h
> --- linux-2.4.23/include/asm-i386/smpboot.h	4 Dec 2003 22:20:21
> -0000	1.1.1.1
> +++ linux-2.4.23/include/asm-i386/smpboot.h	18 Dec 2003 17:19:28 -0000
> @@ -57,7 +57,7 @@ static inline void detect_clustered_apic
>  #define esr_disable (0)
>  #define detect_clustered_apic(x,y)
>  #define INT_DEST_ADDR_MODE (APIC_DEST_LOGICAL)	/* logical delivery */
> -#define INT_DELIVERY_MODE (dest_LowestPrio)
> +#define INT_DELIVERY_MODE (dest_Fixed)
>  #endif /* CONFIG_X86_CLUSTERED_APIC */
>  #define BAD_APICID 0xFFu
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


