Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWJ2Wwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWJ2Wwg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 17:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWJ2Wwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 17:52:36 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:16035 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1030397AbWJ2Wwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 17:52:36 -0500
Date: Sun, 29 Oct 2006 23:52:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jan Beulich <jbeulich@novell.com>, jpdenheijer@gmail.com,
       dsd@gentoo.org, draconx@gmail.com, kernel@gentoo.org
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061029225234.GA31648@uranus.ravnborg.org>
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnek9qv0.2vm.olecom@flower.upol.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 05:58:56PM +0000, Oleg Verych wrote:
> 
> On 2006-10-29, Andi Kleen wrote:
> >> Why not use -o /dev/null, as Daniel Drake already suggested in [1]? In
> >> both as-instr and ld-option, the tmp file is being deleted
> >> unconditionally right after its creation anyways.
> >
> > Because then when the compilation runs as root some as versions
> > will delete /dev/null on a error. This has happened in the past.
> 
> OK, but let users, who still build kernels as root, alone.
This needs to work - there are too much people that continue to do so.
And gentoo books recommended this last time I looked.

> 
> In `19-rc3/include/Kbuild.include', just below `as-instr' i see:
> ,--
> |cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
> |             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
> |
> |# cc-option-yn
> |# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
> |cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
> |                 > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
> `--
> so, change to `-o /dev/null' in `as-instr' will just follow this.

gcc does not delete files specified with -o - but binutils does.
So using /dev/null in this case is not an option.

	Sam
