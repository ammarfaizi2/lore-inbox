Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUHaQ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUHaQ7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUHaQ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:59:53 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:5671 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264389AbUHaQ7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:59:51 -0400
Date: Tue, 31 Aug 2004 19:01:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: external modules make clean doesn't do much
Message-ID: <20040831170148.GB7310@mars.ravnborg.org>
Mail-Followup-To: Duncan Sands <baldrick@free.fr>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <200408311347.52754.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408311347.52754.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:47:52PM +0200, Duncan Sands wrote:
> make clean for an external module only seems to clean
> .tmp_versions:
> 
> $ make clean
> make -C /lib/modules/2.6.9-rc1/build M=`pwd` clean
> make[1]: Entering directory `/home/duncan/Linux/linux-2.5'
>   CLEAN   /home/duncan/SpeedTouch/.tmp_versions
> make[1]: Leaving directory `/home/duncan/Linux/linux-2.5'
> $
> 
> This leaves all the .o etc files which doesn't sound right...
Nope - let me try.

sam@mars rtl8180 $ ls *o
built-in.o   r8180_if.o        rtl8180.ko     rtl8180.o
priv_part.o  r8180_pci_init.o  rtl8180.mod.o  usercopy.o
sam@mars rtl8180 $ make -C ~/bk/kbuild M=$PWD clean
make: Entering directory `/home/sam/bk/kbuild'
  CLEAN   /home/sam/bk/external/rtl8180/.tmp_versions
make: Leaving directory `/home/sam/bk/kbuild'
sam@mars rtl8180 $ ls *o
ls: *o: No such file or directory
sam@mars rtl8180 $ cat Makefile
obj-m           := rtl8180.o
rtl8180-y       += r8180_if.o r8180_pci_init.o usercopy.o
rtl8180-y       += priv_part.o
  

Looks to be OK here.
Please let me see the Makefile you use for SpeedTouch

	Sam
