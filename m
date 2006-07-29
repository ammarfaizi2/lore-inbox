Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWG2HQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWG2HQF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWG2HQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:16:04 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:50883 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422676AbWG2HQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:16:00 -0400
Date: Sat, 29 Jul 2006 09:15:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/18] kbuild fixes
Message-ID: <20060729071540.GA6738@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Here is a number of small and smaller kbuild fixes for -rc2. Please add
them before -rc3.
The list got larger than expected since I missed -rc1 with half a day.

Most noteworthy:

o fix build on ubuntu - breakage caused by -fno-stack-protector enabled
  on ubuntu
o fix building out-of-tree modules
o fix 'make headers_install' to work with a non-configured kernel
o added unifdef to the kernel tree. It is not a widely distributed tool
  author has acked this

Patches has been in -mm for a while with no bugs reported.
Exception is the 'linguistic fixes' - but they did not cause any
compile/boot issues ;-)

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuld.git

diffstat + shortlog + full log below.

	Sam

git diff --stat:
 .gitignore                                |    5 
 Documentation/kbuild/kconfig-language.txt |   12 
 Documentation/kbuild/makefiles.txt        |  184 +++--
 Documentation/kbuild/modules.txt          |  119 ++-
 Kbuild                                    |    2 
 Makefile                                  |    9 
 drivers/scsi/aic7xxx/aicasm/Makefile      |    2 
 scripts/Kbuild.include                    |   55 +-
 scripts/Makefile                          |    3 
 scripts/Makefile.build                    |    5 
 scripts/Makefile.headersinst              |    2 
 scripts/Makefile.modpost                  |    2 
 scripts/kconfig/confdata.c                |   10 
 scripts/mod/file2alias.c                  |   62 +-
 scripts/unifdef.c                         | 1005 +++++++++++++++++++++++++++++
 usr/Makefile                              |    2 
 16 files changed, 1269 insertions(+), 210 deletions(-)

git shortlog:

Dave Jones:
      kbuild: fix typo in modpost

Jan Engelhardt:
      kbuild: linguistic fixes for Documentation/kbuild/makefiles.txt
      kconfig: linguistic fixes for Documentation/kbuild/kconfig-language.txt
      kbuild: linguistic fixes for Documentation/kbuild/modules.txt

Matthew Wilcox:
      kconfig: support DOS line endings

Olaf Hering:
      remove RPM_BUILD_ROOT from asm-offsets.h

Qi Yong:
      gitignore: gitignore quilt's files

Roman Zippel:
      kconfig: correct oldconfig for unset choice options

Sam Ravnborg:
      kbuild: hardcode value of YACC&LEX for aic7-triple-x
      kbuild: version.h and new headers_* targets does not require a kernel config
      kbuild: .gitignore utsrelease.h
      kbuild: improve error from file2alias
      kbuild: -fno-stack-protector is not good
      kbuild: consistently decide when to rebuild a target
      kbuild: always use $(CC) for $(call cc-version)
      kbuild: add unifdef
      kbuild: replace use of strlcpy with a dedicated implmentation in unifdef
      kbuild: use in-kernel unifdef

git log:
commit b193a8c70628aecdbccac81f710cec2bf2dd3592
Author: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date:   Thu Jul 27 22:14:29 2006 +0200

    kbuild: linguistic fixes for Documentation/kbuild/modules.txt
    
    I have done a look-through through Documentation/kbuild/ and my corrections
    (proposed) are attached.
    
    Cc'ed are original author Michael (responsible for comitting changes to
    these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).
    
    Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Documentation/kbuild/modules.txt |  119 +++++++++++++++++++-------------------
 1 files changed, 60 insertions(+), 59 deletions(-)

commit 665cf3bbd09375ea7520083704ce8b8c1bcc54a9
Author: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date:   Thu Jul 27 22:14:29 2006 +0200

    kconfig: linguistic fixes for Documentation/kbuild/kconfig-language.txt
    
    I have done a look-through through Documentation/kbuild/ and my corrections
    (proposed) are attached.
    
    Cc'ed are original author Michael (responsible for comitting changes to
    these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).
    
    Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Documentation/kbuild/kconfig-language.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

commit e2dbd0d4c86f364640429718ce20fbe9aafe979e
Author: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date:   Thu Jul 27 22:14:29 2006 +0200

    kbuild: linguistic fixes for Documentation/kbuild/makefiles.txt
    
    I have done a look-through through Documentation/kbuild/ and my corrections
    (proposed) are attached.
    
    Cc'ed are original author Michael (responsible for comitting changes to
    these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).
    
    Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Documentation/kbuild/makefiles.txt |  184 ++++++++++++++++++------------------
 1 files changed, 94 insertions(+), 90 deletions(-)

commit 5dd5cc7558046806ef29e4057bbb309b1b248634
Author: Olaf Hering <olh@suse.de>
Date:   Tue Jul 25 18:42:26 2006 -0700

    remove RPM_BUILD_ROOT from asm-offsets.h
    
    No file in rpm binary package should have the RPM_BUILD_ROOT string in it.
    To simplify building of external modules, our kernel-source package
    contains some temp files from the Kbuild system.  asm/asm-offsets.h is one
    of the files that contains the absolute path if make O=$O is used.
    
      * This file was generated by /var/tmp/kernel-source-2.6.14_rc4-build/usr/src/linux-2.6.14-rc4-2/Kbuild
    
    Remove the $RPM_BUILD_ROOT string in the shipped tempfile.
    
    Signed-off-by: Olaf Hering <olh@suse.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Kbuild |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit 81ec74898bbc68bd0818cb86faa7016ae9e68445
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 23 20:47:50 2006 +0200

    kbuild: use in-kernel unifdef
    
    Let headers_install use in-kernel unifdef
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Makefile                     |    4 ++--
 scripts/Makefile             |    3 +++
 scripts/Makefile.headersinst |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

