Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbTIJTOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265565AbTIJTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:14:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38919 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265563AbTIJTOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:14:24 -0400
Date: Wed, 10 Sep 2003 21:14:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [BK PATCHES] kbuild/kconfig
Message-ID: <20030910191411.GA5517@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Here are a few kbuild/kconfig related patches:

1) kbuild: Save relevant parts of modules.txt
2) kconfig: Allow architectures to select board specific configs
3) kbuild: Build minimum in scripts/ when changing configuration
4) kbuild: Remove cscope.out during make mrproper 
5) kbuild/ppc*: Remove obsolete _config support
6) bk ignore scripts/bin2c

The only patch worth mention is the one allowing architectures
to select board specific configurations. Adding a few trivial
changes to conf.c enabled generic support for that.
ppc* already followed the required setup.
I did not update arm for this new scheme. Russell?

Please pull
	bk pull bk://linux-sam.bkbits.net/kbuild

Patches will follow.

	Sam


ChangeSet@1.1273, 2003-09-10 20:34:29+02:00, sam@mars.ravnborg.org
  kbuild/ppc*: Remove obsolete _config support

 arch/ppc/Makefile   |    4 ----
 arch/ppc64/Makefile |    4 ----
 2 files changed, 8 deletions(-)


ChangeSet@1.1272, 2003-09-10 20:26:00+02:00, sam@mars.ravnborg.org
  kbuild: Remove cscope.out during make mrproper
  
  From: "Nathan T. Lynch" <ntl@pobox.com>
  
  The attached patch fixes the toplevel Makefile to remove cscope.out
  during make mrproper.  The default name for the database that cscope
  creates is cscope.out, and this is what the cscope rule in the
  makefile uses.  Currently, mrproper will leave cscope.out behind,
  which can make for interesting diffs...

 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1271, 2003-09-10 20:23:57+02:00, sam@mars.ravnborg.org
  kbuild: Build minimum in scripts/ when changing configuration
  
  From: Ricky Beam <jfbeam@bluetronic.net>, me
  
  With the increasing amount of programs located in scripts/, several
  of which is dependent on the kernel configuration, it makes sense to
  avoid building these too often.
  With this patch only fixdep is build, the minimal requirement for running
  any *config target

 Makefile |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


ChangeSet@1.1270, 2003-09-10 20:14:02+02:00, sam@mars.ravnborg.org
  kconfig: Allow architectures to select board specific configs
  
  This patch introduces the framework required for architectures to supply
  several independent configurations. Three architectures does this today:
  ppc, ppc64 and arm.
  The infrastructure provided here requires the files to be located in
  the following directory:
  arch/$(ARCH)/configs
  The file shall be named <board>_defconfig
  
  To select the configuration for ppc/gemini simply issue the following command:
  make gemini_defconfig
  This will generate a valid configuration.
  
  ppc and ppc64 already comply to the above requirements, arm needs some
  trivial updates.

 scripts/kconfig/Makefile |    3 +++
 scripts/kconfig/conf.c   |   30 ++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)


ChangeSet@1.1268, 2003-09-10 20:04:00+02:00, sam@mars.ravnborg.org
  kbuild: Save relevant parts of modules.txt
  
  The out-dated modules.txt were deleted from the kernel, save the kbuild
  related bits in Documentation/kbuild.
  It needs more updates, but for now this is better than nothing

 Documentation/kbuild/00-INDEX    |    2 ++
 Documentation/kbuild/modules.txt |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)


