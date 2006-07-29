Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWG2Imv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWG2Imv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWG2Imv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:42:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:17219 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750747AbWG2Imv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:42:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZCXevOyNYOFggx6HWyNUG4fzkyWByhkCUpLUjlwIYIobipeEe1E5mxg7jDRZziCN5WiR6wMSIoflKGwHMDvyyogQeRiUX3JSI8d5y0cMU4mih3vLLwNAXFXnHzevf1tWIQLt8liAUXsGXTeCBXNOCR/DWt/OkeoLB84JM85bUpY=
Date: Sat, 29 Jul 2006 12:42:48 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] headers_check: fix #include regexp
Message-ID: <20060729084248.GE6843@martell.zuzino.mipt.ru>
References: <20060729082249.GD6843@martell.zuzino.mipt.ru> <20060729082511.GB26956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729082511.GB26956@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 09:25:11AM +0100, Russell King wrote:
> On Sat, Jul 29, 2006 at 12:22:49PM +0400, Alexey Dobriyan wrote:
> > Note it's [SPACE TAB]*
> 
> Why not use [[:space:]] rather than [ 	] ?  It's hard to see what black
> characters on a black background are actually trying to do.

Indeed. What about this? I assume nobody sane would use \n, \f or \v in
between ;-)

[PATCH] headers_check: fix #include regexp

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

