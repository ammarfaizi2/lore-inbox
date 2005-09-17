Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVIQH1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVIQH1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVIQH1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:27:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5905 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750894AbVIQH1p (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:27:45 -0400
Date: Sat, 17 Sep 2005 08:27:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: zippel@linux-m68k.org, nickpiggin@yahoo.com.au,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
Message-ID: <20050917072736.GA16523@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	zippel@linux-m68k.org, nickpiggin@yahoo.com.au,
	Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
References: <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk> <Pine.LNX.4.61.0509170234180.3743@scrub.home> <20050917.001822.46482906.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917.001822.46482906.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 12:18:22AM -0700, David S. Miller wrote:
> > My biggest problem here is the lack of gcc support to get the
> > condition code out of an asm.
> 
> I agree, this is the biggest deficiency in gcc inline assembly and I
> run into it all the time.

gcc did have some support to pass condition codes into assembly.
On ARM, you used to be able to do things like:

	if (foo)
		asm("blah%?	whatever");

and gcc would replace %? with whatever condition was appropriate
for the current block of code.  You can still write it as the
above.

However, this optimisation was disabled on ARM apparantly because
it was very hard to for people to get correct - if you forgot the
%?, you need to add a "cc" clobber, and if you forget that as well
you might get unconditional behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
