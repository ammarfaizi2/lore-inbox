Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWJEVly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJEVly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWJEVly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:41:54 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:39858 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932251AbWJEVlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=5kkjSDWkKakxArkG7959YZ6ph2jNye5mmFVzM0mD4pNp7jmg0NmExwPDmleN+wn6YtsPfJU1ZPlsOXMbwt2X2c3zcYh+N/OzZLObMWmV+b2C1wmA8w13kW0DrhOkaRXXKvclmOTnA15ydTn6mDRtV/n0IsFphBVjlqtiVPg/ipo=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/14] uml: make UML_SETJMP always safe
Date: Thu, 05 Oct 2006 23:38:52 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213852.17268.13871.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

If enable is moved by GCC in a register its value may not be preserved after
coming back there with longjmp(). So, mark it as volatile to prevent this; this
is suggested (it seems) in info gcc, when it talks about -Wuninitialized. I
re-read this and it seems to say something different, but I still believe this
may be needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/longjmp.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/include/longjmp.h b/arch/um/include/longjmp.h
index e93c6d3..e860bc5 100644
--- a/arch/um/include/longjmp.h
+++ b/arch/um/include/longjmp.h
@@ -12,7 +12,8 @@ #define UML_LONGJMP(buf, val) do { \
 } while(0)
 
 #define UML_SETJMP(buf) ({ \
-	int n, enable;	   \
+	int n;	   \
+	volatile int enable;	\
 	enable = get_signals(); \
 	n = setjmp(*buf); \
 	if(n != 0) \
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
