Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUEFNha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUEFNha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEFNfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:35:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28679 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262109AbUEFNZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:25:03 -0400
Date: Thu, 6 May 2004 14:24:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get rid of "+m" constraint in i386 rwsems
Message-ID: <20040506142454.C29621@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Richard Henderson <rth@twiddle.net>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040506131846.A29621@flint.arm.linux.org.uk> <4955.1083844733@redhat.com> <20040506131846.A29621@flint.arm.linux.org.uk> <5170.1083848296@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5170.1083848296@redhat.com>; from dhowells@redhat.com on Thu, May 06, 2004 at 01:58:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 01:58:16PM +0100, David Howells wrote:
> > Can you explain the need for the change?
> 
> gcc-3.4 generates warnings about it:
> 
> include/asm/rwsem.h: In function `avc_audit':
> include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
> include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
> 
> The gcc people (or at least one of them) seem to think that these warnings are
> correct on a "+m" constraint. See:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=107475162200773&w=2
> 
> I understood "+m" to be a shorthand way of specifying "=m" and "m" on the same
> bit of memory, but apparently it that's not what it means.

After reading Richard's post, I wonder if, in the case of:

	"=m" (x) : "m" (x)

whether assembly should assume that %0 is the same as %1.  Do they
just happen to be the same thing?  I'm thinking of the case where
there may be two different ways GCC may reference the same memory
location.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
