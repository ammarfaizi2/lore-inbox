Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269509AbTCDS61>; Tue, 4 Mar 2003 13:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269516AbTCDS61>; Tue, 4 Mar 2003 13:58:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50950 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S269509AbTCDS60>;
	Tue, 4 Mar 2003 13:58:26 -0500
Date: Tue, 4 Mar 2003 20:08:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: J@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030304190854.GA1917@mars.ravnborg.org>
Mail-Followup-To: J@ravnborg.org, linux-kernel@vger.kernel.org
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304105739.GD6583@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 11:57:39AM +0100, J??rn Engel wrote:

A few comments to the Makefile changes..

> diff -Naur linux-2.5.63/arch/i386/Makefile linux-2.5.63-checkstack/arch/i386/Makefile
> --- linux-2.5.63/arch/i386/Makefile	Mon Feb 24 20:05:15 2003
> +++ linux-2.5.63-checkstack/arch/i386/Makefile	Tue Mar  4 11:51:11 2003
> @@ -124,3 +124,12 @@
>    echo  '		   install to $$(INSTALL_PATH) and run lilo'
>  endef
>  
> +CLEAN_FILES +=	$(TOPDIR)/scripts/checkstack_i386.pl
Do not use TOPDIR.
> +CLEAN_FILES +=	scripts/checkstack_i386.pl
Is preferred.

> +
> +$(TOPDIR)/scripts/checkstack_i386.pl: $(TOPDIR)/scripts/checkstack.pl
> +	(cd $(TOPDIR)/scripts/ && ln -s checkstack.pl checkstack_i386.pl)
There is no need to use the symlink trick.
Just pass the architecture as first mandatory parameter.
Something like
checkstack: vmlinux FORCE
	$(OBJDUMP) -d vmlinux | scripts/checkstack.pl $(ARCH)

Note that I skipped grep. Perl is good at regular expressions, and
the perl scripts already know the architecture so you can do the job there.
Since the above is now architecture independent, better locate it in
the top level Makefile.

	Sam
