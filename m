Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUEBThb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUEBThb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUEBThb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 15:37:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27914 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263199AbUEBTha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 15:37:30 -0400
Date: Sun, 2 May 2004 21:33:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "C.L. Tien - ??????" <cltien@cmedia.com.tw>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: cmpci 6.82 released
Message-ID: <20040502193305.GA19871@alpha.home.local>
References: <92C0412E07F63549B2A2F2345D3DB515F7D430@cm-msg-02.cmedia.com.tw> <20040429194635.GB20141@logos.cnet> <20040429204038.GA9079@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429204038.GA9079@havoc.gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just happened to fail to compile cmpci-6.82 on 2.4.26 with SMP, because
of order of includes. Basically, interrupt.h references files which use
smp_processor_id() which references current, and this one is not declared
yet. This trivial patch fixes it, at least on 2.4.26.

Regards,
Willy

--- ./drivers/sound/cmpci.c.orig	Sun May  2 21:20:42 2004
+++ ./drivers/sound/cmpci.c	Sun May  2 21:20:52 2004
@@ -109,9 +109,9 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/sound.h>
 #include <linux/slab.h>

