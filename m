Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSCCVrK>; Sun, 3 Mar 2002 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSCCVrA>; Sun, 3 Mar 2002 16:47:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12815 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289046AbSCCVqz>; Sun, 3 Mar 2002 16:46:55 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Sun, 3 Mar 2002 22:01:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203032112.QAA03497@ccure.karaya.com> from "Jeff Dike" at Mar 03, 2002 04:12:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16he2s-0005ak-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason for this is that for UML, those pages are backed by host memory,
> which may or may not be available when they are finally touched at some
> arbitrary place in the kernel.  I hit this by tmpfs running out of room
> because my UMLs have their memory backed by tmpfs mounted on /tmp.  So, I
> want to be able to dirty those pages before they are seen by any other code.

No - you think you want to dirty the pages - you want to account the address
space. What you want to do is run 2.4.18ac3 and do

	echo "2" > /proc/sys/vm/overcommit_memory

which on a good day will give you overcommit protection. Your map requests
will fail without the pages being dirtied and the extra swap that would
cause. It knows about tmpfs too but not ramfs, ramdisk or ptrace yet

Alan
