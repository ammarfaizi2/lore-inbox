Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWHDFow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWHDFow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWHDFof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:61615 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030319AbWHDFoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:11 -0400
Date: Thu, 3 Aug 2006 22:39:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/23] Sparc64 quad-float emulation fix
Message-ID: <20060804053935.GL769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-quad-float-emulation-fix.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Miller <davem@davemloft.net>

[SPARC64]: Fix quad-float multiply emulation.

Something is wrong with the 3-multiply (vs. 4-multiply) optimized
version of _FP_MUL_MEAT_2_*(), so just use the slower version
which actually computes correct values.

Noticed by Rene Rebe

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-sparc64/sfp-machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.7.orig/include/asm-sparc64/sfp-machine.h
+++ linux-2.6.17.7/include/asm-sparc64/sfp-machine.h
@@ -34,7 +34,7 @@
 #define _FP_MUL_MEAT_D(R,X,Y)					\
   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 #define _FP_MUL_MEAT_Q(R,X,Y)					\
-  _FP_MUL_MEAT_2_wide_3mul(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_imm)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(D,R,X,Y)

--
