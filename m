Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUFGJBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUFGJBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFGJBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:01:15 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:45789 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264352AbUFGJBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:01:11 -0400
Subject: Re: Re: building MINIX on LINUX using gcc
From: James Buchanan <buchanan@iinet.net.au>
To: ckkashyap@spymac.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040607083648.489254C050@spy10.spymac.net>
References: <20040607083648.489254C050@spy10.spymac.net>
Content-Type: text/plain
Message-Id: <1086598881.2226.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 19:01:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >PS. Get the official MINIX sources, and use a XX-to-YY translator or
> Where do I get the official sources from?

http://www.cs.vu.nl/pub/minix/

> What can I do to make it loadable by GRUB or so. I understand that /minix is a concatination of the various a.outs. Can I write a tiny executable 
> that will get loaded by GRUB that loaded /minix beyond 1M. Are there many initializations that need to be done before this?

You have to modify the startup code to accept the multiboot structure
and do something with it.  You can compile it into an ELF image if you
want to, nothing wrong with that.  Then compile the MM and FS tasks as
a.out executables and specify them as modules on the GRUB command line,
and load them from the kernel to the place you want them (much easier
than the nasty way it's done so far).  You'd need to make extensive
modifications.

I suggest using GRUB to chainload instead.  You put the Minix bootsector
and boot program into the Minix partition and GRUB can chainload from
there.  No modification of sources needed for that.

Minix expects certain areas of its compiled binary to be patched by
boot, so don't make it a multiboot compliant kernel and load the servers
separately without knowing what you're doing.  So chainloading with GRUB
is by far the easiest way to go.

Have fun :)

James


