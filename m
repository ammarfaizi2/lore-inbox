Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272359AbRH3ReH>; Thu, 30 Aug 2001 13:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272360AbRH3ReB>; Thu, 30 Aug 2001 13:34:01 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:30214 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272359AbRH3RdY>; Thu, 30 Aug 2001 13:33:24 -0400
Message-ID: <3B8E7871.81CF6E13@t-online.de>
Date: Thu, 30 Aug 2001 19:31:29 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mark A. Tagliaferro" <be_lak@yahoo.co.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problems with compiling kernel.
In-Reply-To: <20010830103609.96135.qmail@web14701.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark A. Tagliaferro" schrieb:
> 
> I'm using SuSE 7.1 and I had to compile the kernel to include SCSI support.
> That part is all well and good.  The problems started when I tried to set up
> masquerading.  Modprobe is returning the following error:
> 
> modprobe: Can't open dependencies file /lib/modules/2.4.2/modules.dep (No such
> file or directory)
> 
> I looked in /lib/modules/ and there the directory is called 2.4.2-4GB and not
> 2.4.2
> 
> I tried to fool it by creating a virtual link to the directory with the name
> 2.4.2 but then the modprobe returns a large number of kernal mismatch errors
> that the particular modules (iptable_nat) I am trying to run were written for
> kernel version 2.4.2-4GB and not 2.4.2
> 
> It looks like modprobe is looking for kernel version 2.4.2 but the modules are
> for kernel 2.4.2-4GB.
> 
(..)
> Any idea as to what I'm doing wrong?

Not clearly, but try the following:
Configure your Kernel and then add in the Toplevel-Makefile
(/usr/src/linux/Makefile) an "extra-Subrevision", e.g. 

-------
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 3
EXTRAVERSION = -12-TEST
 
KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
---------

Then compile.
The effect is, that now all the module-path and revision-numbers contain
this extra-info and you can easily track were the "right" modules are
stored and build.

Before you do a "make modules_install", delete the complete old
Module-Path (save the modules in another place if your are unsure), so
even the path has to be made new.
I had already strange problems with "make modules_install" not
overwriting old modules or deleting old ones that are not used any more.

> Did I have to recompile the kernel to load the aic7xxx or could I have added a
> command in some initialisation file to load it as a module (insmod)?

If you have "/" on a SCSI-Disk, you cannot boot and then load the
module...you would have to build a initrd-ramdisk, but i would suggest
to build in the SCSI-Support.
If you have "/" on an IDE-Drive you can build the SCSI-Support as Module
and then load it during bootup.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
