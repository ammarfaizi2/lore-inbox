Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319188AbSH2LAf>; Thu, 29 Aug 2002 07:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319189AbSH2LAf>; Thu, 29 Aug 2002 07:00:35 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:56590 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319182AbSH2LAe>;
	Thu, 29 Aug 2002 07:00:34 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208291104.g7TB4uq04421@oboe.it.uc3m.es>
Subject: O_DIRECT
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 29 Aug 2002 13:04:56 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What functions does a block driver have to implement in order to
support read/write when it has been opened with O_DIRECT from user
space.

I have made some experiments with plain read/write after opening with 
O_DIRECT:

2.5.31:
   /dev/ram0      open fails
   file on ext2   r/w gives EINVAL
   /dev/hdaN      works

2.4.19:
   /dev/ram0      r/w gives EINVAL
   file on ext2   r/w gives EINVAL
   /dev/hdaN      r/w gives EINVAL

WTF? It's not a library issue - strace shows the syscalls happening
with the right flag set on the open.

Can someone put me out of my misery? Where the heck is this implemented
in the 2.5.31 ide code? If there? There's no mention of direct_IO.
Clues?

What I ultimately want is to know what code I have to put into a block
device driver in order to support O_DIRECT on the device. 

Peter
