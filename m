Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDBW7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUDBW7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:59:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:14519 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261258AbUDBW7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:59:40 -0500
Date: Fri, 2 Apr 2004 15:01:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: chrisw@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040402150152.7675cf7e.akpm@osdl.org>
In-Reply-To: <20040402143639.G21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401170705.Y22989@build.pdx.osdl.net>
	<20040401173034.16e79fee.akpm@osdl.org>
	<20040402133540.1dfa0256.akpm@osdl.org>
	<20040402143639.G21045@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > So I spent a few hours getting pam_cap to work, and indeed it is now doing the
> > right thing.  But the kernel is not.
> 
> Do you have a patch?  Seems it could be useful to get this and libcap back
> up-to-date .

http://www.zip.com.au/~akpm/linux/patches/stuff/pam_cap-akpm.tar.gz

> > 2) the kernel unconditionally removes CAP_SETPCAP in dummy_capget() so
> >    it is not possible for even a root-owned, otherwise-fully-capable task
> >    to raise capabilities on another task.  Period.
> 
> This is how the kernel was before the security stuff went in.  

That's my point, Chris.  "the feature is bollixed, so let's write a ton of
new parallel stuff but not fix the original code".  This is how cruft
accumulates.

> > I must say that I'm fairly disappointed that we developed and merged all
> > that fancy security stuff but nobody ever bothered to fix up the existing
> > simple capability code.
> 
> Our goal was actually to keep is compatible.  All of it's limitations
> predate the security stuff.

Either the fine-grained capabilities are fixable, or they should be deleted
and we go back to suser().  One of those things should have happened before
adding more code, surely?

> I'm not sure, but it likely has to do with anticipating having the fs
> bits of capabilities to do proper setting at execve().  I think basically
> nobody really uses capabilites except in either simple root drops a
> few privs ways (no exec), or within larger security models running as
> kernel modules.

Yup, we've talked about how you can drop caps in this way for *years* but I
don't think many people realised that this emperor is unclad.

> > I'm looking at securebits.h and wondering why that exists - there's no code
> > in-kernel to set the thing, although it is exported to modules.  Perhaps
> > securebits should be exposed in /proc and used to enable
> > retain-caps-across-execve.
> 
> IIRC, changing those (existing) securebits settings creates an unusable
> machine.  Again, I think there was some anticipation of the fs bits
> going in later.  Perhaps those securebits pieces could just be removed.

OK.  Do you have time to do the honours?
