Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWGAW4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWGAW4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGAW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:56:30 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:47299 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751419AbWGAW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:56:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Twreaw5esGuuYI5gtKifHgvo3/19MhNhh9MMTov7G9BmZdNk5X+XdRhE/6Yz1mgrc/MO8icdaJ24UQlHUwS7VQT8+ONWWohvzSXwKmdG4QxwV+3O2sfNTS0YcBAHR8sMLIMxqSl22MVr6m0Ve2eWnIjYNi7ZpsAq3wl2PfOoP/A=
Message-ID: <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>
Date: Sat, 1 Jul 2006 15:56:28 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, Miles Lane <miles.lane@gmail.com> wrote:
> On 7/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sat, 2006-07-01 at 14:25 -0700, Miles Lane wrote:
> > > On 7/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > > On Sat, 2006-07-01 at 14:09 -0700, Miles Lane wrote:
> > > > > I am getting this:
> > > > >
> > > > >   KLIBCLD usr/klibc/libc.so
> > > > > usr/klibc/execl.o: In function `execl':
> > > > > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > > > > usr/klibc/execle.o: In function `execle':
> > > > > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > > > > usr/klibc/execvpe.o: In function `execvpe':
> > > > > usr/klibc/execvpe.c:75: undefined reference to `__stack_chk_fail'
> > > > > usr/klibc/execlp.o: In function `execlp':
> > > > > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > > > > usr/klibc/execlpe.o: In function `execlpe':
> > > > > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > > > > usr/klibc/vfprintf.o:usr/klibc/vfprintf.c:26: more undefined
> > > > > references to `__stack_chk_fail' follow
> > > > > make[2]: *** [usr/klibc/libc.so] Error 1
> > > > >
> > > > > But I've searched all the .h and .c files in the tree and found no
> > > > > reference to __stack_chk_fail.  I am running Ubuntu's Edgy Eft (the
> > > > > latest development tree).
> > > >
> > > > somehow you're getting -fstack-protector added to your CFLAGs.. which
> > > > won't do you any good unless you link to glibc or another library that
> > > > implements the user side of the feature...
> > >
> > > The only reference to -fstack-protector in my linux kernel tree is here:
> >
> >
> > try looking at your CFLAGS environment variable.. that may get
> > inherited ;)
>
> https://wiki.ubuntu.com/GccSsp
>
> It appears that Ubuntu's Edgy Eft (the development tree) now contains
> "Stack Smashing Protection" enabled by default.  I found a web page
> that states that -fno-stack-protector can be used to disable this
> functionality.  Interestingly, another web page stated that SSP has
> been enabled in Redhat compilers for a long time and is now also
> enabled in Debian SID.  Perhaps -fno-stack-protector should be added
> to the kernel build be default?

Darn it.  I don't seem to know how to get -fno-stack-protector to
work.  I ran:
export CFLAGS=-fno-stack-protector
make mrproper
cp ../.config .
make oldconfig
CFLAGS=-fno-stack-protector make all install modules modules_install

But I am still getting the errors.  Anyone know what I am doing wrong?

Thanks,
        Miles
