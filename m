Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWHXVRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWHXVRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHXVRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:17:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030392AbWHXVRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:17:16 -0400
Date: Thu, 24 Aug 2006 23:17:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/4] Inconsistent extern declarations.
Message-ID: <20060824211715.GQ19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433118.3012.117.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156433118.3012.117.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:25:18PM +0100, David Woodhouse wrote:

> When you compile multiple files together with --combine, the compiler
> starts to _notice_ when you do things like this in one file:
> 
>  extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
>                                 struct iovec *iov, int len, int noblock);
> 
> .. but the actual function looks like this:
> 
>  extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
>                                 struct iovec *iov, size_t len, int noblock);
> 
> This fixes a bunch of those, which are mostly just a missing 'const' on
> the extern declaration.
>...

Nice.

This is a subset of -Wmissing-prototypes warnings, and I'm working for 
some time to get the function prototypes into header files to avoid such 
bugs (that can in some cases lead to nasty stack corruptions).

But they should be fixed properly by moving the prototypes to header 
files.

> dwmw2

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

