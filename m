Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265744AbTL3Mmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 07:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbTL3Mmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 07:42:36 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:9942 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265744AbTL3Mmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 07:42:35 -0500
Date: Tue, 30 Dec 2003 04:39:01 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: acme@conectiva.com.br, akpm@osdl.org, dag@brattli.net, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: [PATCH] irda: fix type of struct
 irda_ias_set.attribute.irda_attrib_string.len
Message-Id: <20031230043901.5e84b214.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.44.0311101900120.2881-100000@home.osdl.org>
References: <Pine.LNX.4.44.0311101856130.2881-100000@home.osdl.org>
	<Pine.LNX.4.44.0311101900120.2881-100000@home.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of months ago, Linus wrote:
> That's why I hate the "sign compare" warning of gcc so much - it warns 
> about things that you CANNOT sanely write in any other way. That makes 
> that particular warning _evil_, since it encourages people to write crap 
> code.

Then get rid of that warning, using -Wno-sign-compare:

The following change to the top level Makefile tells gcc not to complain
about this:

===== Makefile 1.439 vs edited =====
164c164
< HOSTCFLAGS    = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
---
> HOSTCFLAGS    = -Wall -Wno-sign-compare -Wstrict-prototypes -O2 -fomit-frame-pointer
278c278
< CFLAGS                := -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
---
> CFLAGS                := -Wall -Wno-sign-compare -Wstrict-prototypes -Wno-trigraphs -O2 \

Would you like me to send Andrew a real patch for this?

I have been running all my personal builds with this change for a month
now, ever since I picked up some version of gcc that is fond of that
warning.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
