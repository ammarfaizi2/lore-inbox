Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281201AbRKTSin>; Tue, 20 Nov 2001 13:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKTSie>; Tue, 20 Nov 2001 13:38:34 -0500
Received: from gate.mesa.nl ([194.151.5.70]:23560 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281201AbRKTSiV>;
	Tue, 20 Nov 2001 13:38:21 -0500
Date: Tue, 20 Nov 2001 19:38:20 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: linux-kernel@vger.kernel.org
Subject: make modules_install fails with latest fileutils
Message-ID: <20011120193820.A14068@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Just had some problems doing a modules_install with
fileutils-1.1.1-1 (redhat rawhide). The cp command
in there gives a non-zero return value when it is asked
to copy the same file in the argument list:

   mkdir bar
   cp foo foo bar
   cp: will not overwrite just-created `bar/foo' with `foo'

and returns with return value of 1.
This will break 'make modules_install' as it often adds the same module
file as cp argument.

A quick hack:

--- Rules.make.org	Tue Nov 20 19:36:16 2001
+++ Rules.make	Mon Nov 19 23:48:03 2001
@@ -173,7 +173,7 @@
 _modinst__: dummy
 ifneq "$(strip $(ALL_MOBJS))" ""
 	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
-	cp -f $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
+	-cp -f $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
 endif
 
 .PHONY: modules_install


-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
