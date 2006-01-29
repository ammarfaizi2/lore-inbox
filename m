Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWA2Ord@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWA2Ord (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 09:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWA2Ord
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 09:47:33 -0500
Received: from mail.tnnet.fi ([217.112.240.26]:8156 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1751018AbWA2Orc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 09:47:32 -0500
Message-ID: <43DCD581.24581498@users.sourceforge.net>
Date: Sun, 29 Jan 2006 16:47:29 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.1c file/swap crypto package
References: <43CE6384.284B823C@users.sourceforge.net> <20060120195035.GA9685@mars.ravnborg.org> <43D260F8.B82BCB9A@users.sourceforge.net> <20060128225725.GA18727@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sat, Jan 21, 2006 at 06:27:36PM +0200, Jari Ruusu wrote:
> > 2) Try building external module A that exports some function, and then build
> >    another external module B (separate package, only knows function
> >    prototype) that uses said exported function. And I mean build it cleanly
> >    without puking error messages on me. 2.4 and older kernel got that right,
> >    but 2.6 is still FUBAR. Serious regression here.
> 
> This was always possible using a kbuild file specifying all relevant
> modules. But accepting this is not always doable kbuild now add an
> additional method. build module a. copy Module.symvers from module a to
> module b. Voila, module b has full access to symbols from module a. This
> includes module versioning support. Both methods are documented in
> Documentation/kbuild/modules.txt now.

But that "copy Module.symvers from module A to module B" does not work in
these situations:

1) Module B does not know where module A source is.
2) Automatic package builder box may remove all traces of module A before
   module B is built.
3) Automatic package builder box may build module B before module A.

How about this:

    make M=/path/to/dir IGNORE_MISSING_SYMVER_ERRORS=1 modules
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Meaning: If symbol version is available, fine, use that. If some info is not
available, that is fine too. Just make it work without symbol versioning.
Killing those damn error messages should be enough.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
