Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSJMNvs>; Sun, 13 Oct 2002 09:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJMNvr>; Sun, 13 Oct 2002 09:51:47 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1544 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261600AbSJMNvn>;
	Sun, 13 Oct 2002 09:51:43 -0400
Date: Sun, 13 Oct 2002 15:57:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brett <brett@bad-sports.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, tz@execpc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild error in 2.5.4[12]
Message-ID: <20021013155726.A9175@mars.ravnborg.org>
Mail-Followup-To: Brett <brett@bad-sports.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, tz@execpc.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210131613200.2373-100000@bad-sports.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210131613200.2373-100000@bad-sports.com>; from brett@bad-sports.com on Sun, Oct 13, 2002 at 04:14:44PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 04:14:44PM +1000, Brett wrote:
> 
> Hey,
> 
> Got this error when compiling with CONFIG_PCMCIA_QLOGIC=m

The pcmia makefile utilised vpath, the last makefile in 2.5.42 according to
a fast grep.
The following patch made it compile for me, but there were warnings about cli
and friends, so you will not be able to do the final link.

I simply added "../" in front of qlogicfas.o - but this is my opinion not
the final solution for this so I did not sumbit it for inclusion.

Kai - if this is ok, could you include it in next round.
tz@execpc.com also copied - seems to be qlogicfas interested.

	Sam

===== drivers/scsi/pcmcia/Makefile 1.5 vs edited =====
--- 1.5/drivers/scsi/pcmcia/Makefile	Sat Mar 23 04:50:20 2002
+++ edited/drivers/scsi/pcmcia/Makefile	Sun Oct 13 09:56:49 2002
@@ -2,13 +2,6 @@
 # Makefile for the Linux PCMCIA SCSI drivers.
 #
 
-obj-y		:=
-obj-m		:=
-obj-n		:=
-obj-		:=
-
-vpath %c ..
-
 CFLAGS_aha152x.o = -DPCMCIA -D__NO_VERSION__ -DAHA152X_STAT
 CFLAGS_fdomain.o = -DPCMCIA -D__NO_VERSION__
 CFLAGS_qlogicfas.o = -DPCMCIA -D__NO_VERSION__
@@ -21,6 +14,6 @@
 
 aha152x_cs-objs	:= aha152x_stub.o aha152x.o
 fdomain_cs-objs	:= fdomain_stub.o fdomain.o
-qlogic_cs-objs	:= qlogic_stub.o qlogicfas.o
+qlogic_cs-objs	:= qlogic_stub.o ../qlogicfas.o
 
 include $(TOPDIR)/Rules.make
