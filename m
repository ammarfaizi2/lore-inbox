Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWADTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWADTMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWADTMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:12:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46609 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964844AbWADTMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:12:48 -0500
Date: Wed, 4 Jan 2006 19:12:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning in 8250.c
Message-ID: <20060104191241.GF3119@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200601031012.49068.vda@ilport.com.ua> <20060104181425.GE3119@flint.arm.linux.org.uk> <20060104181801.GA3605@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104181801.GA3605@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 06:18:01PM +0000, Christoph Hellwig wrote:
> On Wed, Jan 04, 2006 at 06:14:25PM +0000, Russell King wrote:
> > On Tue, Jan 03, 2006 at 10:12:48AM +0200, Denis Vlasenko wrote:
> > >   CC      drivers/serial/8250.o
> > > /.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: 'transmit_chars' declared inline after being called
> > > /.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: previous declaration of 'transmit_chars' was here
> > > 
> > > Since this function is not small, inlining effect is way below noise floor.
> > > Let's just remove _INLINE_.
> > 
> > I think we want to remove _INLINE_ from both receive_chars and
> > transmit_chars.  Both functions aren't small, so...
> 
> While we're at it can we please kill _INLINE_?  Those functions that should
> be inlined can become inline, but this macro just obsfucates the serial code.

No idea - I don't know about x86 nuances and why they wanted:

#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
#define _INLINE_ inline
#else
#define _INLINE_
#endif

Maybe someone in the x86 world needs to comment?  Does the above even
mean that we'll ever inline anything marked _INLINE_ ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
