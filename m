Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSKCT1s>; Sun, 3 Nov 2002 14:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSKCT1s>; Sun, 3 Nov 2002 14:27:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10256 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262358AbSKCT1E>; Sun, 3 Nov 2002 14:27:04 -0500
Message-Id: <200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Sun, 3 Nov 2002 22:20:25 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <20021103103710.D10988@devserv.devel.redhat.com> <1036340502.29642.36.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1036340502.29642.36.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 14:21, Alan Cox wrote:
> On Sun, 2002-11-03 at 15:37, Jakub Jelinek wrote:
> > On Sun, Nov 03, 2002 at 04:14:26PM -0200, Denis Vlasenko wrote:
> > > Here is the cure: force_inline will guarantee inlining.
> > >
> > > To use _only_ with functions which meant to be almost
> > > optimized away to nothing but are large and gcc might decide
> > > they are _too_ large for inlining.
> >
> > Well, you can as well bump -finline-limit, like
> > -finline-limit=2000. The default is too low for kernel code (and
> > glibc too).
>
> I would venture the reverse interpretation for modern processors, the
> kernel inlines far far too much

I agree that there are far too many large inlines. But.

__constant_c_and_count_memset *has to* be inlined.
There is large switch statement which meant to be optimized out.
It does optimize out *only if* count is compile-time constant.
--
vda
