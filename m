Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbULaNP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbULaNP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 08:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbULaNP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 08:15:59 -0500
Received: from 80-219-198-150.dclient.hispeed.ch ([80.219.198.150]:7555 "EHLO
	xbox.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id S262027AbULaNPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 08:15:55 -0500
From: Thomas Sailer <sailer@scs.ch>
Organization: Supercomputing Systems AG
To: Mike Hearn <mh@codeweavers.com>
Subject: Re: ptrace single-stepping change breaks Wine
Date: Fri, 31 Dec 2004 14:13:16 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, the3dfxdude@gmail.com,
       pouech-eric@wanadoo.fr, dan@debian.org, roland@redhat.com,
       linux-kernel@vger.kernel.org, wine-devel@winehq.com,
       wine-patches@winehq.com, mingo@elte.hu
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <1104401393.5128.24.camel@gamecube.scs.ch> <1104411980.3073.6.camel@littlegreen>
In-Reply-To: <1104411980.3073.6.camel@littlegreen>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311413.16313.sailer@scs.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag 30 Dezember 2004 14.06, you wrote:

> Tom, does this patch against Wine help? It should do the same thing as
> the setarch program, so if that fixes it then this should also (if I've
> understood how this mechanism works of course).

No this doesn't work. The decision which address space layout to use is done 
in arch/i386/mm/mmap.c:arch_pick_mmap_layout, and this function is called by 
the elf loader in fs/binfmt_elf.c:load_elf_binary, i.e. the decision which 
address space layout to use for the current wine process is already done long 
time before your personality syscall takes effect.

I hoped there was some ELF section magic to turn this off (like execshield), 
but there doesn't seem to be.

Tom
