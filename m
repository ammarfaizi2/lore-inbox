Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbWGNCI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbWGNCI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWGNCI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:08:28 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:56275 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S1161169AbWGNCI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:08:27 -0400
Message-ID: <44B6FC90.2060501@logix.cz>
Date: Fri, 14 Jul 2006 14:08:16 +1200
From: Michal Ludvig <michal@logix.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CRYPTO] padlock: Fix alignment after aes_ctx rearrange
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

I just recently discovered that your patch that rearranges struct
aes_ctx in padlock-aes.c breaks the alignment rules for xcrypt leading
to GPF Oopses.

Note that *all* addresses passed to xcrypt must be 16-Bytes aligned for
VIA C3 (including IV and Key - the latter one was not aligned and
triggered this Oops).

As the rearrange patch made it to 2.6.18-rc1 it must be fixed before
2.6.18 is out. Attached is a patch.

Michal


