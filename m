Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269256AbUJENwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbUJENwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbUJENwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:52:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61448 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269315AbUJENvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:51:48 -0400
Date: Tue, 5 Oct 2004 14:51:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Earnshaw <Richard.Earnshaw@arm.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20041005145140.E6910@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Earnshaw <Richard.Earnshaw@arm.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain> <loom.20041005T130541-400@post.gmane.org> <20041005125324.A6910@flint.arm.linux.org.uk> <1096981035.14574.20.camel@pc960.cambridge.arm.com> <20041005141452.B6910@flint.arm.linux.org.uk> <1096983608.14574.32.camel@pc960.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096983608.14574.32.camel@pc960.cambridge.arm.com>; from Richard.Earnshaw@arm.com on Tue, Oct 05, 2004 at 02:40:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 02:40:08PM +0100, Richard Earnshaw wrote:
> On Tue, 2004-10-05 at 14:14, Russell King wrote:
> 
> > > Why don't you pass s to is_arm_mapping_symbol and have it do the same
> > > thing as you've done in get_ksymbol?
> > 
> > "sym_entry" is not an ELF symtab structure - it's a parsed version
> > of the `nm' output, and as such does not contain the symbol type nor
> > binding information.
> > 
> 
> Ah.  That makes the question in your previous message make more sense
> then.  What options do you pass to nm?

Only -n.

> Looking at the output of nm -fsysv shows that currently the mapping
> symbols are being incorrectly typed (the EABI requires them to be
> STT_NOTYPE, but the previous ELF specification -- not supported by GNU
> utils -- required them to be typed by the data they addressed.  I'll
> submit a patch for that shortly).

Ugg - in that case, we need to go with the "match the name" version
until these changes in binutils have matured (== 2 or 3 years time.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
