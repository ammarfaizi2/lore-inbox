Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbTH2Que (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbTH2Que
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:50:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:17824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261499AbTH2Quc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:50:32 -0400
Date: Fri, 29 Aug 2003 09:34:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: 2.6.0-test4-mm3
Message-Id: <20030829093424.1f02cebe.akpm@osdl.org>
In-Reply-To: <200308291627.h7TGRoX02912@mail.osdl.org>
References: <20030829083540.58c9dd47.akpm@osdl.org>
	<200308291627.h7TGRoX02912@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> This also breaks STP. We installed module-init-tools using the 'moveold' 
> method,
> so we can still run 2.4.
> Our depmod is in /usr/local/sbin. 
> Using /sbin/depmod hoses us. Using PATH works for us.

Hrm, but your build must be playing up already:

dhcp-140-218:/usr/src/25> grep DEPMOD Makefile
DEPMOD          = /sbin/depmod
        @if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
        if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi

> [root@stp1-002 linux]# depmod -V
> module-init-tools 0.9.12
> 
> [root@stp1-002 linux]# /sbin/depmod -V
> depmod version 2.4.22
> 
> [root@stp1-002 linux]# /usr/local/sbin/depmod -V
> module-init-tools 0.9.12
> 
> Please send patch, we'll get some tests moving.

--- 25/Makefile~old-module-tools-warning-fix	Fri Aug 29 09:31:46 2003
+++ 25-akpm/Makefile	Fri Aug 29 09:32:16 2003
@@ -609,7 +609,7 @@ _modinst_:
 	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
 		echo "Install a current version of module-init-tools"; \
 		echo "See http://www.codemonkey.org.uk/post-halloween-2.5.txt";\
-		/bin/false; \
+		sleep 1; \
 	fi
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/build

_

