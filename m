Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263004AbTC0Pkh>; Thu, 27 Mar 2003 10:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263005AbTC0Pkg>; Thu, 27 Mar 2003 10:40:36 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:25870 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S263004AbTC0Pkg>; Thu, 27 Mar 2003 10:40:36 -0500
Date: Fri, 28 Mar 2003 02:51:18 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, <davidel@xmailserver.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete messages ...
In-Reply-To: <20030327.065911.29350824.davem@redhat.com>
Message-ID: <Mutt.LNX.4.44.0303280245110.29968-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, David S. Miller wrote:

> Now, I'll all for netratelimit()'ing the networking ones.

What about warning just once like the SOCK_PACKET one?


- James
-- 
James Morris
<jmorris@intercode.com.au>

--- linux-2.5.66.orig/net/core/sock.c	Tue Mar 25 23:09:41 2003
+++ linux-2.5.66.w2/net/core/sock.c	Fri Mar 28 02:47:31 2003
@@ -155,8 +155,13 @@
 
 static void sock_warn_obsolete_bsdism(const char *name)
 {
-	printk(KERN_WARNING "process `%s' is using obsolete "
-	       "%s SO_BSDCOMPAT\n", current->comm, name);
+	static int warned;
+	
+	if (!warned) {
+		warned = 1;
+		printk(KERN_WARNING "process `%s' is using obsolete "
+		       "%s SO_BSDCOMPAT\n", current->comm, name);
+	}
 }
 
 /*

