Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277976AbRJKDGX>; Wed, 10 Oct 2001 23:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRJKDGL>; Wed, 10 Oct 2001 23:06:11 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:23468
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277976AbRJKDGA>; Wed, 10 Oct 2001 23:06:00 -0400
Date: Wed, 10 Oct 2001 20:06:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac11
Message-ID: <20011010200619.D11147@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 12:16:17AM +0100, Alan Cox wrote:

> 2.4.10-ac11
[snip]
> o	Blink keyboard lights on panic on x86		(Andi Kleen)

I _suspect_ this is what caused drivers/char/pc_keyb.c to depend on
<linux/pm.h>.  This works on x86 because <asm-i386/keyboard.h> includes
<linux/pm.h>.  The inlined moves the include to pc_keyb.c so that other
arches compile fine.  I also _think_ nothing else needs the include in
<asm-i386/keyboard.h> so kill that off too.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- linux-2.4.10-ac11.orig/drivers/char/pc_keyb.c	Wed Oct 10 19:10:27 2001
+++ linux-2.4.10-ac11/drivers/char/pc_keyb.c	Wed Oct 10 19:35:15 2001
@@ -34,6 +34,7 @@
 #include <linux/vt_kern.h>
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
+#include <linux/pm.h>
 
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
--- linux-2.4.10-ac11.orig/include/asm-i386/keyboard.h	Wed Oct 10 19:10:50 2001
+++ linux-2.4.10-ac11/include/asm-i386/keyboard.h	Wed Oct 10 19:35:09 2001
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/kd.h>
-#include <linux/pm.h>
 #include <asm/io.h>
 
 #define KEYBOARD_IRQ			1
