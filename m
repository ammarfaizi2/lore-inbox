Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTCETEt>; Wed, 5 Mar 2003 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTCETEt>; Wed, 5 Mar 2003 14:04:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:11012 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267482AbTCETEq>;
	Wed, 5 Mar 2003 14:04:46 -0500
Date: Wed, 5 Mar 2003 20:15:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030305191516.GB1841@mars.ravnborg.org>
Mail-Followup-To: Joern Engel <joern@wohnheim.fh-wedel.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org> <20030305145149.GA7509@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305145149.GA7509@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 03:51:49PM +0100, J??rn Engel wrote:

> > Since the above is now architecture independent, better locate it in
> > the top level Makefile.
> 
> But the perl script itself breaks for anything but i386 and ppc at the
> moment, so I keep the changes in the arch Makefiles. Ultimately this
> should support all architectures and go to the top level, though.

There is no reason to put this in the arch specific makefiles.
You error out in a nice way in checkstack.pl anyway.
And architecture specific requirements shall be kept on a minimum.
Realise that the changes get even smaller, and only one file needs
to be touched to support a new architecture.


> +checkstack: vmlinux ***FORCE***
> +	$(OBJDUMP) -d vmlinux | \
> +	$(PERL) scripts/checkstack.pl $(ARCH)

You need FORCE to make sure the rule is actually executed.
And we have a variable that points to perl, use that one.

	Sam
