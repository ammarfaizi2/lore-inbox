Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313365AbSDOXYc>; Mon, 15 Apr 2002 19:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313366AbSDOXYb>; Mon, 15 Apr 2002 19:24:31 -0400
Received: from zero.tech9.net ([209.61.188.187]:42770 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313365AbSDOXYa>;
	Mon, 15 Apr 2002 19:24:30 -0400
Subject: Re: [Patch] Compilation error on 2.5.8
From: Robert Love <rml@tech9.net>
To: Bongani <bonganilinux@mweb.co.za>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1018913727.2688.118.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 19:24:29 -0400
Message-Id: <1018913070.3399.37.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-15 at 19:34, Bongani wrote:

> Does this also look cleaner ?

> -static inline void setup_per_cpu_areas(void)
> -{
> -}
> +
> +#define setup_per_cpu_areas()  do { } while(0)
> +

Personally yes, but others would disagree.

In fact, if we use a define setup_per_cpu_areas can not be used outside
of this compilation unit.  Right now this looks to be the case, but if
something other than init/main.c wanted to use setup_per_cpu_areas we
would need to make the code an actual function or put the define in a
header file.

Since either case should optimize away, maybe we should make it a static
inline in both cases, since that is the authors original preference ...

	Robert Love

