Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283362AbRK2SDz>; Thu, 29 Nov 2001 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283357AbRK2SDq>; Thu, 29 Nov 2001 13:03:46 -0500
Received: from sword.damocles.com ([209.100.46.1]:48800 "EHLO
	sword.damocles.com") by vger.kernel.org with ESMTP
	id <S283361AbRK2SDb>; Thu, 29 Nov 2001 13:03:31 -0500
From: Jeff Randall <randall@sword.damocles.com>
Message-Id: <200111291803.fATI37q08404@sword.damocles.com>
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
To: balbir_soni@yahoo.com (Balbir Singh)
Date: Thu, 29 Nov 2001 12:03:07 -0600 (CST)
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com> from "Balbir Singh" at Nov 29, 2001 08:06:37 AM
Reply-To: randall@uph.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> >Err,
> >	close(-ENOMEM);
> 
> >What's that going to close?  Hint: you _can't_ close
> a descriptor that
> >failed to open, since you don't have a descriptor to
> close.  You can
> >only try to close an error code, but that's not going
> to make it anywhere
> >near the kernel driver level.
> 
> Let me make it clearer to you,
> 
> lets say I call rs_open() on /dev/ttyS0 and if it
> fails then I should not call rs_close() after a failed
> rs_open().
> 
> I hope this is clear now.

All of the other UNIX variants I've dealth with behave that way.
However, you cannot just make that change without having some means
of identifying that behavior change because all of the linux
serial drivers have been written to assume that their close()
will be called even after their open() has failed.

I'm not opposed to such a change in behavior, but at least be
sure that it's somehow identifiable (kernel version, a define
set in a header, etc) so that the 3rd party drivers have a means
to identify the change.

Redhat 7.1 included that behavior change in the kernel they shipped
and it caused no end of problems for those of us that were doing
serial drivers since there was no way to easily identify that the
patch had been included.


-- 
randall+lkml@uph.com

