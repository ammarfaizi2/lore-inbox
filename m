Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWG3ScA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWG3ScA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWG3ScA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:32:00 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:2489 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932419AbWG3Sb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:31:59 -0400
Date: Sun, 30 Jul 2006 20:31:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: Building external modules against objdirs
Message-ID: <20060730183159.GA30278@mars.ravnborg.org>
References: <200607301846.07797.ak@suse.de> <20060730175130.GA23665@mars.ravnborg.org> <200607301949.41165.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301949.41165.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 07:49:41PM +0200, Andi Kleen wrote:
> 
> > Can you check that you really did a 'make prepare' in the relevant
> > output directory. Previously only the make *config step was needed.
> 
> The output directory is a full build (configuration + make without any targets).
> Is that not enough anymore? 
> 
> Anyways after a make prepare it seems to work - thanks - but I think that
> should be really done as part of the standard build like it was in 2.6.17.
'make prepare' is and has always been part of the standard build.
So I really do not see what is going on.

Can you please check that followign files exists in your output
directory:
.config
include/config/auto.conf.cmd
include/config/auto.conf

the latter should be the latest of the three.

Also try applying following patch to reveal why we trigger this rule:

diff --git a/Makefile b/Makefile
index 1dd58d3..4c30ed5 100644
--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,7 @@ include/config/auto.conf: $(KCONFIG_CONF
 ifeq ($(KBUILD_EXTMOD),)
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
+	@echo triggered by - $? -
 	$(error kernel configuration not valid - run 'make prepare' in $(srctree) to update it)
 endif
 
