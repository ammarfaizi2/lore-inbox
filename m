Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbSI3BPv>; Sun, 29 Sep 2002 21:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSI3BPv>; Sun, 29 Sep 2002 21:15:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44515 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261884AbSI3BPu>;
	Sun, 29 Sep 2002 21:15:50 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 30 Sep 2002 03:21:12 +0200 (MEST)
Message-Id: <UTC200209300121.g8U1LCS07667.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, acme@conectiva.com.br
Subject: init ordering bug in 802/psnap.c vs llc/llc_main.c
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Humm, 2.5.39? It is compiled statically, isn't it?
> I'm working exclusively with modules up to now

A good hint. llc/llc_main.c crashes in llc_sap_find()
because llc_init() has not yet been called, so that
llc_main_station.sap_list.list is not initialized.

And llc_sap_find() was called from 802/psnap.c, in snap_init().

Calling llc_init() and snap_init() in the right order
makes the oops go away.

Andries
