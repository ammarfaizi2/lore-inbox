Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270014AbUJHPYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbUJHPYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270015AbUJHPYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:24:37 -0400
Received: from open.hands.com ([195.224.53.39]:38608 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S270014AbUJHPY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:24:27 -0400
Date: Fri, 8 Oct 2004 16:35:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008153523.GK5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <1097240824.4389.26.camel@lfs.barra.bali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097240824.4389.26.camel@lfs.barra.bali>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 10:07:04AM -0300, Fabiano Ramos wrote:
> On Fri, 2004-10-08 at 14:04 +0100, Luke Kenneth Casson Leighton wrote:
> > could someone kindly advise me on the location of some example code in
> > the kernel which calls one of the userspace system calls from inside the
> > kernel?
> > 
> > alternatively if this has never been considered before, please could
> > someone advise me as to how it might be achieved?
> > 
> 
> you cannot do that. For every sys_xx there is a do_xx, that can
> be called from inside the kernel.
 
 so, there's a do_rename (yes i found that and ISTRC that when
 i used it i can't exactly remember what the problem was:
 either i got an error code -14 or i got "warning symbol
 do_rename not found" when my module was linked together,
 even though it says EXPORT_SYMBOL(do_rename) in fs/namei.c,
 so i was forced to cut/paste sys_rename)

 and there's a do_open no there isn't, there's filp_open.

 and a do_pread64 no there isn't i had to cut/paste sys_pread64
 which was okay because it's pretty basic, just call vfs_read.

 and a do_mkdir no there isn't so i had to cut/paste that.


 basically what i am doing is writing a file system "proxy"
 module which re-calls back into the filesystem with a prefix
 onto the front of the pathname.

> > [p.s. i found asm/unistd.h, i found the macros syscall012345
> > etc., i believe i don't quite understand what these are for, and
> > may be on the wrong track.]
> 
> These are are available for you to make syscalls from user mode
> without library support (usually that brand new syscall you added).
> They are basically wrappers that expand into C code. _syscallx, 
> where x is the number of arguments the syscall needs.
 
 so, it's for use the other way round.  okay, thanks for keeping me off
 a broken line of enquiry.

 [oh, and i'll be abandoning this line of enquiry _entirely_ if i find
 that supermount-ng can do the same job - namely manage to keep
 userspace programs happy when users rip out media]
 
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

