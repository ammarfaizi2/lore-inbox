Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWKEQmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWKEQmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWKEQmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:42:47 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:7042 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1161334AbWKEQmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:42:46 -0500
Date: Sun, 5 Nov 2006 14:42:37 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: Top 100 inline functions (make allyesconfig) was Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061105164236.GA3363@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org> <20061103190729.GB25363@mandriva.com> <20061104210330.GA6028@mandriva.com> <20061105063037.GU13381@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061105063037.GU13381@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 07:30:37AM +0100, Adrian Bunk wrote:
> On Sat, Nov 04, 2006 at 06:03:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Nov 03, 2006 at 04:07:29PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Oct 30, 2006 at 08:33:34PM -0800, Andrew Morton wrote:
> > > > On Mon, 30 Oct 2006 18:33:19 -0300
> > > > Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:
> > > > 
> > > > > 	Further ideas on how to use the DWARF2 information include tools
> > > > > that will show where inlines are being used, how much code is added by
> > > > > inline functions,
> > > > 
> > > > It would be quite useful to be able to identify inlined functions which are
> > > > good candidates for uninlining.
> > > 
> > > Top 50 inline functions expanded more than once by sum of its expansions
> > > in a vmlinux file built for qemu, most things are modules, columns are
> > > (inline function name, number of times it was expanded, sum in bytes of
> > > its expansions, number of source files where expansions ocurred):
> > > 
> > > [acme@newtoy guinea_pig-2.6]$ pfunct --total_inline_stats
> > > ../../acme/OUTPUT/qemu/net-2.6/vmlinux | grep -v ': 1 ' | sort -k3 -nr |
> > > head -50
> > > 
> > > get_current                        676   5732 155
> > 
> > Ok, this time for a 'make allyesconfig' build, top 100, for the list of
> > all 6021 inline functions that were expanded more than once in this 281
> > MB vmlinux image download the 93 KB files at:
> >...
> 
> Thanks, this is interesting data.
> 
> One thing you could do for improving the result:
> 
> allyesconfig turns on all debugging option, and there might be functions 
> that are significantely larger due to this fact.
> 
> Unsetting *DEBUG* options in the .config might bring a better focus 
> on the real-world problems.

Sure thing, I did it with allyesconfig to see if the tools were able to
handle that much data, its not perfect, far from it, but it works on my
notebook :-) Neverthless its already a data point for lots of
interesting cases.

One thing I'll do is to get the debug rpms in, say, Mandriva, Fedora,
etc and use them as more down to earth guinea pigs, for that I'll add
support for multi file, not just for multi object, single file ELF
files. Also just using the config files used in major distros is on my
TODO list, of course enabling the extra config options needed to have
the DWARF2 elf sections needed by the tools, these sections don't affect
the binary, are just extra ELF sections, that the 'strip(1)' tool loves
:-)

Stay tuned,

- Arnaldo
