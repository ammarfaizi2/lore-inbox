Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275461AbTHJDOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 23:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275465AbTHJDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 23:14:36 -0400
Received: from waste.org ([209.173.204.2]:53377 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275461AbTHJDOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 23:14:35 -0400
Date: Sat, 9 Aug 2003 22:14:18 -0500
From: Matt Mackall <mpm@selenic.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       jmorris@intercode.com.au, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030810031418.GW31810@waste.org>
References: <20030809074459.GQ31810@waste.org> <20030809143314.GT31810@waste.org> <1060481247.31499.62.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060481247.31499.62.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 07:07:27PM -0700, Robert Love wrote:
> On Sat, 2003-08-09 at 07:33, Matt Mackall wrote:
> 
> > - the random number generator is non-optional because it's used
> >   various things from filesystems to networking
> 
> What if you kept crypto API optional, made random.c a config option, and
> make that depend on the crypto API. Then -- and this is the non-obvious
> part -- implement a super lame replacement for get_random_bytes() [what
> I assume the various parts of the kernel are using] for when
> !CONFIG_RANDOM is not set?
> 
> You can do a simple PRNG in <10 lines of C. Have the kernel seed it on
> boot with xtime or something else lame.

Eek, let's not go there. Most of the users of get_random_bytes()
depend on it being strong enough for cryptographic purposes. And we've
long guaranteed the existence of a cryptographically strong
/dev/urandom. If userspace could no longer rely on it being there,
people would be forced to go back to poorly reinventing it in
userspace - not good. Having random.c be nonoptional is a good note to
embedded folks that they should think long and hard before ripping it
out.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
