Return-Path: <linux-kernel-owner+w=401wt.eu-S965134AbWLTPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWLTPlL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWLTPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:41:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3242 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965134AbWLTPlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:41:10 -0500
Date: Wed, 20 Dec 2006 15:40:56 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       james.bottomley@steeleye.com, Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
Message-ID: <20061220154056.GA4261@ucw.cz>
References: <457FA840.5000107@hitachi.com> <20061213132358.ddcaaaf4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213132358.ddcaaaf4.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > When a new process is created, the process inherits the coremask
> > setting from its parent. It is useful to set the coremask before
> > the program runs. For example:
> > 
> >   $ echo 1 > /proc/self/coremask
> >   $ ./some_program
> 
> The requirement makes sense, I guess.
> 
> Regarding the implementation: if we add
> 
> 	unsigned char coredump_omit_anon_memory:1;
> 
> into the mm_struct right next to `dumpable' then we avoid increasing the
> size of the mm_struct, and the code gets neater.
> 
> 
> Modification of this field is racy, and we don't have a suitable lock in
> mm_struct to fix that.  I don't think we care about that a lot, but it'd be
> best to find some way of fixing it.
> 
> 
> Really we should convert binfmt_aout.c and any other coredumpers too.
> 
> 
> Does this feature have any security implications?  For example, there might
> be system administration programs which force a coredump on a "bad"
> process, and leave the core somewhere for the administrator to look at. 
> With this change, we permit hiding of that corefile's anon memory from the
> administrator.  OK, lame example, but perhaps there are better ones.

User can already ulimit -c 0 on himself, perhaps we want to use same
interface here? ulimit -cmask=(bitmask)?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
