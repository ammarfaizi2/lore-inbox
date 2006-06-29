Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWF2RUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWF2RUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWF2RUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:20:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64952 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751073AbWF2RUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:20:53 -0400
Date: Thu, 29 Jun 2006 19:20:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ulrich Drepper <drepper@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Jason Baron <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
Message-ID: <20060629172036.GB2947@elf.ucw.cz>
References: <1151071581.3204.14.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com> <1151072280.3204.17.camel@laptopd505.fenrus.org> <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com> <20060627095632.GA22666@elf.ucw.cz> <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com> <20060628194913.GA18039@elf.ucw.cz> <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com> <20060629073033.GF27526@elf.ucw.cz> <1151582323.23785.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151582323.23785.16.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > PROT_READ to be used or implicitly adding it.  Don't confuse people
> > > with wrong statement like yours.
> > 
> > Can you quote part of POSIX where it says that PROT_WRITE must imply
> > PROT_READ?
> 
> I don't believe POSIX cares either way
> 
> "An implementation may permit accesses other than those specified by
> prot; however, if the Memory Protection option is supported, the
> implementation shall not permit a write to succeed where PROT_WRITE has
> not been set or shall not permit any access where PROT_NONE alone has
> been set."
> 
> However the current behaviour of "write to map read might work some days
> depending on the execution order of instructions" (and in some cases the
> order that the specific CPU does its tests for access rights) is not
> sane, not conducive to application stability and not good practice.

Well, some architectures may have working PROT_WRITE without
PROT_READ. If you are careful and code your userland application in
assembly, it should work okay.

On processors where that combination depends randomly depending on
phase of moon (i386, apparently), I guess change is okay. But the
patch disabled PROT_WRITE w/o PROT_READ on _all_ processors.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
