Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUHQO3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUHQO3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQO17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:27:59 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:14439 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268267AbUHQOXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:23:22 -0400
Date: Tue, 17 Aug 2004 18:23:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Keith Owens <kaos@ocs.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040817162323.GA7689@mars.ravnborg.org>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Keith Owens <kaos@ocs.com.au>, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <6450.1092747900@ocs3.ocs.com.au> <41220FEA.9050106@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41220FEA.9050106@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 03:02:18PM +0100, Paulo Marques wrote:
> >
> >kdb uses aliased symbols as well.  The user can enter any kernel symbol
> >name and have it converted to an address.
> 
> Ok, I'll leave them alone, then.
> 
> Just another quick question: is kallsyms_names only used by the 
> functions in kallsyms.c and everyone else simply uses those functions, 
> or are there direct users of kallsyms_names?
> 
> This is because another thing I was pondering was to change the stem 
> compression scheme into a different one, changing all the stuff in 
> kallsyms.c accordingly. If there are direct users of kallsyms_names, 
> this would break them. There are none in the vanilla kernel as far as I 
> can grep, but there might be outside (like in kdb).
> 
> I've done some tests with a different scheme and my uncompressed 170kb 
> symbol table goes to about 134kb with stem compression and to about 90kb 
> with the new scheme. This is not usable right now because compression 
> still takes a long time (although the decompression inside 
> kernel/kallsyms.c is even simpler than it is now). I'm now trying to 
> speed up compression.
> 
> As always, comments will be greatly appreciated :)

Hi Paulo.

kallsyms_names should only be used by kallsyms, so there
are no issue changing this interface.
That said do not put too much effort moving kode from the kernel to
kallsyms.c. kallsyms support can be deselected, and users will not
care about the little extra overhead (down in noise compared
with the symbols).
Keeping the data passed in from the build tools as simple as possible
is the better goal here. Then the kernel can implement the extra
code to optimize speed.



kallsyms parses the output of objdump as does other tools in the kernel.
Would you be willing to look into an elf-tool for the kernel?

A consistent output from an Elf-tool is preferred as replacement
for the hacking needed to use output from objdump and nm.
See arch/sparc/boot/btfixup as a horrid example.

objdump and nm has been optimised for human readable output,
and is not easy to parse up for various tricky usage.

Rusty Russell's module-init-tools has some good starting stuff.

PS. Please cc: me on future patches in this area - thanks.

	Sam
