Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbTITL3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTITL3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:29:16 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46354 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261745AbTITL3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:29:15 -0400
Date: Sat, 20 Sep 2003 13:29:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ink@jurassic.park.msu.ru, maz@wild-wind.fr.eu.org, mec@shout.net,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test5/drivers/eisa verbose build failure
Message-ID: <20030920112912.GA996@mars.ravnborg.org>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	ink@jurassic.park.msu.ru, maz@wild-wind.fr.eu.org, mec@shout.net,
	linux-kernel@vger.kernel.org
References: <200309152231.h8FMVph11922@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309152231.h8FMVph11922@freya.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 03:31:51PM -0700, Adam J. Richter wrote:
> 	linux-2.6.0-test5/drivers/eisa fails to build if KBUILD_VERBOSE=1
> in the top level Linux Makefile (KBUILD_VERBOSE=1 causes the build
> process to show the actual commands that are being executed).
> 
> 	linux-2.6.0-test5/drivers/eisa/Makefile contains a change
> that tries to use the Linux KBUILD_VERBOSE system to control
> echoing of a command that contains some single quotes.  It looks
> like scripts/Makefile.lib contains some macros designed to put
> backslashes in front of single quotes as necessary to handle this
> case, but, somehow, this is not happening. 

Good analysis, thanks.
The following patch fixes it for me.
Would you mind trying this and report back.

	Sam

===== scripts/Makefile.lib 1.20 vs edited =====
--- 1.20/scripts/Makefile.lib	Sun Jun  8 20:06:56 2003
+++ edited/scripts/Makefile.lib	Sat Sep 20 09:11:28 2003
@@ -225,7 +225,7 @@
 
 # If quiet is set, only print short version of command
 
-cmd = @$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))' &&) $(cmd_$(1))
+cmd = @$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
 
 #	$(call descend,<dir>,<target>)
 #	Recursively call a sub-make in <dir> with target <target> 
