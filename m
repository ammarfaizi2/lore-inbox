Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312366AbSCZQy7>; Tue, 26 Mar 2002 11:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSCZQyu>; Tue, 26 Mar 2002 11:54:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35588 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312366AbSCZQyn>; Tue, 26 Mar 2002 11:54:43 -0500
Date: Tue, 26 Mar 2002 16:54:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Weinehall <tao@acc.umu.se>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: save_flags() should take unsigned long
Message-ID: <20020326165435.D14744@flint.arm.linux.org.uk>
In-Reply-To: <20020304184653.GA8646@elf.ucw.cz> <20020326142955.E16636@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 02:29:55PM +0100, David Weinehall wrote:
> The correct way to fix this would be:
> 
> <in suitable header-file; suggestions welcome>
> typedef flags_t unsigned long;

You mean typedef unsigned long flags_t;

However, people will still write:

{
	int flags;

	save_flags(flags);

because 'int' is faster to type than 'flags_t'.  About the only way
you're going to stop it dead is to do:

   typedef struct { unsigned long val; } flags_t;

and then save_flags(x)/restore_flags(x) use (x).val

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

