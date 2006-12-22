Return-Path: <linux-kernel-owner+w=401wt.eu-S1751007AbWLVQzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWLVQzc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWLVQzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 11:55:32 -0500
Received: from web56613.mail.re3.yahoo.com ([66.196.97.57]:23858 "HELO
	web56613.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751005AbWLVQzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 11:55:31 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 11:55:31 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=URxGA02YMQoRe+52mA/VsToShVxm5uguzbNEBLDS9BVbKw9AqAdj4XtKV7ACJA+KrKjiTkPCePIWygrjTRkAiHaok0PFTnsWpj+c+Rad3a8iddIkBsEyaiQXbckAuzIsQBkD2igqvtfyyuQGGPcExRgJyq5fJlxRwUCBm/vD51w=;
Date: Fri, 22 Dec 2006 08:48:49 -0800 (PST)
From: s s <situert@yahoo.com>
Subject: [PATCH] Make mkcompile_h use LANG=C and LC_ALL=C for $CC -v
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <838466.99944.qm@web56613.mail.re3.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch fixes a minor bug in mkcompile_h.
As one can see, the current locale is used while
getting the version of gcc. This produces problems
when a locale other than C or en_US is used.
As an example, my /proc/version contains Turkish
characters in iso-8859-9 encoding.

This patch fixes this issue by making sure that
the C locale is used to get gcc's version.

Regards,
situert

--- linux-2.6.19.1/scripts/mkcompile_h.original	2006-12-22 18:31:22.000000000 +0200
+++ linux-2.6.19.1/scripts/mkcompile_h	2006-12-22 18:31:39.000000000 +0200
@@ -58,7 +58,7 @@
     echo \#define LINUX_COMPILE_DOMAIN
   fi
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
+  echo \#define LINUX_COMPILER \"`LC_ALL=C LANG=C $CC -v 2>&1 | tail -n 1`\"
 ) > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
