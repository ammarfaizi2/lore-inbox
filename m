Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUDGLc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUDGLc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:32:29 -0400
Received: from [80.72.36.106] ([80.72.36.106]:53982 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S263059AbUDGLbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:31:44 -0400
Date: Wed, 7 Apr 2004 13:31:39 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
In-Reply-To: <20040407110608.GR20293@charite.de>
Message-ID: <Pine.LNX.4.58.0404071324050.10871@alpha.polcom.net>
References: <200404071222.21397.rjwysocki@sisk.pl>
 <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <20040407103934.GG20293@charite.de>
 <Pine.LNX.4.58.0404071247120.10871@alpha.polcom.net> <20040407105522.GN20293@charite.de>
 <Pine.LNX.4.58.0404071300250.10871@alpha.polcom.net> <20040407110608.GR20293@charite.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, that should be easy to debug... I hope :-)

Try to apply this patch to check what kernel part call connect function 
too many times. (Maybe it is some power management stuff?)

WARNING
It is my first "public" patch and I even not compiled it so maybe some 
headers should be declared. But if it will compile and run, it should 
display nice callstack in log for you for each call to this function. 


happy testing

Grzegorz



--- linux-2.6.5/drivers/input/keyboard/atkbd.c.orig     2004-04-04 
05:37:43.000000000 +0200
+++ linux-2.6.5/drivers/input/keyboard/atkbd.c  2004-04-07 
14:23:26.719121672 +0200
@@ -679,6 +679,8 @@
 {
        struct atkbd *atkbd;
        int i;
+
+       dump_stack();
  
        if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
                return;


