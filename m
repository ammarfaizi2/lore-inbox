Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWHAEYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWHAEYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWHAEYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:24:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:64427 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161001AbWHAEYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:24:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=syn/OQgiPuQwLgXQhnnjlnFLNd/R09ZbWhmy9AUWrpIuZuiNVnxx5v9CMFJ6wwMmgFBH71VUwakAdFm1iL6dqq02xQ3DVcPrEkqOovJNPu1Cvfg1qG6Dw6eiA1rAp1Ak6I6bgH5bDWGVYv9Vr8UKQhBkXLdlkO9/7sobCimQxao=
Date: Tue, 1 Aug 2006 08:24:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] headers_check: improve #include regexp
Message-ID: <20060801042403.GF7006@martell.zuzino.mipt.ru>
References: <20060729082249.GD6843@martell.zuzino.mipt.ru> <20060729082511.GB26956@flint.arm.linux.org.uk> <20060729084248.GE6843@martell.zuzino.mipt.ru> <20060730122441.6db7bda2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730122441.6db7bda2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of headers_check-fix-include-regexp.patch
-----------------------------------------------------
The following combinations of pp-tokens are used

	#include
	 #include
	# include

so, script'd better check for all of them.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/hdrcheck.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/hdrcheck.sh
+++ b/scripts/hdrcheck.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-for FILE in `grep '^#include <' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
+for FILE in `grep '^[ \t]*#[ \t]*include[ \t]*<' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
     if [ ! -r $1/$FILE ]; then
 	echo $2 requires $FILE, which does not exist in exported headers
 	exit 1

