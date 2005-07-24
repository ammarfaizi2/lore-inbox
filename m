Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVGXVNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVGXVNO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVGXVNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:13:14 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:27856 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261359AbVGXVNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:13:13 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Date: Mon, 25 Jul 2005 07:13:02 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <0fv7e11ejvimjkfqib95n93hl34icavnbu@4ax.com>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de> <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com> <20050724203932.GX3160@stusta.de>
In-Reply-To: <20050724203932.GX3160@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 22:39:32 +0200, Adrian Bunk <bunk@stusta.de> wrote:

>On Mon, Jul 25, 2005 at 05:42:58AM +1000, Grant Coady wrote:
>> On Sun, 24 Jul 2005 11:13:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:
>> >
>> >it's generally useful, but the target kernel should be the latest -mm
>> >kernel. 
>> 097-error:drivers/char/drm/drm_memory.h:163: error: redefinition of `drm_ioremap_nocache'
>> 097-error:drivers/char/drm/drm_memory.h:163: error: `drm_ioremap_nocache' previously defined here
>> 097-error:drivers/char/drm/drm_memory.h:174: error: redefinition of `drm_ioremapfree'
>> 097-error:drivers/char/drm/drm_memory.h:174: error: `drm_ioremapfree' previously defined here
>
>This requires the .config for debugging.
Here:
  ftp://ftp.scatter.mine.nu/develop/trial4-097-config.gz

>My first guess is that drm_memory.h requires a simple #ifdef to allow 
>multiple inclusions.

I can tell you:
--- linux-2.6.12.3b/drivers/char/drm/drm_memory.h.orig	2005-06-18 05:48:29.000000000 +1000
+++ linux-2.6.12.3b/drivers/char/drm/drm_memory.h	2005-07-25 06:57:41.000000000 +1000
@@ -33,6 +33,9 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#ifndef DRM_MEMORY_H
+#define DRM_MEMORY_H
+
 #include <linux/config.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
@@ -194,4 +197,5 @@
 	iounmap(pt);
 }
 
+#endif

does not fix it, though it's probably not what you had in mind, first try...
Simple fix didn't...  Now I got to read the code, takes a little more 
effort :)
...
>You aren't running into problems that are already fixed (see your second 
>example above).
I see your point, thanks for feedback.  

Grant.

