Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSHBWqU>; Fri, 2 Aug 2002 18:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSHBWqU>; Fri, 2 Aug 2002 18:46:20 -0400
Received: from [64.105.35.211] ([64.105.35.211]:62889 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314078AbSHBWqT>; Fri, 2 Aug 2002 18:46:19 -0400
Date: Fri, 2 Aug 2002 15:49:24 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: tytso@mit.edu
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, axel@hh59.org,
       rmk@arm.linux.org.uk
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Message-ID: <20020802154924.A5505@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.30/include/linux/serialP.h needs struct async_icount,
which is defined in <linux/serial.h>, causing
linux-2.5.30/drivers/serial/8250.c not to compile, among other problems.
In linux-2.5.30, you cannot compile a file that includes <linux/serialP.h>
without including <linux/serial.h>.  So, I think the solution is for
serialP.h to #include serial.h.  I have attached a patch that does this.

	From the comments in serialP.h, it looks like there was some
effort in linux-2.2 to allow inclusion of serialP.h without serial.h,
but I see no indication of what benefit that was supposed to provide.

	Ted (or whowever gathers drivers/serial patches for Linus), do
you want to shepherd this change to Linus, do you want me to submit it
directly, or do you want to do something else?

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="serialP.diff"

--- linux-2.5.30/include/linux/serialP.h	2002-08-01 14:16:07.000000000 -0700
+++ linux/include/linux/serialP.h	2002-08-02 14:51:03.000000000 -0700
@@ -24,11 +24,7 @@
 #include <linux/tqueue.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
-#if (LINUX_VERSION_CODE < 0x020300)
-/* Unfortunate, but Linux 2.2 needs async_icount defined here and
- * it got moved in 2.3 */
 #include <linux/serial.h>
-#endif
 
 struct serial_state {
 	int	magic;

--d6Gm4EdcadzBjdND--
