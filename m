Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSFXTWA>; Mon, 24 Jun 2002 15:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSFXTV7>; Mon, 24 Jun 2002 15:21:59 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:32923
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315178AbSFXTV6>; Mon, 24 Jun 2002 15:21:58 -0400
Date: Mon, 24 Jun 2002 12:20:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19-rc1] Fix building with 'make -r -R'
Message-ID: <20020624192021.GH3489@opus.bloom.county>
References: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes 'make -r -R' in current kernels.  From the
make (3.79.1) info page:

     In an explicit rule, there is no stem; so `$*' cannot be determined
     in that way.  Instead, if the target name ends with a recognized
     suffix (*note Old-Fashioned Suffix Rules: Suffix Rules.), `$*' is
     set to the target name minus the suffix.  For example, if the
     target name is `foo.c', then `$*' is set to `foo', since `.c' is a
     suffix.  GNU `make' does this bizarre thing only for compatibility
     with other implementations of `make'.  You should generally avoid
     using `$*' except in implicit rules or static pattern rules.

Which explains why when '-r -R' (aka --no-builtin-rules
--no-builtin-variables) the build fails to make 'init/main.o' or
'init/do_mounts.o'.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== Makefile 1.158 vs edited =====
--- 1.158/Makefile	Wed Jun  5 15:45:31 2002
+++ edited/Makefile	Fri Jun  7 10:20:25 2002
@@ -355,10 +355,10 @@
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o init/version.o init/version.c
 
 init/main.o: init/main.c include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $@ $<
 
 init/do_mounts.o: init/do_mounts.c include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $@ $<
 
 fs lib mm ipc kernel drivers net: dummy
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)

