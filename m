Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUHGSyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUHGSyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUHGSyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:54:13 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:39944 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264192AbUHGSyG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:54:06 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: Alexander Stohr <Alexander.Stohr@gmx.de>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
Date: Sat, 7 Aug 2004 20:54:03 +0200
User-Agent: KMail/1.6.2
References: <2695.1091715476@www33.gmx.net> <200408071821.08530.pluto@pld-linux.org> <20040807173917.GA14733@mars.ravnborg.org>
In-Reply-To: <20040807173917.GA14733@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408072054.03554.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 of August 2004 19:39, Sam Ravnborg wrote:
> On Sat, Aug 07, 2004 at 06:21:07PM +0200, Pawe? Sikora wrote:
> > -	$(Q)if [ ! -z $$LC_ALL ]; then          \
> > -		export LANG=$$LC_ALL;           \
> > -		export LC_ALL= ;                \
> > -	fi;                                     \
> > -	export LC_COLLATE=C; export LC_CTYPE=C; \
> > +	$(Q) \
> >
> > ^^^ works for me.
>
> Thanks!
>
> I need to track this a bit more.
> Could you please provide me with information of what
> you are running.
>
> make version (make --version)
> shell & version of shell
> distribution

make-3.80-5
bash-2.05b-14
PLD(nptl/cvs)

> Could you also try if the attached two Makefiles exhibit the same problem.
> Just copy them to an empty directory and execute make.
>
> A good run looks like:
> Makefile2:1: lds=-P
> Hi

# LANG=pl_PL make
make[1]: Wej?cie do katalogu `/home/users/pluto/rpm/BUILD'
            ^
            ^ error. `¶' is correct char.

Makefile2:1: lds=
Hi
make[1]: Opuszczenie katalogu `/home/users/pluto/rpm/BUILD'

# LANG=C make
make[1]: Entering directory `/home/users/pluto/rpm/BUILD'
Makefile2:1: lds=
Hi
make[1]: Leaving directory `/home/users/pluto/rpm/BUILD'

with a minor fix...

-       export LC_COLLATE=C; export LC_CTYPE=C; \
-       $(MAKE) -f Makefile2 obj=xxx
+       export LC_COLLATE=C; export LC_CTYPE=C;
+       $(Q)$(MAKE) -f Makefile2 obj=xxx

works fine...

# LANG=pl_PL make
make[1]: Wej¶cie do katalogu `/home/users/pluto/rpm/BUILD'
Makefile2:1: lds=-P
Hi
make[1]: Opuszczenie katalogu `/home/users/pluto/rpm/BUILD'

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
