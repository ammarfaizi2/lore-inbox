Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRCBOSB>; Fri, 2 Mar 2001 09:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRCBORv>; Fri, 2 Mar 2001 09:17:51 -0500
Received: from [62.172.234.2] ([62.172.234.2]:30679 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129172AbRCBORl>; Fri, 2 Mar 2001 09:17:41 -0500
Date: Fri, 2 Mar 2001 14:15:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
cc: linux-kernel@vger.kernel.org
Subject: Re: ftruncate not extending files?
In-Reply-To: <Pine.SGI.4.10.10103021611250.3250157-100000@Sky.inp.nsk.su>
Message-ID: <Pine.LNX.4.21.0103021347010.1321-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Dmitry A. Fedorov wrote:
> On Fri, 2 Mar 2001, bert hubert wrote:
> 
> > > ftruncate() and truncate() may extend a file but they are not required to
> > > do so.
> > 
> > I would've sworn, based on the fact that I saw people do it, that ftruncate
> > was a legitimate way to extend a file - especially useful in combination
> > with mmap().
> 
> lseek and write does it already and need not to duplicate with truncate().
> Using truncate() to extend a file sounds very strange.
> 
> About mmap() SUSv2 says:
> 
> If the size of the mapped file changes after the call to mmap() as a
> result of some other operation on the mapped file, the effect of
> references to portions of the mapped region that correspond to added or
> removed portions of the file is unspecified.
>                                 ^^^^^^^^^^^
> What do you mean about "useful in combination with mmap()" ?
> 
> > I don't really care where it is done, in glibc or in the kernel - but let's
> > honor this convention and not needlessly break code.
> 
> Let's don't connive to ill-formed programs.

Those are not ill-formed programs, they are just ordinary programs.

ftruncate()-to-extend and mmap() go together like knife and fork:
you don't have to use either, and you can use each separately, but
it's conventional to use them together.  The awkward SIGBUS-beyond-EOF
specification of mmap() begs for a call to set filesize; often the man
page of one syscall references the other.

It would be perverse and unhelpful for Linux to offer a filesystem
which supports mmap() but not ftrunctate()-to-extend.

The SuSv2 quotations, above and in other mail, are just weasly.
They probably started off specifying the natural least-surprise
behaviours, which most support; but some vendor who failed to meet
that spec forced the wording to be changed to "unspecified".
That's no reason for Linux to be obstinate.

But I agree "ftruncate" is a confusing name for a syscall to
(truncate or) extend a file: like using a knife to spread glue.

Hugh

