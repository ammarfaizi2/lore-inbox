Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbRFGRaF>; Thu, 7 Jun 2001 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbRFGR3z>; Thu, 7 Jun 2001 13:29:55 -0400
Received: from [209.250.58.153] ([209.250.58.153]:45830 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S262600AbRFGR3p>; Thu, 7 Jun 2001 13:29:45 -0400
Date: Thu, 7 Jun 2001 12:28:53 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Friedrich Lobenstock <fl@fl.priv.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ftape and kernel 2.4 problem
Message-ID: <20010607122853.A26252@hapablap.dyn.dhs.org>
In-Reply-To: <3B1F99DF.6CCF6DF3@fl.priv.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1F99DF.6CCF6DF3@fl.priv.at>; from fl@fl.priv.at on Thu, Jun 07, 2001 at 05:12:31PM +0200
X-Uptime: 12:10pm  up 1 day, 20:30,  1 user,  load average: 2.35, 2.32, 2.28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a patch I wrote to allow ftape to compile against 2.4.something.
It still works with 2.4.5.  I'm not sure if it works entirely (it seems
to), but it compiles and seems to work.  Enjoy!

On Thu, Jun 07, 2001 at 05:12:31PM +0200, Friedrich Lobenstock wrote:
> Hi!
> 
> As the linux-ftape mailing list is gone I'm asking you guys.
> 
> Can someone tell me how to adapt the ftape driver that I can use it
> under kernel 2.4.x (x >= 5)? I'm not that into kernel hacking that
> I know what changed from 2.2.x to 2.4.x. Below is the output of make.
> 
> BTW why wasn't the newer ftape driver ported to 2.4 but the stone age
> ftape driver is still in 2.4?
> 
> PS: Please CC me because I'm not on linux-kernel.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ftape-patch

diff -ru ftape-4.04a/ftape/lowlevel/ftape-init.h ftape-4.04a.mod/ftape/lowlevel/ftape-init.h
--- ftape-4.04a/ftape/lowlevel/ftape-init.h	Mon Jul  3 05:13:06 2000
+++ ftape-4.04a.mod/ftape/lowlevel/ftape-init.h	Mon Feb  5 18:58:42 2001
@@ -67,7 +67,7 @@
 }
 extern inline int ft_sigtest(unsigned long mask)
 {
-	return (current->signal.sig[0] & mask);
+	return (current->sigpending & mask);
 }
 extern inline int ft_killed(void)
 {
diff -ru ftape-4.04a/include/linux/ftape.h ftape-4.04a.mod/include/linux/ftape.h
--- ftape-4.04a/include/linux/ftape.h	Tue Jul 25 06:04:47 2000
+++ ftape-4.04a.mod/include/linux/ftape.h	Mon Feb  5 18:59:35 2001
@@ -28,7 +28,7 @@
  *      for the QIC-40/80/3010/3020 floppy-tape driver for Linux.
  *
  */
-
+#define __initlocaldata __initdata
 #define FTAPE_VERSION "ftape v4.04a 07/25/2000"
 
 #ifdef __KERNEL__

--zhXaljGHf11kAtnf--
