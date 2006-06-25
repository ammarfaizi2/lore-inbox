Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWFYXNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWFYXNx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWFYXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:13:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17683 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932417AbWFYXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:13:31 -0400
Date: Mon, 26 Jun 2006 01:13:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org
Subject: [-mm patch] fs/cifs/cifsproto.h: remove #ifdef around small_smb_init_no_tc() prototype
Message-ID: <20060625231329.GM23314@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm1:
>...
> +cifs-build-fix.patch
> 
>  Fix git-cifs.patch.
>...

Let's hope gcc guesses the prototye of the function right.

Otherwise, this patch has turned a compile error into a nasty runtime 
error (in many cases, the stack is garbage).

The -Werror-implicit-function-declaration gcc flag would turn such 
possible problems into compile errors.

This patch removes the (never required) #ifdef from the prototype of 
thie function in fs/cifs/cifsproto.h. 
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2-full/fs/cifs/cifsproto.h.old	2006-06-26 00:00:56.000000000 +0200
+++ linux-2.6.17-mm2-full/fs/cifs/cifsproto.h	2006-06-26 00:01:02.000000000 +0200
@@ -64,11 +64,9 @@
 extern void header_assemble(struct smb_hdr *, char /* command */ ,
 			    const struct cifsTconInfo *, int /* length of
 			    fixed section (word count) in two byte units */);
-#ifdef CONFIG_CIFS_EXPERIMENTAL
 extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
 				struct cifsSesInfo *ses,
 				void ** request_buf);
-#endif
 extern int CIFS_SessSetup(unsigned int xid, struct cifsSesInfo *ses,
 			     const int stage, 
 			     const struct nls_table *nls_cp);

