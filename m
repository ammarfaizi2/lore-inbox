Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUJDXSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUJDXSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUJDXSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:18:24 -0400
Received: from ozlabs.org ([203.10.76.45]:27353 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268677AbUJDXSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:18:22 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Rusty Russell <rusty@rustcorp.com.au>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <tnxllemvgi7.fsf@arm.com>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041001211106.F30122@flint.arm.linux.org.uk>  <tnxllemvgi7.fsf@arm.com>
Content-Type: text/plain
Message-Id: <1096931899.32500.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 09:18:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 22:01, Catalin Marinas wrote:
> Russell,
> 
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > + * This ignores the intensely annoying "mapping symbols" found
> > + * in ARM ELF files: $a, $t and $d.
> > + */
> > +static inline int is_arm_mapping_symbol(const char *str)
> > +{
> > +	return str[0] == '$' && strchr("atd", str[1]) && str[2] == '\0';
> 
> str[2] can be '\0' or '.', since a mapping symbol can also be
> $[atd].<any> (because binutils doesn't like to generate duplicate
> local labels).

Color me confused...

Russell, I thought about not including any symbol which is not of form
"[A-Za-z0-9_]+" in kallsyms, for all archs: you are not the only one
with weird-ass symbols.  Is it that you want these mapping symbols in
/proc/kallsyms but ignored in backtraces, or you don't need them in
kallsyms altogether?

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

