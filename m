Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTIFWo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTIFWo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:44:29 -0400
Received: from ns.suse.de ([195.135.220.2]:46553 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262960AbTIFWo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:44:28 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: spurious recompiles
References: <20030906201417.GI14436@fs.tum.de.suse.lists.linux.kernel>
	<33384.4.4.25.4.1062887601.squirrel@www.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Sep 2003 00:44:24 +0200
In-Reply-To: <33384.4.4.25.4.1062887601.squirrel@www.osdl.org.suse.lists.linux.kernel>
Message-ID: <p733cf9lepj.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> > When doing a "make" inside an already compiled kernel source there
> > shouldn't be anything rebuilt. I've identified three places where this
> > isn't the case in recent 2.6 kernels:
> >
> > 1. ikconfig
> >   CC      kernel/configs.o
> > even when the .config wasn't changed
> 
> This is probably the same thing that Steve Hemminger posted about
> yesterday:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106270067411137&w=2
> 
> I posted a patch based on Sam Ravnborg's comments that might fix it,
> but I haven't verified it yet... The patch is in this message:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106272687506379&w=2
> 
> or it may be some other dependency.  I'll look into it.

x86-64 has the same problem. It always rebuilds arch/x86_64/ia32/vsyscall32.so,
no matter if it has changed or not. I have not figured out why it does that.

vsyscall.S is an assembly file which depends on asm/offset.h, which 
is regenerated each build. But the regeneration is written in a way to 
not trigger rebuilds when nothing has changed. That works for everything
else, just apparently not for the vsyscall.S file.

-Andi
