Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313140AbSDDK4u>; Thu, 4 Apr 2002 05:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313139AbSDDK4k>; Thu, 4 Apr 2002 05:56:40 -0500
Received: from [203.115.6.227] ([203.115.6.227]:26372 "EHLO shalmirane.net")
	by vger.kernel.org with ESMTP id <S313136AbSDDK4W>;
	Thu, 4 Apr 2002 05:56:22 -0500
Date: Thu, 4 Apr 2002 16:55:35 -0600 (GMT+6)
From: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
To: marcelo@conectiva.com.br
cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] kjournald locking fix
Message-ID: <Pine.LNX.4.21.0204041643400.1396-200000@shalmirane.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-789257715-1017960935=:1396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-789257715-1017960935=:1396
Content-Type: TEXT/PLAIN; charset=US-ASCII

Greetings everyone,

	Here's an improved version of my previous patch. Thanks to Andrew
Morton for the advice. 2.5 needs this too I think, since preemption is
part of it now...

Ishan O. Jayawardena


----------------------------------------------------------------

--- linux-preempt/fs/jbd/journal.c.1	Wed Apr  3 08:05:08 2002
+++ linux-preempt/fs/jbd/journal.c	Thu Apr  4 16:41:56 2002
@@ -204,6 +204,7 @@ int kjournald(void *arg)
 
 	lock_kernel();
 	daemonize();
+	reparent_to_init();
 	spin_lock_irq(&current->sigmask_lock);
 	sigfillset(&current->blocked);
 	recalc_sigpending(current);
@@ -267,6 +268,7 @@ int kjournald(void *arg)
 
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
+	unlock_kernel();
 	jbd_debug(1, "Journal thread exiting.\n");
 	return 0;
 }

---1463811840-789257715-1017960935=:1396
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kjournald.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0204041655350.1396@shalmirane.net>
Content-Description: 
Content-Disposition: attachment; filename="kjournald.diff"

LS0tIGxpbnV4LXByZWVtcHQvZnMvamJkL2pvdXJuYWwuYy4xCVdlZCBBcHIg
IDMgMDg6MDU6MDggMjAwMg0KKysrIGxpbnV4LXByZWVtcHQvZnMvamJkL2pv
dXJuYWwuYwlUaHUgQXByICA0IDE2OjQxOjU2IDIwMDINCkBAIC0yMDQsNiAr
MjA0LDcgQEAgaW50IGtqb3VybmFsZCh2b2lkICphcmcpDQogDQogCWxvY2tf
a2VybmVsKCk7DQogCWRhZW1vbml6ZSgpOw0KKwlyZXBhcmVudF90b19pbml0
KCk7DQogCXNwaW5fbG9ja19pcnEoJmN1cnJlbnQtPnNpZ21hc2tfbG9jayk7
DQogCXNpZ2ZpbGxzZXQoJmN1cnJlbnQtPmJsb2NrZWQpOw0KIAlyZWNhbGNf
c2lncGVuZGluZyhjdXJyZW50KTsNCkBAIC0yNjcsNiArMjY4LDcgQEAgaW50
IGtqb3VybmFsZCh2b2lkICphcmcpDQogDQogCWpvdXJuYWwtPmpfdGFzayA9
IE5VTEw7DQogCXdha2VfdXAoJmpvdXJuYWwtPmpfd2FpdF9kb25lX2NvbW1p
dCk7DQorCXVubG9ja19rZXJuZWwoKTsNCiAJamJkX2RlYnVnKDEsICJKb3Vy
bmFsIHRocmVhZCBleGl0aW5nLlxuIik7DQogCXJldHVybiAwOw0KIH0NCg==
---1463811840-789257715-1017960935=:1396--
