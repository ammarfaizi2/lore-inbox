Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWHKPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWHKPRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWHKPRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:17:03 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:39849 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751176AbWHKPRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:17:02 -0400
Date: Fri, 11 Aug 2006 17:16:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [67/145] x86_64: Detect CFI support in the assembler at runtime
Message-ID: <20060811151638.GA9211@mars.ravnborg.org>
References: <20060810935.775038000@suse.de> <20060810193623.1923113B90@wotan.suse.de> <20060811053932.GA4910@mars.ravnborg.org> <200608110755.58676.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608110755.58676.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 07:55:58AM +0200, Andi Kleen wrote:
> On Friday 11 August 2006 07:39, Sam Ravnborg wrote:
> > > +# as-instr
> > > +# Usage: cflags-y += $(call as-instr, instr, option1, option2)
> > > +
> > > +as-instr = $(shell if echo -e "$(1)" | $(AS) -Z -o /dev/null \
> > > +		   2>&1 >/dev/null ; then echo "$(2)"; else echo "$(3)"; fi;)
> > 
> > Have you checked that as will not delete yout /dev/null if you build as
> > root? ld do so if you specify /dev/null as output file.
> 
> No. But it's probably safter to do it otherwise. Do you have an alternative?

ld-option uses this:
# ld-option
# Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
ld-option = $(shell if $(CC) $(1) \
                       -nostdlib -o ldtest$$$$.out -xc /dev/null \
             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
             rm -f ldtest$$$$.out)

$$$$ becomes $$ when executed.

I have no better alternatives - except maybe for mktemp.

	Sam
