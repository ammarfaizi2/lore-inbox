Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281669AbRKUIJl>; Wed, 21 Nov 2001 03:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281670AbRKUIJb>; Wed, 21 Nov 2001 03:09:31 -0500
Received: from gate.mesa.nl ([194.151.5.70]:24585 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281669AbRKUIJO>;
	Wed, 21 Nov 2001 03:09:14 -0500
Date: Wed, 21 Nov 2001 09:08:54 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make modules_install fails with latest fileutils
Message-ID: <20011121090854.A15851@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011120193820.A14068@joshua.mesa.nl> <1128.1006303946@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1128.1006303946@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, Nov 21, 2001 at 11:52:26AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:52:26AM +1100, Keith Owens wrote:
> On Tue, 20 Nov 2001 19:38:20 +0100, 
> "Marcel J.E. Mol" <marcel@mesa.nl> wrote:
> >Just had some problems doing a modules_install with
> >fileutils-1.1.1-1 (redhat rawhide). The cp command
> >in there gives a non-zero return value when it is asked
> >to copy the same file in the argument list:
> >
> >--- Rules.make.org	Tue Nov 20 19:36:16 2001
> >+++ Rules.make	Mon Nov 19 23:48:03 2001
> >@@ -173,7 +173,7 @@
> > _modinst__: dummy
> > ifneq "$(strip $(ALL_MOBJS))" ""
> > 	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
> >-	cp -f $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
> >+	-cp -f $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
> > endif
> 
> (1) Complain to the fileutils maintainer for introducing incompatible
>     behaviour.

Or to RedHat who introduced this fileutils in their tree (but then again,
it is Rawhide so I have nothing to complain about :-)

> (2) The correct workaround is
>      cp -f $(sort $(ALL_MOBJS)) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)

shouldn't this then be 'sort -u'.

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
