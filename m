Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWFUPzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWFUPzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWFUPzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:55:12 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:7003 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751174AbWFUPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:55:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tYZ4B+4UfKZo52JvNkSo9xlJ3ou6SzhiW8xSQpnz0frYsX2ZSGMKbn7wlHw2xjdZopfqNZu6HnXttU25sVFwdMPNMotgChlz/gHj9Iuk7cA+k2RoUVgI/85Xg+49i/C8VLpoYpG9BZJvDrAoCChIjQ1PjsoRHH6iJYptaBW9WaE=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: mingo@elte.hu, tglx@timesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17-rt1 ommit an oops when suspending
Date: Wed, 21 Jun 2006 17:54:54 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211754.55059.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

with this applied my AMD64 suspended resumed successfully 
in PREEMPT_RT mode. Erm at least until now ;-)
Takes longer than with mainline.

Signed-off-by: Karsten Wiese <annabellesgraden@yahoo.de>



diff -ru rt1/kernel/time/clockevents.c rt1-kw/kernel/time/clockevents.c
--- rt1/kernel/time/clockevents.c	2006-06-20 21:39:21.000000000 +0200
+++ rt1-kw/kernel/time/clockevents.c	2006-06-21 17:25:50.000000000 +0200
@@ -547,7 +547,7 @@
 global_eventsource_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/* Do generic stuff here */
-	if (global_eventsource.event->suspend)
+	if (global_eventsource.event && global_eventsource.event->suspend)
 		global_eventsource.event->suspend();
 	return 0;
 }
@@ -555,7 +555,7 @@
 static int global_eventsource_resume(struct sys_device *dev)
 {
 	/* Do generic stuff here */
-	if (global_eventsource.event->resume)
+	if (global_eventsource.event && global_eventsource.event->resume)
 		global_eventsource.event->resume();
 	return 0;
 }

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
