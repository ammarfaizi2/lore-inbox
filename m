Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTCFIDo>; Thu, 6 Mar 2003 03:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267906AbTCFIDn>; Thu, 6 Mar 2003 03:03:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:56798 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267886AbTCFIDn>;
	Thu, 6 Mar 2003 03:03:43 -0500
Date: Thu, 6 Mar 2003 00:14:57 -0800
From: Andrew Morton <akpm@digeo.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: joe@tmsusa.com, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.64
Message-Id: <20030306001457.7537e37a.akpm@digeo.com>
In-Reply-To: <200303060749.h267nPu01086@Port.imtp.ilyichevsk.odessa.ua>
References: <3E66E782.5010502@tmsusa.com>
	<20030305223638.77c22cb7.akpm@digeo.com>
	<200303060749.h267nPu01086@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 08:14:09.0179 (UTC) FILETIME=[5CE4EEB0:01C2E3B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> > Eh?  How come the compiler didn't inline
> > __constant_c_and_count_memset? What compiler version are you using?
> 
> ...
> 
> +/* GCC 3 (and probably earlier, I'm not sure) can be told to always inline
> +   a function. */
> +#if __GNUC__ < 3
> +#define force_inline inline
> +#else
> +#define force_inline inline __attribute__ ((always_inline))
> +#endif

Well I'd consider this a workaround for a rampant compiler bug.  It's just
weird that it refuses to inline a function like that.  Having to make 10,000
edits to the kernel tree to work around this does not appeal.

Cannot we just stick:

	#define inline	__inline__ __attribute__((always_inline))

in kernel.h?


