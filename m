Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWBYSbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWBYSbf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWBYSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:31:35 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:61580 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161050AbWBYSbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:31:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oC+KMkF3udJNDTPzoGh/Cj2e4eGWhGjJ/sFgxITbtYKlUGL726AOU+LUpMs4OGkASgA6qMwkFDz4sM7k+x3MI2q4kj1knUaLn2EocgsDEvbjHmvtZ0tXR01sUOd0EYZu6XjAxnQ40bw9eRDOgjn1hWPEKrgsSS31d6nKwGOnAf8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: David Howells <dhowells@redhat.com>
Subject: [PATCH] fix 'defined but not used' warning in net/rxrpc/main.c::rxrpc_initialise
Date: Sat, 25 Feb 2006 19:31:50 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251931.50545.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fix a 'defined but not used' warning in net/rxrpc/main.c::rxrpc_initialise()

  net/rxrpc/main.c: In function `rxrpc_initialise':
  net/rxrpc/main.c:83: warning: label `error_proc' defined but not used

The only user of the label is inside  #ifdef CONFIG_SYSCTL  so move the label
inside as well to silence the warning.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/rxrpc/main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm2-orig/net/rxrpc/main.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-mm2/net/rxrpc/main.c	2006-02-25 19:23:39.000000000 +0100
@@ -79,8 +79,8 @@ static int __init rxrpc_initialise(void)
  error_sysctl:
 #ifdef CONFIG_SYSCTL
 	rxrpc_sysctl_cleanup();
-#endif
  error_proc:
+#endif
 #ifdef CONFIG_PROC_FS
 	rxrpc_proc_cleanup();
 #endif


