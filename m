Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277788AbRJIPza>; Tue, 9 Oct 2001 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277795AbRJIPzU>; Tue, 9 Oct 2001 11:55:20 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22523 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277788AbRJIPzN>; Tue, 9 Oct 2001 11:55:13 -0400
Date: Tue, 9 Oct 2001 11:55:32 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: kernel size
Message-ID: <20011009115532.K25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <root@chaos.analogic.com> <200110091543.f99FhFVJ009433@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110091543.f99FhFVJ009433@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Tue, Oct 09, 2001 at 11:43:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 11:43:14AM -0400, Horst von Brand wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> said:
> > On Tue, 9 Oct 2001, Ingo Oeser wrote:
> 
> [...]
> 
> > > strip -R .ident -R .comment -R .note
> > > 
> > > is your friend. 
> 
> [...]
> 
> > Yes! Wonderful...
> > -rwxr-xr-x   1 root     root      1571516 Oct  9 10:50 vmlinux
> > -rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD
> > 
> > That got rid of some cruft.
> 
> Yep. A WHOOPing 1.2% of the total. BTW, is this stuff ever being loaded
> into RAM with the executable kernel, discarded on boot, or what?

It is not SHF_ALLOC, so it will not make it into vmlinuz either.

> IMHO, it would be more productive to go after savings via .init*, and
> perhaps bug the GCC/binutils people to merge strings...

?
gcc-2.96-RH (2.96-91 and above) and recent gcc 3.1 CVS together with
recent binutils support merging strings already. Unlike killing
.comment/.note sections, this saves real kernel memory.

This reminds me, I should finally hack up binutils so that it uses SHF_MERGE
for .ident directives automatically.

	Jakub
