Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbQKMRXJ>; Mon, 13 Nov 2000 12:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129425AbQKMRW7>; Mon, 13 Nov 2000 12:22:59 -0500
Received: from napalm.go.cz ([212.24.148.98]:4100 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S129307AbQKMRWo>;
	Mon, 13 Nov 2000 12:22:44 -0500
Date: Mon, 13 Nov 2000 18:21:59 +0100
From: Jan Dvorak <johnydog@go.cz>
To: Chris Evans <chris@scary.beasts.org>
Cc: Torsten.Duwe@caldera.de, Francis Galiegue <fg@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
Message-ID: <20001113182158.A332@napalm.go.cz>
Mail-Followup-To: Chris Evans <chris@scary.beasts.org>,
	Torsten.Duwe@caldera.de, Francis Galiegue <fg@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de> <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk>; from chris@scary.beasts.org on Mon, Nov 13, 2000 at 04:56:40PM +0000
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 13, 2000 at 04:56:40PM +0000, Chris Evans wrote:
> 
> On Mon, 13 Nov 2000, Torsten Duwe wrote:
> 
> Code in a security sensitive area needs to be crystal clear.
> 
> What's wrong with isalnum() ?
> 

What about this then ?


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.kmod"

--- kmod.c.orig	Sat Nov  4 20:02:11 2000
+++ kmod.c	Mon Nov 13 18:18:06 2000
@@ -169,6 +169,20 @@
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
 
+	const char * p;
+
+	/* For security reasons ensure the requested name consists
+	* only of allowed characters. Especially whitespace and
+	* shell metacharacters might confuse modprobe.
+	*/
+	for (p = module_name; *p; p++)
+	{
+		if (isalnum(*p) || *p=='_' || *p=='-')
+			continue;
+
+		return -EINVAL;
+	}
+
 	/* Don't allow request_module() before the root fs is mounted!  */
 	if ( ! current->fs->root ) {
 		printk(KERN_ERR "request_module[%s]: Root fs not mounted\n",

--cNdxnHkX5QqsyA0e--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
