Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJLNRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJLNRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 09:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUJLNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 09:17:30 -0400
Received: from iPass.cambridge.arm.com ([193.131.176.58]:10901 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262406AbUJLNQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 09:16:20 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Richard Earnshaw <Richard.Earnshaw@arm.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <1097057299.5332.15.camel@newt>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com>
	 <1096931899.32500.37.camel@localhost.localdomain>
	 <loom.20041005T130541-400@post.gmane.org>
	 <20041005125324.A6910@flint.arm.linux.org.uk>
	 <1096981035.14574.20.camel@pc960.cambridge.arm.com>
	 <20041005141452.B6910@flint.arm.linux.org.uk>
	 <1096983608.14574.32.camel@pc960.cambridge.arm.com>
	 <20041005145140.E6910@flint.arm.linux.org.uk>
	 <1097057299.5332.15.camel@newt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097586918.23033.24.camel@pc960.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 14:15:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 11:08, Adrian Cox wrote:

> Why does the Linux ARM ABI have to have any relation to the ARM EABI?
> The PowerPC has had two different ABIs for years, and it's not caused us
> any trouble. Can't we just leave the behaviour of binutils alone when
> configured for an arm-linux target, and put all feature churn into an
> arm-eabi target?

Sorry for the delay replying.  The trouble with going on holiday is that
you then have to catch up again...

The primary reason is because we have customers who are asking for it
[linux conforming to the EABI].

On a technical front there's a number of reasons why it would be a good
idea too:

- Natural endian and alignment of all basic types ( => better
compatibility with other Linux ports.  Also *very* important on XScale)

- Better compatibility with Thumb (a major customer demand).

- No more emulation of floating-point instructions that don't exist in
the hardware.

- Future proofing -- the EABI is these days considered at the
architectural level.

- and in C++, an efficient and compact unwinding model.

R.
