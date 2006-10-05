Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWJEVmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWJEVmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWJEVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:21 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:106 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932249AbWJEVl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=kpkWbmqiSqWpelwI+uogU/WIQVEkK90BsY68aYVDcrcjbZDQLDAYs87YF93XHupReLTPPl4M7q0HtFXLNIC4LKp1j33+IfsJx+OSbHVmudDpLpBZUSkEYmU4yWarH51p8f7f60e/uWDo8JONYOMTn5Cm70iKSQAmUw4VcZL4Btc=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/14] uml: fix uname under setarch i386
Date: Thu, 05 Oct 2006 23:38:58 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213858.17268.99875.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

On a 64bit Uml, if run under "setarch i386" (which a user did), uname()
currently returns the obtained i686 as machine - fix that. Btw, I'm quite
surprised that under setarch i386 a 64-bit binary can run.

Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/util.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 3f5b151..56b8a50 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -80,11 +80,18 @@ void setup_machinename(char *machine_out
 	struct utsname host;
 
 	uname(&host);
-#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
+#ifdef UML_CONFIG_UML_X86
+# ifndef UML_CONFIG_64BIT
 	if (!strcmp(host.machine, "x86_64")) {
 		strcpy(machine_out, "i686");
 		return;
 	}
+# else
+	if (!strcmp(host.machine, "i686")) {
+		strcpy(machine_out, "x86_64");
+		return;
+	}
+# endif
 #endif
 	strcpy(machine_out, host.machine);
 }
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
