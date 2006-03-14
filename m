Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWCNWrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWCNWrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWCNWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:47:05 -0500
Received: from web52612.mail.yahoo.com ([206.190.48.215]:6312 "HELO
	web52612.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964795AbWCNWrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:47:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HD7dteruAqKLYi7hz+4Hqwg2KKHqrdYS5ovqYKCwoczU7hVODO60i22eL8dFxTNwAyHp6yYaIWL5Jtjw09q3X3R0ujhblq2yt2xXqx9g0vTEUCghP/vaG3Jzr4tNa7iS4wPJqFp0cn5fIoz4p7ESgiy536H9+RrhwjuMelTfGxU=  ;
Message-ID: <20060314224700.41242.qmail@web52612.mail.yahoo.com>
Date: Wed, 15 Mar 2006 09:47:00 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Module Ref Counting & ibmphp
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before (in 2.6.16-rc*):
$ egrep 'ibmphp' /proc/modules
ibmphp 67809 4294967295 - Live 0xf8910000
             ^^^^^^^^^^

After [1]:
ibmphp 64224 0 - Live 0xf8965000
             ^

Of course, now I'm able to successfully unload ibmphp
(& subsequently load it too :)) without any
observeable problems.

It'd seem, thro struct hotplug_slot_ops, module ref
count for ibmphp is taken care of. No?

Correct me, if I'm completely wrong here. Perhaps,
there may be a better way to address this that I'm
unaware of. If so, enlighten me.

I'm afraid I've no hardware to verify whether the
patch introduces any regressions.

Thanks

[1]
--- 2.6.16-rc6/drivers/pci/hotplug/ibmphp_core.c.orig
2006-03-15 03:37:38.000000000 +1100
+++ 2.6.16-rc6/drivers/pci/hotplug/ibmphp_core.c
2006-03-14 16:57:26.000000000 +1100
@@ -1398,10 +1398,6 @@
 		goto error;
 	}
 
-	/* lock ourselves into memory with a module 
-	 * count of -1 so that no one can unload us. */
-	module_put(THIS_MODULE);
-
 exit:
 	return rc;




		
____________________________________________________ 
On Yahoo!7 
Answers: Real people ask and answer questions on any topic. 
http://www.yahoo7.com.au/answers.
