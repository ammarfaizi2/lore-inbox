Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVAJQlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVAJQlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVAJQlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:41:51 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:60065 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262322AbVAJQls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:41:48 -0500
Message-ID: <41E2B046.7040509@ens-lyon.fr>
Date: Mon, 10 Jan 2005 17:41:42 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Benoit Boissinot <bboissin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2 solved
References: <20050106002240.00ac4611.akpm@osdl.org>	 <21d7e99705010718435695f837@mail.gmail.com>	 <40f323d00501080427f881c68@mail.gmail.com>	 <21d7e99705010805487322533e@mail.gmail.com>	 <40f323d0050108074112ae4ac7@mail.gmail.com>	 <21d7e99705010817386f55e836@mail.gmail.com>	 <40f323d005010906093ba08ba4@mail.gmail.com>	 <41E13C87.3050306@ens-lyon.fr>	 <21d7e99705010923403a57c7a6@mail.gmail.com>	 <41E23383.60702@ens-lyon.fr> <21d7e9970501100101353cf602@mail.gmail.com> <41E2559F.60307@ens-lyon.fr>
In-Reply-To: <41E2559F.60307@ens-lyon.fr>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080709020806050401030408"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709020806050401030408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> The attached patch fixes it and solves my problem (when combined with
> http://lkml.org/lkml/2005/1/7/377). DRM is back with good performance.

Actually, this doesn't fix Benoit's problem (even if we were initially
having the same errors (radeon_cp_init called without lock held)).

It seems that memsetting the whole bridge structure to 0 (instead of
juste the agp_in_use field) fixes Benoit's problem too.
No idea which field was responsible for this. New patch attached.

Regards,
Brice

--------------080709020806050401030408
Content-Type: text/plain;
 name="fix_agp_bridge_init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_agp_bridge_init.diff"

--- linux-mm/drivers/char/agp/backend.c.orig	2005-01-10 10:36:13.000000000 +0100
+++ linux-mm/drivers/char/agp/backend.c	2005-01-10 10:34:35.000000000 +0100
@@ -235,6 +235,8 @@
 	if (!bridge)
 		return NULL;
 
+	memset(bridge, 0, sizeof(*bridge));
+
 	if (list_empty(&agp_bridges))
 		agp_bridge = bridge;
 

--------------080709020806050401030408--
