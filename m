Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967192AbWKZBKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967192AbWKZBKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967196AbWKZBKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:10:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49091 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S967192AbWKZBKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:10:19 -0500
Date: Sun, 26 Nov 2006 01:10:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: rdreier@cisco.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
Message-ID: <20061126011014.GR3078@ftp.linux.org.uk>
References: <adazmag5bk1.fsf@cisco.com> <20061124.220746.57445336.davem@davemloft.net> <adaodqv5e5l.fsf@cisco.com> <20061125.150500.14841768.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125.150500.14841768.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 03:05:00PM -0800, David Miller wrote:
> From: Roland Dreier <rdreier@cisco.com>
> Date: Sat, 25 Nov 2006 14:56:22 -0800
> 
> >  > Perhaps a better way to fix this is to use
> >  > typeof() like other similar macros do.
> > 
> > I tried doing
> > 
> > #define ALIGN(x,a)				\
> > 	({					\
> > 		typeof(x) _a = (a);		\
> > 		((x) + _a - 1) & ~(_a - 1);	\
> > 	})
> > 
> > but that won't compile because of <net/neighbour.h>:
> 
> You would need to also cast the constants with typeof() to.

Oh, for fsck sake...

	(typeof(x))((x + a - 1) & ~(a - 1ULL))
