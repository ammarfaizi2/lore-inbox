Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTIQTsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbTIQTsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:48:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:14093 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262886AbTIQTsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:48:06 -0400
Date: Wed, 17 Sep 2003 21:48:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm2
Message-ID: <20030917194803.GA12177@mars.ravnborg.org>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030914234843.20cea5b3.akpm@osdl.org> <1063646389.1311.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063646389.1311.0.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 07:19:50PM +0200, Felipe Alfaro Solana wrote:
> On Mon, 2003-09-15 at 08:48, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm2/
> 
> > Changes since 2.6.0-test5-mm1:
> 
> Hmmm...
> 
> "make rpm" support is broken in 2.6.0-test5-mm2. However, it works fine
> with 2.6.0-test5-bk3.

I broke that as part of the separate output directory patch.
The following should fix it.

Andrew, I will come up with a better patch tomorrow.

	Sam

===== Makefile 1.428 vs edited =====
--- 1.428/Makefile	Thu Sep 11 12:01:23 2003
+++ edited/Makefile	Wed Sep 17 21:46:41 2003
@@ -97,7 +97,7 @@
 # We process the rest of the Makefile if this is the final invocation of make
 ifeq ($(skip-makefile),)
 
-srctree		:= $(if $(KBUILD_SRC),$(KBUILD_SRC),.)
+srctree		:= $(if $(KBUILD_SRC),$(KBUILD_SRC),$(CURDIR))
 TOPDIR		:= $(srctree)
 # FIXME - TOPDIR is obsolete, use srctree/objtree
 objtree		:= $(CURDIR)

