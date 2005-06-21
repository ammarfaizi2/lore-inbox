Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFUMMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFUMMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFUMJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:09:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57279 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261159AbVFUMHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:07:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17080.712.146434.671656@alkaid.it.uu.se>
Date: Tue, 21 Jun 2005 14:06:32 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
In-Reply-To: <42B7F740.6000807@drzeus.cx>
References: <42B7F740.6000807@drzeus.cx>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman writes:
 > GCC 4 checks the signedness of pointer casts and generates a whole bunch
 > of warnings for code in scripts/ (which makes heavy use of signed char
 > strings).
 > 
 > This patch adds explicit casts.

This is way ugly. The _real_ bug is that someone decided to store
plain text pointers in "signed char*" variables. s/signed char/char/g
should be a much better fix.

 > Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
 > Index: linux-wbsd/scripts/basic/fixdep.c
 > ===================================================================
 > --- linux-wbsd/scripts/basic/fixdep.c	(revision 134)
 > +++ linux-wbsd/scripts/basic/fixdep.c	(working copy)
 > @@ -242,7 +242,7 @@
 >  		continue;
 >  
 >  	found:
 > -		use_config(p+7, q-p-7);
 > +		use_config((char*)p+7, q-p-7);
 >  	}
 >  }
 >  
 > @@ -296,7 +296,7 @@
 >  	signed char *p;
 >  	char s[PATH_MAX];
 >  
 > -	p = strchr(m, ':');
 > +	p = (signed char*)strchr((char*)m, ':');

Clearly this is not the way to do text processing in C.
