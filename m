Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbTDBMDz>; Wed, 2 Apr 2003 07:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbTDBMDz>; Wed, 2 Apr 2003 07:03:55 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:59867 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S262984AbTDBMDx>; Wed, 2 Apr 2003 07:03:53 -0500
Date: Wed, 2 Apr 2003 14:15:04 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: genksyms crashes on drivers/char/joystick/pcigame.c
Message-ID: <20030402121504.GS1870@os.inf.tu-dresden.de>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
References: <20030401151918.GJ1870@os.inf.tu-dresden.de> <25740.1049282231@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <25740.1049282231@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 02, 2003 at 21:17:11 +1000, Keith Owens wrote:
> On Tue, 1 Apr 2003 17:19:18 +0200, 
> Adam Lackorzynski <adam@os.inf.tu-dresden.de> wrote:
> >when genksyms is used on drivers/char/joystick/pcigame.c during "make
> >dep" it segfaults.
> 
> genksyms assumes and requires valid C code as input.  genksyms does not
> attempt to validate the source, that is the job of gcc.  If gcc barfs
> on the code, then do not attempt to run it through genksyms.  This
> looks like a chicken and egg problem but is not, compile with
> MODVERSIONS=n to verify that new code is valid before building with
> MODVERSIONS=y.  To put it another way, do not run modversions on test
> kernels.

I don't understand a vanilla 2.4.20 kernel as a "test kernel". This
segfault happens everytime a "make dep" with modversions and without
these joystick options is done and that's probably not too uncommon.
There's just no error message indicating that it's faulting.
Changing include/linux/pci_gameport.h prevents genksyms from segfaulting and
produces output, I'm not sure if this has other side effects.


For 2.4.20:
--- include/linux/pci_gameport.h.orig   2003-04-02 14:00:46.000000000 +0200
+++ include/linux/pci_gameport.h        2003-04-02 14:02:01.000000000 +0200
@@ -31,9 +31,6 @@
 #if defined(CONFIG_INPUT_PCIGAME) || defined(CONFIG_INPUT_PCIGAME_MODULE)
 extern struct pcigame *pcigame_attach(struct pci_dev *dev, int type);
 extern void pcigame_detach(struct pcigame *game);
-#else
-#define pcigame_attach(a,b)    NULL
-#define pcigame_detach(a)
 #endif
 
 #endif





Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
