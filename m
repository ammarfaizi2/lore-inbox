Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWJWHMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWJWHMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWJWHMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:12:50 -0400
Received: from relay00.pair.com ([209.68.5.9]:46600 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751453AbWJWHMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:12:49 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
Date: Mon, 23 Oct 2006 02:12:26 -0500
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
In-Reply-To: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230212.49298.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 01:40, Giridhar Pemmasani wrote:
> Exactly - the loader within ndiswrapper taints kernel versions 2.6.10 and
> newer (older kernels don't have a way of tainting the kernel). The code is
> in loader.c in ndiswrapper.

Next question - what version of ndiswrapper started voluntary tainting (or has 
it always?)

That is to say, are there versions of ndiswrapper floating around out there in 
the ether capable of building against 2.6.19-rc* that don't voluntarily 
add_taint()? (I'm guessing the answer is 'no', but the answer is possibly 
important to consider)

The attached patch (untested) should keep the kernel from self-tainting when 
ndiswrapper is inserted. The last question, then, is how everyone else feels 
about this. Objections to removing the mandatory ndiswrapper taint?

Signed-off-by: Chase Venters <chase.venters@clientec.com>

diff --git a/kernel/module.c b/kernel/module.c
index 67009bd..f948a2c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1717,8 +1717,6 @@ #endif
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
-	if (strcmp(mod->name, "ndiswrapper") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 	if (strcmp(mod->name, "driverloader") == 0)
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 
