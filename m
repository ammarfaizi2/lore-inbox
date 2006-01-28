Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWA1W5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWA1W5g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 17:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWA1W5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 17:57:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:58380 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750774AbWA1W5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 17:57:35 -0500
Date: Sat, 28 Jan 2006 23:57:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.1c file/swap crypto package
Message-ID: <20060128225725.GA18727@mars.ravnborg.org>
References: <43CE6384.284B823C@users.sourceforge.net> <20060120195035.GA9685@mars.ravnborg.org> <43D260F8.B82BCB9A@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D260F8.B82BCB9A@users.sourceforge.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 06:27:36PM +0200, Jari Ruusu wrote:
> Sam Ravnborg wrote:
> > Either something is missing in the support for external modules in the
> > kernel or you are overdoing some stuff. If there is something missing in
> > the kernel to support external modules then please say so, so it can be
> > fixed.
> 
> Missing functionality:
> 1) "make M=/path/to/dir modules_install" does not run depmod. Pulling
>    correct depmod info from kernel Makefile needs ugly hacks.
Fixed in latest kbuild.
One day I need to get full grip on the module-init-tools stuff....

> 2) Try building external module A that exports some function, and then build
>    another external module B (separate package, only knows function
>    prototype) that uses said exported function. And I mean build it cleanly
>    without puking error messages on me. 2.4 and older kernel got that right,
>    but 2.6 is still FUBAR. Serious regression here.
This was always possible using a kbuild file specifying all relevant
modules. But accepting this is not always doable kbuild now add an
additional method.
build module a
copy Module.symvers from module a to module b.
Voila, module b has full access to symbols from module a. This includes
module versioning support.
Both methods are documented in Documentation/kbuild/modules.txt now.


Both changes are in my kbuild.git tree and I will send out a series of
patches to lkml soon. It will be available for testing in next -mm too.

Thanks for input, and please let me know if you know of more
shortcomings in kbuild that needs to be addressed.

	Sam
