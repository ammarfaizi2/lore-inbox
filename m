Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTJAQmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbTJAQkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:40:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34063 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263110AbTJAQjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:39:32 -0400
Date: Wed, 1 Oct 2003 18:39:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] check headers for complete includes, etc.
Message-ID: <20031001163930.GA11493@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de> <20030929145057.GA1002@mars.ravnborg.org> <20031001094825.GB31698@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001094825.GB31698@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 11:48:25AM +0200, Jörn Engel wrote:
> 
> If there are no big complaints, I consider this version to be final.
Some small comments..

> --- /dev/null	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.0-test5/scripts/checkheader.pl	2003-09-30 21:41:14.000000000 +0200
> @@ -0,0 +1,54 @@
> +#!/usr/bin/perl -w
> +use strict;
> +
> +my $verbose = 1;	# TODO make this optional
Could you make this controlable with option -verbose, see below.

> +my @headers = sort(map({prune($_);}
> +	`(cd include/ && find linux -name "*.h" ; find asm/ -name "*.h")`));
1) you uses include but asm/ - use final '/' for consistency.
2) Using asm/ you require the symlink to be present. Which obvious
it a most when  doing this check, so we better secure that.

> +my $basename = "lib/header";
I much rather have it be: include/headercheck
then people realise where eventual temporary files comes from.

So we need something like the following here: (untested)
>  
> +headercheck: prepare-all
> +	$(PERL) scripts/checkheader.pl $(if $(KBUILD_VERBOSE),-verbose)
> +
>  versioncheck:
>  	find * $(RCS_FIND_IGNORE) \
>  		-name '*.[hcS]' -type f -print | sort \

With respect to passing on to Linus.
I would like to have a bunch of files converted first so we can see the
effect of requiring this check.
Also I am still a bit uncertain if this is the right approach,
but until now this is the only patch...

	Sam
