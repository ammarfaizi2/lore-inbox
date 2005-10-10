Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVJJWnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVJJWnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVJJWnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:43:22 -0400
Received: from smtpout.mac.com ([17.250.248.85]:31709 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750828AbVJJWnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:43:22 -0400
X-PGP-Universal: processed;
	by AlPB on Mon, 10 Oct 2005 17:43:19 -0500
Mime-Version: 1.0 (Apple Message framework v734)
Content-Transfer-Encoding: 7bit
Message-Id: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Mark Rustad <mrustad@mac.com>
Subject: KBuild problem (or difference) in 2.6.14-rc3
Date: Mon, 10 Oct 2005 17:43:06 -0500
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed a change in Kbuild behavior when going from 2.6.13.x  
to 2.6.14-rc3. I build kernels with a separate objects directory. It  
has been my practice since beginning with 2.6 kernels last year, to  
put changed files into the objects directory structure to override an  
unmodified source tree. Starting with 2.6.14, I find that Makefiles  
in the objects directory structure area not used. I find that source  
and Kconfig files do override as they used to, but Makefiles do not.

I don't really know if this new behavior is intended or not, but it  
sure messes my kernel build methodology up. It looks to me like the  
problem was introduced by changes in scripts/Makefile.build. I think  
that this is the change causing me trouble:

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -10,8 +10,11 @@ __build:
# Read .config if it exist, otherwise ignore
  -include .config

-include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild,  
$(kbuild-dir)/Makefile)

+include scripts/Kbuild.include
  include scripts/Makefile.lib

  ifdef host-progs

Does anyone know if this change in behavior was intended? I realize  
that I may be doing something a little bit unusual, but I have been  
doing things this way very successfully since at least 2.6.5.

-- 
Mark Rustad, MRustad@mac.com

