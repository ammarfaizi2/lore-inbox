Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUJENks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUJENks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUJENkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:40:47 -0400
Received: from iPass.cambridge.arm.com ([193.131.176.58]:42999 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S269101AbUJENkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:40:22 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Richard Earnshaw <Richard.Earnshaw@arm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20041005141452.B6910@flint.arm.linux.org.uk>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com>
	 <1096931899.32500.37.camel@localhost.localdomain>
	 <loom.20041005T130541-400@post.gmane.org>
	 <20041005125324.A6910@flint.arm.linux.org.uk>
	 <1096981035.14574.20.camel@pc960.cambridge.arm.com>
	 <20041005141452.B6910@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096983608.14574.32.camel@pc960.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 14:40:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 14:14, Russell King wrote:

> > Why don't you pass s to is_arm_mapping_symbol and have it do the same
> > thing as you've done in get_ksymbol?
> 
> "sym_entry" is not an ELF symtab structure - it's a parsed version
> of the `nm' output, and as such does not contain the symbol type nor
> binding information.
> 

Ah.  That makes the question in your previous message make more sense
then.  What options do you pass to nm?

Looking at the output of nm -fsysv shows that currently the mapping
symbols are being incorrectly typed (the EABI requires them to be
STT_NOTYPE, but the previous ELF specification -- not supported by GNU
utils -- required them to be typed by the data they addressed.  I'll
submit a patch for that shortly).

> > ----------------------------------------------------------------
> > This e-mail message is intended for the addressee(s) only and may
> > contain information that is the property of, and/or subject to a
> > ...
> Does this apply to your message?  It would appear that third parties
> subscribed to linux-kernel are not allowed to read your messages
> because they're not an "intended recipient" !

In this case no, which is why I reposted the message without it.  It was
an oversight (I have to remove the boilerplate when I *don't* need it
rather than add it when I do).

R.
