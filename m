Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292921AbSBVQGT>; Fri, 22 Feb 2002 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292922AbSBVQGJ>; Fri, 22 Feb 2002 11:06:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292921AbSBVQF7>;
	Fri, 22 Feb 2002 11:05:59 -0500
Message-ID: <3C766C66.8EF68046@mandrakesoft.com>
Date: Fri, 22 Feb 2002 11:05:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
		<20020207234555.N17426@altus.drgw.net>
		<5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
		<d37kp5v9y5.fsf@lxplus050.cern.ch>
		<3C7660F5.FC238A7E@mandrakesoft.com>
		<15478.25001.512565.628500@trained-monkey.org>
		<3C76631C.E685815D@mandrakesoft.com> <15478.25845.343591.883309@trained-monkey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> 
> >>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> Jeff> Jes Sorensen wrote:
> >>  Why? CONFIG_$ARCH only makes sense if you can enable two
> >> architectures in the same build. What does CONFIG_M68K give you that
> >> __mc68000__ doesn't provide?
> 
> Jeff> 1) it is a Linux kernel standard.  all arches save two define
> Jeff> CONFIG_$arch.
> 
> Ehm, what standard? the standard way has always been ARCH==, CONFIG_PPC
> used to be the only place using this and all it did was to make things
> uglier and inconsistent.

*shrug*  I've known about this for years.  And every arch but m68k and
cris follows the standard.


> Jeff> 2) you have two tests, "ARCH==m68k" in config.in and "__mc68000__"
> Jeff> in C code.  CONFIG_M68K means you only test one symbol, the same
> Jeff> symbol, in all code.
> 
> If you want to do that, then one should use CONFIG_<ARCH> in the
> Makefiles as well.

I'm betting a few special makefiles require $ARCH information when
.config is info is not available.  Otherwise, agreed.


> Jeff> 3) as this thread shows, due to #1, users -expect- that
> Jeff> CONFIG_M68K will exist
> 
> Ehm, most kernel developers will expect ARCH== in Config.in as thats
> how it's always been.

and I forgot about this flat-out bug:

4) you cannot test ARCH==m68k as a component of dep_xxx declarations. 
And yes, this is a requirement, this is used currently in */config.in
all over the kernel tree.

	Jeff


-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
