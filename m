Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272881AbTG3N4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272883AbTG3N4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:56:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:27311 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272881AbTG3N4Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:56:25 -0400
Date: Wed, 30 Jul 2003 15:56:23 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: TSCs are a no-no on i386
Message-ID: <20030730135623.GA1873@lug-owl.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This small patch fixes a long-standing problem for bare i386 CPUs. These
don't have TSCs and so, a recent 2.4.x kernel will simply halt the
machine leaving a text like "This CPU has no TSC feature (ie was
compiled for Pentium+) but I do depend on it".

Please apply. Worst to say, even Debian seems to start using i486+
features (ie. libstdc++5 is SIGILLed on Am386 because there's no
"lock" insn available)...

MfG, JBG


--- linux-2.4.22-pre9/arch/i386/config.in.orig	2003-07-30 15:00:27.000000000 +0200
+++ linux-2.4.22-pre9/arch/i386/config.in	2003-07-30 15:01:56.000000000 +0200
@@ -56,6 +56,7 @@
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y


-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
      ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));