commit 070ab8cc933596133db55816818c477729f007dd
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 23 20:41:30 2006 +0200

    kbuild: replace use of strlcpy with a dedicated implmentation in unifdef
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/unifdef.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

commit b70bca202c920feebc618aaee473bfd14003a46e
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 23 20:39:59 2006 +0200

    kbuild: add unifdef
    
    This patch contains a raw copy of unifdef.c
    Next patch will modify it and add infrastructure to use it
    Adding unifdef to the kernel is acked by the author.
    
    The reason to add unifdef as part of the kernel source is that it is not
    yet a common utility on most distributions.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/unifdef.c |  998 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 998 insertions(+), 0 deletions(-)

commit ecbe2c133024f9a852e9852197cc77c2884e64bb
Author: Qi Yong <qiyong@fc-cn.com>
Date:   Mon Jul 17 13:37:06 2006 +0800

    gitignore: gitignore quilt's files
    
    gitignore: ignore quilt's files.
    
    Signed-off-by: Qi Yong <qiyong@fc-cn.com>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 .gitignore |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

commit 045cfddb5f89722259c90fb742e201d289d94092
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 23 19:49:45 2006 +0200

    kbuild: always use $(CC) for $(call cc-version)
    
    The possibility to specify an optional parameter did not work out as
    expected and it was not used - so remove the possibility.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/Kbuild.include |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

commit 0b5d8d55caf9a844401cf5b3f534a50d9aa105af
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 23 19:37:44 2006 +0200

    kbuild: consistently decide when to rebuild a target
    
    Consistently decide when to rebuild a target across all of
    if_changed, if_changed_dep, if_changed_rule.
    PHONY targets are now treated alike (ignored) for all targets
    
    While add it make Kbuild.include almost readable by factoring out a few
    bits to some common variables and reuse this in Makefile.build.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/Kbuild.include |   52 ++++++++++++++++++++++++++++--------------------
 scripts/Makefile.build |    5 +++--
 usr/Makefile           |    2 ++
 3 files changed, 35 insertions(+), 24 deletions(-)

commit 24c56d80c676a79c161821fc928f903ff0f03241
Author: Matthew Wilcox <matthew@wil.cx>
Date:   Thu Jul 13 12:54:07 2006 -0600

    kconfig: support DOS line endings
    
    Kconfig doesn't currently handle config files with DOS line endings.
    While these are, of course, an abomination, etc, etc, it can be handy
    to not have to convert them first.  It's also a tiny patch and even adds
    support for lines ending in just \r or even \n\r.
    
    Signed-off-by: Matthew Wilcox <matthew@wil.cx>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kconfig/confdata.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

commit a014a91bb01be9cce0d2dc292a8488fb81b0cd3b
Author: Roman Zippel <zippel@linux-m68k.org>
Date:   Thu Jul 13 13:22:38 2006 +0200

    kconfig: correct oldconfig for unset choice options
    
    oldconfig currently ignores unset choice options and doesn't ask for them.
    Correct the SYMBOL_DEF_USER flag of the choice symbol to be only set if
    it's set for all values.
    
    Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kconfig/confdata.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit ca1b67b522896b8f59be6e5fd81f53987a94695f
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Thu Jul 13 20:27:27 2006 +0200

    kbuild: -fno-stack-protector is not good
    
    Ubuntu gcc has hardcoded -fstack-protector - but does not understand
    -fno-stack-protector-all. So only try -fno-stack-protector.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

commit b1c34ea9a006ad0deb828921996f071d925d79de
Author: Dave Jones <davej@redhat.com>
Date:   Thu Jul 13 00:44:15 2006 -0400

    kbuild: fix typo in modpost
    
    Reported by a Fedora user when they tried to build some out of tree module..
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/Makefile.modpost |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit 48d2f630d921ba92cc5d5f75b97a2bf1092277eb
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 9 16:26:07 2006 +0200

    kbuild: improve error from file2alias
    
    The original errormessage was just plain unreadable.
    
    Sample error message after this update (not for real - I provoked it):
    
    FATAL: drivers/net/s2io: sizeof(struct pci_device_id)=33 is not a modulo of the
    size of section __mod_pci_device_table=160.
    Fix definition of struct pci_device_id in mod_devicetable.h
    
    Before a warning was generated - this is now a fatal error.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/mod/file2alias.c |   62 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 43 insertions(+), 19 deletions(-)

commit 6ce316b37017dc83d1e3b16113c6a01750d3d554
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 9 16:07:44 2006 +0200

    kbuild: .gitignore utsrelease.h
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

commit 3a029538f8135e3416ea9973f3e2d3ae61bbb153
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sat Jul 8 00:46:25 2006 +0200

    kbuild: version.h and new headers_* targets does not require a kernel config
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

commit 073be037e1615993ed925a28c3f731756b668fdc
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sat Jul 8 00:27:49 2006 +0200

    kbuild: hardcode value of YACC&LEX for aic7-triple-x
    
    When we introduced -rR then aic7xxx no loger could pick up definition
    of YACC&LEX from make - so do it explicit now.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 drivers/scsi/aic7xxx/aicasm/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
