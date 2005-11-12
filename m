Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVKLL46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVKLL46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 06:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKLL46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 06:56:58 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:65405 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932354AbVKLL45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 06:56:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=hl+yOA1BFTuyZDmJUHnAkwXsjN7QDA9V8d3+RXhCS4SF9TrgZbQiR1yQcm+cwHsXYugfubwTuYupfmIlqwDF1ul1Qoim1Gznd+jJKKxV4M5VtSJra+xzZt36lbyU/55TsS+VuJZHAd+TT5S4lzpZeUVBQTIDMkE/JtPTg/PPZaw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] 2.6.14.git: user-mode-linux/x86_64 does not build
Date: Sat, 12 Nov 2005 13:04:11 +0100
User-Agent: KMail/1.8.3
Cc: Junichi Uekawa <dancer@netfort.gr.jp>, linux-kernel@vger.kernel.org
References: <87r79mfxjj.dancerj%dancer@netfort.gr.jp>
In-Reply-To: <87r79mfxjj.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8oddD5AFoM3EQxk"
Message-Id: <200511121304.12747.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8oddD5AFoM3EQxk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 12 November 2005 02:46, Junichi Uekawa wrote:
> Hi,
>
> UML does not build from linus's git tree for a while, with the
> following compilation error.

Ok, I must start catching up - I have lots of fixes but not yet found the time 
to re-read and send them. This is one of them.

> .config is attached later.

> CONFIG_X86_CMPXCHG=y

> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y

This is what's causing the error, these options should be mutually exclusive. 

> CONFIG_64BIT=y
Arh, this is the problem... I made a mistake for x86_64, and the fix has not 
yet been sent up. Patch attached.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_8oddD5AFoM3EQxk
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-reuse-i386-cpu-optim-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-reuse-i386-cpu-optim-fix.patch"

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 018f076..563301f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -35,12 +35,6 @@ config IRQ_RELEASE_METHOD
 	bool
 	default y
 
-menu "Host processor type and features"
-
-source "arch/i386/Kconfig.cpu"
-
-endmenu
-
 menu "UML-specific options"
 
 config MODE_TT
diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index 5d92cac..c71b39a 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -1,3 +1,9 @@
+menu "Host processor type and features"
+
+source "arch/i386/Kconfig.cpu"
+
+endmenu
+
 config UML_X86
 	bool
 	default y
@@ -42,7 +48,3 @@ config ARCH_HAS_SC_SIGNALS
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default y
-
-config X86_CMPXCHG
-	bool
-	default y
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 1f7dcb0..7a0e04e 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -35,4 +35,3 @@ cflags-y += $(call cc-option,-mpreferred
 
 CFLAGS += $(cflags-y)
 USER_CFLAGS += $(cflags-y)
-

--Boundary-00=_8oddD5AFoM3EQxk--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
