Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271227AbTGWTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271236AbTGWTSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:18:47 -0400
Received: from verein.lst.de ([212.34.189.10]:23187 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S271235AbTGWTRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:17:46 -0400
Date: Wed, 23 Jul 2003 21:32:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030723193246.GA836@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	uClinux development list <uclinux-dev@uclinux.org>,
	linux-kernel@vger.kernel.org
References: <200307232046.46990.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307232046.46990.bernie@develer.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 08:46:46PM +0200, Bernardo Innocenti wrote:
> Hello,
> 
> code bloat can be very harmful on embedded targets, but it's
> generally inconvenient for any platform. I've measured the
> code increase between 2.4.21 and 2.6.0-test1 on a small
> kernel configuration for ColdFire:
> 
>    text    data     bss     dec     hex filename
>  640564   39152  134260  813976   c6b98 linux-2.4.x/linux
>  845924   51204   78896  976024   ee498 linux-2.5.x/vmlinux
> 
> I could provide the exact .config file for both kernels to
> anybody interested. They are almost the same: no filesystems
> except JFFS2, IPv4 and a bunch of small drivers. I have no
> SMP, security, futexes, modules and anything else not
> strictly needed to execute processes.

Yes, we need to get this down again.  What compiler and compiler
flags are you using?  Could you retry with the following ripped
from include/linux/compiler.h:

#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
#define inline          __inline__ __attribute__((always_inline))
#define __inline__      __inline__ __attribute__((always_inline))
#define __inline        __inline__ __attribute__((always_inline))
#endif

I'd especially be interested in the fs/ numbers after this.

Also -Os on both would be quite cool.
