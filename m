Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbTGURsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTGURrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:47:31 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:48103 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S270651AbTGURpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:45:33 -0400
Date: Mon, 21 Jul 2003 20:00:32 +0200
From: Kurt Roeckx <Q@ping.be>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: siginfo pad problem.
Message-ID: <20030721180032.GA26786@ping.be>
References: <20030721142259.GA4315@ping.be> <20030722022424.7480af8e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722022424.7480af8e.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 02:24:24AM +1000, Stephen Rothwell wrote:
> On Mon, 21 Jul 2003 16:23:00 +0200 Kurt Roeckx <Q@ping.be> wrote:
> >
> > It seems the _timer part of siginfo is a little bit broken.
> > 
> > It has:
> >                         char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
> > 
> > Where __ARCH_SI_UID_T can be a short.
> 
> Except __ARCH_SI_UID_T is defined to be uid_t everywhere except sparc
> where it is "unsigned int".  In include/linux/types.h, uid_t is typdef'ed
> to be __kernel_uid32_t (in the kernel), so __ARCH_SI_UID_T is always (at
> least) 32 bits.

linux/types.h has:
#ifdef __KERNEL__
typedef __kernel_uid32_t        uid_t;
#else
typedef __kernel_uid_t          uid_t;
#endif /* __KERNEL__ */

And __kernel_uid_t is an "unsigned short"


Kurt

