Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUIARkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUIARkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIARg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:36:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49880 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S267382AbUIARfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:35:43 -0400
Date: Wed, 1 Sep 2004 10:35:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm2
Message-ID: <20040901173509.GC19730@smtp.west.cox.net>
References: <20040830235426.441f5b51.akpm@osdl.org> <200408311454.48673.gene.heskett@verizon.net> <20040831194135.GB19724@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831194135.GB19724@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 09:41:35PM +0200, Sam Ravnborg wrote:
> On Tue, Aug 31, 2004 at 02:54:48PM -0400, Gene Heskett wrote:
> > make modules_install
> > /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
> > `fs/nls/nls_koi8-r.ko' given more than once in the same rule.
> > /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
> > `fs/nls/nls_koi8-ru.ko' given more than once in the same rule.
> > /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
> > `fs/nls/nls_koi8-u.ko' given more than once in the same rule.
> 
> Thanks!
> Know issue (reported off-list) - can be fixed with below patch.
> 
> 	Sam
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/08/31 21:36:26+02:00 sam@mars.ravnborg.org 
> #   kbuild: Fix modules_install
> #   
> #   modules_install failed for modules with 'ko' in their name.
> #   Fixes this.
> #   
> #   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> # 
> # scripts/Makefile.modinst
> #   2004/08/31 21:36:09+02:00 sam@mars.ravnborg.org +1 -1
> #   Fix installing of modules with ko in their name - do not find too many filenames in $(MODVERDIR)
> # 
> diff -Nru a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> --- a/scripts/Makefile.modinst	2004-08-31 21:40:31 +02:00
> +++ b/scripts/Makefile.modinst	2004-08-31 21:40:31 +02:00
> @@ -9,7 +9,7 @@
>  
>  #
>  
> -__modules := $(sort $(shell grep -h .ko /dev/null $(wildcard $(MODVERDIR)/*.mod)))
> +__modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
>  modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
>  
>  .PHONY: $(modules)

D'oh...  Wouldn't .modpost need the same change?

-- 
Tom Rini
http://gate.crashing.org/~trini/
