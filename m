Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUBQPZb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUBQPZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:25:31 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:19602 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266230AbUBQPZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:25:29 -0500
Date: Tue, 17 Feb 2004 16:25:27 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: strxxx and gcc-3.4
In-Reply-To: <20040213234028.GA3765@werewolf.able.es>
Message-ID: <Pine.LNX.4.55.0402171622111.8356@jurand.ds.pg.gda.pl>
References: <20040213234028.GA3765@werewolf.able.es>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Feb 2004, J.A. Magallon wrote:

> Finally I got the problem with emu10k1. It was a sprintf->strcpy that
> the compiler could not inline. And out-of-line strcpy was not exported.
> Exporting it solved the problem (in -mm tree, that has the out-of-line
> versions).
> 
> Current situation: even -mm, that includes many fixes for gcc-3.4, can
> fail to build. Currently in 2.6.3-rc2-mm1 there are:
> 
> werewolf:/usr/src/linux-2.6.3-rc2-mm1# grep -r sprintf * | grep \"%s\" | wc -l
> 63
> 
> instances of that stupid sprintf(s,"%s", .... ) thing.
> 
> Options:
> - Fix all of them. I don't like it, the kernel should not depend on what
>   gcc does internally
> - Use -fno-builtin-sprintf. I think gcc swaps sprintf to strcpy because
>   it sees it as a builtin, but as finds a declaration for an external
>   strcpy does not use the builtin for strcpy.
> - Kill off all str/mem functions and just let gcc insert builtins.
[...]
> Preferences ?

 Fix gcc before it's released.  Has the problem been reported?  I've
hesitated to do that as I use an outdated gcc 3.4 snapshot (from the
pre-branch times) and I've assumed it may have been fixed since.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
