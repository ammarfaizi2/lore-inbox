Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271266AbTGWT47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271271AbTGWT47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:56:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:39809 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S271266AbTGWT46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:56:58 -0400
Date: Wed, 23 Jul 2003 13:11:54 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-Id: <20030723131154.472172d0.davem@redhat.com>
In-Reply-To: <20030723193246.GA836@lst.de>
References: <200307232046.46990.bernie@develer.com>
	<20030723193246.GA836@lst.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 21:32:46 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Could you retry with the following ripped
> from include/linux/compiler.h:
> 
> #if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
> #define inline          __inline__ __attribute__((always_inline))
> #define __inline__      __inline__ __attribute__((always_inline))
> #define __inline        __inline__ __attribute__((always_inline))
> #endif

Careful, some platforms won't work with this.

I know that ppc64's switch_to() for example must be inlined or else
the kernel stops working.  It's either the above defines or adding
-finline-limit=100000 to the GCC command line to force it to be
inlined.
