Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTJYNhF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 09:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbTJYNhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 09:37:05 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:20507 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262556AbTJYNhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 09:37:02 -0400
Date: Sat, 25 Oct 2003 06:37:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: Brice.Goglin@ens-lyon.fr, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.6.0-test8
Message-Id: <20031025063737.5c4c1071.pj@sgi.com>
In-Reply-To: <200310250108.h9P18paK003981@ccure.karaya.com>
References: <20031022083742.GR8782@ens-lyon.fr>
	<200310250108.h9P18paK003981@ccure.karaya.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your 2.6.0-test8 patch from:

  http://jdike.stearns.org/mirror/uml-patch-2.6.0-test8.bz2

worked for me as well.  It built and booted at least, when applied
to a clean, current as of a few hours ago:

   bk://linux.bkbits.net/linux-2.5

But your bkbits tree, at:

  http://jdike.stearns.org:5000/uml-2.5

seems to have something quite different in it than what
I got from the above linux-2.5 + uml-patch-2.6.0-test8.bz2.

Just one UML relevant example of what I see different:

================ arch/um/kernel/Makefile ================
48c50
< QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
---
> QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'


The '<' is from your bkbits tree, and didn't compile.
The '>' is from applying your patch, and works.

I see many other differences as well, most seemgingly unrelated
to UML.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
