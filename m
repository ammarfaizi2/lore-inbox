Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWFUVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWFUVwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWFUVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:52:34 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:51882 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751138AbWFUVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:52:33 -0400
Date: Wed, 21 Jun 2006 23:51:57 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: hpa@zytor.com, mbligh@mbligh.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for `cmp' [was Re: 2.6.17-mm1]
Message-ID: <20060621215157.GA3798@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, hpa@zytor.com,
	mbligh@mbligh.org, linux-kernel@vger.kernel.org,
	Chuck Ebbert <76306.1226@compuserve.com>
References: <44998DCB.1030703@mbligh.org> <20060621184814.GQ24595@inferi.kami.home> <44999BC5.7060702@zytor.com> <20060621193932.GR24595@inferi.kami.home> <20060621134215.1bca6a5c.akpm@osdl.org> <20060621211616.GB4638@inferi.kami.home> <20060621143450.41129b01.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621143450.41129b01.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-rc4-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 02:34:50PM -0700, Andrew Morton wrote:
> On Wed, 21 Jun 2006 23:16:17 +0200
> Mattia Dongili <malattia@linux.it> wrote:
> 
> > On Wed, Jun 21, 2006 at 01:42:15PM -0700, Andrew Morton wrote:
> > > On Wed, 21 Jun 2006 21:39:32 +0200
> > > Mattia Dongili <malattia@linux.it> wrote:
> > > 
> > > > Thanks, this is fixed, but I have a new failure:
> > > >   CC [M]  fs/xfs/support/move.o
> > > >   CC [M]  fs/xfs/support/uuid.o
> > > >   LD [M]  fs/xfs/xfs.o
> > > >   CC      fs/dnotify.o
> > > >   CC      fs/dcookies.o
> > > >   LD      fs/built-in.o
> > > >   CC [M]  fs/binfmt_aout.o
> > > > {standard input}: Assembler messages:
> > > > {standard input}:160: Error: suffix or operands invalid for `cmp'
> > > > make[1]: *** [fs/binfmt_aout.o] Error 1
> > > > make: *** [fs] Error 2
> > > 
> > > what the heck?  Can you do `make fs/binfmt_aout.s' then send the relevant
> > > parts of that file?
> > 
> > I can't really tell which is the relevant part other than line 160 :)
> > Full file available here:
> > http://oioio.altervista.org/linux/binfmt_aout.s
> > 
> 
> It's complaining about this:
> 
> #APP
>         addl %ecx,%eax ; sbbl %edx,%edx; cmpl %eax,$-1073741824; sbbl $0,%edx   # dump.u_dsize, sum, flag,
> #NO_APP
> 
> from fs/binfmt_aout.c:154:
> 
>         if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
>                 dump.u_dsize = 0;
>         if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
>                 dump.u_ssize = 0;
> 
> the offending code comes from __range_ok()

thanks for the explanation!

> Mad guess: does reverting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/broken-out/i386-use-c-code-for-current_thread_info.patch
> help?

yes, I didn't build the full kernel but a simple

make fs/binfmt_aout.o

is finally successful.
-- 
mattia
:wq!
