Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbRESWL7>; Sat, 19 May 2001 18:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbRESWLu>; Sat, 19 May 2001 18:11:50 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:23820 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261771AbRESWLh>;
	Sat, 19 May 2001 18:11:37 -0400
Date: Sat, 19 May 2001 18:10:26 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Brown-paper-bag bug in m68k, sparc, and sparc64 config files
Message-ID: <20010519181026.A23730@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug unconditionally disables a configuration question -- and it's
so old that it has propagated across three port files, without either
of the people who did the cut and paste for the latter two noticing it.

This sort of thing would never ship in CML2, because the compiler
would throw an undefined-symbol warning on BLK_DEV_ST.  The temptation
to engage in sarcastic commentary at the expense of people who still
think CML2 is an unnecessary pain in the butt is great.  But I will
restrain myself.  This time.

--- arch/m68k/config.in	2001/05/19 21:36:57	1.1
+++ arch/m68k/config.in	2001/05/19 21:37:12
@@ -192,7 +192,7 @@
       int  'Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
    fi
    dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
-   if [ "$CONFIG_BLK_DEV_ST" != "n" ]; then
+   if [ "$CONFIG_CHR_DEV_ST" != "n" ]; then
       int  'Maximum number of SCSI tapes that can be loaded as modules' CONFIG_ST_EXTRA_DEVS 2
    fi
    dep_tristate '  SCSI CD-ROM support' CONFIG_BLK_DEV_SR $CONFIG_SCSI
--- arch/sparc/config.in	2001/05/19 21:34:54	1.1
+++ arch/sparc/config.in	2001/05/19 21:35:21
@@ -162,7 +162,7 @@
 
    dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
 
-   if [ "$CONFIG_BLK_DEV_ST" != "n" ]; then
+   if [ "$CONFIG_CHR_DEV_ST" != "n" ]; then
       int  'Maximum number of SCSI tapes that can be loaded as modules' CONFIG_ST_EXTRA_DEVS 2
    fi
 
--- arch/sparc64/config.in	2001/05/19 21:37:33	1.1
+++ arch/sparc64/config.in	2001/05/19 21:37:45
@@ -146,7 +146,7 @@
 
    dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
 
-   if [ "$CONFIG_BLK_DEV_ST" != "n" ]; then
+   if [ "$CONFIG_CHR_DEV_ST" != "n" ]; then
       int  'Maximum number of SCSI tapes that can be loaded as modules' CONFIG_ST_EXTRA_DEVS 2
    fi
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Conservatism is the blind and fear-filled worship of dead radicals.
