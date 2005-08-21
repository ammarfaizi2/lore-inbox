Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVHUJSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVHUJSV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVHUJSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:18:21 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:9960 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750893AbVHUJSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:18:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=de+75SCEPlzISiPzyqkdsW4xGbUPI/1TLEOSq4RKvK73hTy6HdI+4bxdVjizlGYL5WQURapsVuOYBytkwzIRU9dMz5hP18ndiImPzrC67JoEoSovPPtn549P5RxoJDNIR0teVvRp10QpL1z8/KbdghFrqJPQ+Tf17hywaf793YM=
Date: Sun, 21 Aug 2005 13:26:06 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Adapt scripts/ver_linux to new util-linux version strings
Message-ID: <20050821092606.GB23626@mipter.zuzino.mipt.ru>
References: <20050820035853.GM3615@stusta.de> <20050820055532.GA15577@mipter.zuzino.mipt.ru> <20050820190242.GY3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820190242.GY3615@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with 2.12i and 2.13-pre2.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/ver_linux |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-vanilla/scripts/ver_linux
+++ linux-util-linux/scripts/ver_linux
@@ -25,9 +25,11 @@
 '/BFD/{print "binutils              ",$NF} \
 /^GNU/{print "binutils              ",$4}'
 
-fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
+echo -n "util-linux             "
+fdformat --version | awk '{print $NF}' | sed -e s/^util-linux-// -e s/\)$//
 
-mount --version | awk -F\- '{print "mount                 ", $NF}'
+echo -n "mount                  "
+mount --version | awk '{print $NF}' | sed -e s/^mount-// -e s/\)$//
 
 depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 

