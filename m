Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUD0XBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUD0XBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUD0XBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:01:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:48849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264392AbUD0XBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:01:47 -0400
Date: Tue, 27 Apr 2004 16:00:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: jamagallon@able.es
cc: Matthias Andree <matthias.andree@gmx.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] incomplete dependencies with BK tree (was: Anyone got
 aic7xxx working with 2.4.26?)
In-Reply-To: <1911B825-989D-11D8-A81A-000A9585C204@able.es>
Message-ID: <Pine.LNX.4.58.0404271555130.20443@ppc970.osdl.org>
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org>
 <20040427131941.GC10264@logos.cnet> <20040427142643.GA10553@merlin.emma.line.org>
 <6A88E87D-985B-11D8-AA97-000A9585C204@able.es> <20040427161314.GA18682@merlin.emma.line.org>
 <20040427180924.GA22366@merlin.emma.line.org> <1911B825-989D-11D8-A81A-000A9585C204@able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Apr 2004 jamagallon@able.es wrote:
> 
> At least gcc3 has [v][s][n]printf and friends as builtins, and also has
> __builtin_va_list,_start,_end, etc, so it looks easy to get rid of the
> stdarg.h dependency.

No, let's _not_ start implementing stdarg.h inside the kernel. It's just 
too compiler-dependent (remember - gcc isn't even the only compiler people 
use).

How about just _always_ including stdarg.h, and doing it by just making 
the main Makefile add a "-include <pathname>" to the CFLAGS? We should be 
able to generate the stdarg.h pathname pretty easily, with something like

	gcc --print-file-name=include/stdarg.h

(and that may depend on gcc versions too, of course).

> I think gcc builtins are under-used in kernel...

They are just _way_ too unreliable. They come and go with compiler 
versions, and aren't documented anywhere.

		Linus
