Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUHGRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUHGRhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUHGRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:37:36 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:19462 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263806AbUHGRhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:37:32 -0400
Date: Sat, 7 Aug 2004 19:39:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pawe? Sikora <pluto@pld-linux.org>
Cc: Alexander Stohr <Alexander.Stohr@gmx.de>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
Message-ID: <20040807173917.GA14733@mars.ravnborg.org>
Mail-Followup-To: Pawe? Sikora <pluto@pld-linux.org>,
	Alexander Stohr <Alexander.Stohr@gmx.de>, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <2695.1091715476@www33.gmx.net> <20040805203317.GA22342@mars.ravnborg.org> <200408071821.08530.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <200408071821.08530.pluto@pld-linux.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 07, 2004 at 06:21:07PM +0200, Pawe? Sikora wrote:
> -	$(Q)if [ ! -z $$LC_ALL ]; then          \
> -		export LANG=$$LC_ALL;           \
> -		export LC_ALL= ;                \
> -	fi;                                     \
> -	export LC_COLLATE=C; export LC_CTYPE=C; \
> +	$(Q) \
> 
> ^^^ works for me.
Thanks!

I need to track this a bit more.
Could you please provide me with information of what
you are running.

make version (make --version)
shell & version of shell
distribution

Could you also try if the attached two Makefiles exhibit the same problem.
Just copy them to an empty directory and execute make.

A good run looks like:
Makefile2:1: lds=-P
Hi

A bad run does not have any -P after the '='.

Needless to say my make does not exhibit this issue.

	Sam

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

Q=@
all:
	$(Q)if [ ! -z $$LC_ALL ]; then          \
		export LANG=$$LC_ALL;           \
		export LC_ALL= ;                \
	fi;                                     \
	export LC_COLLATE=C; export LC_CTYPE=C; \
	$(MAKE) -f Makefile2 obj=xxx

export CFLAGS_vmlinux.lds.o := -P

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile2

$(warning lds=$(CFLAGS_vmlinux.lds.o))

all:
	@echo Hi

--SUOF0GtieIMvvwua--
