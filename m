Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271396AbTHHOjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271399AbTHHOjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:39:55 -0400
Received: from hulotte.CC.UMontreal.CA ([132.204.2.135]:11149 "EHLO
	hulotte.cc.umontreal.ca") by vger.kernel.org with ESMTP
	id S271396AbTHHOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:39:52 -0400
Date: Fri, 8 Aug 2003 10:39:45 -0400
From: Xiaogang Wang <xiaogang.wang@umontreal.ca>
X-X-Sender: wangx@esirch2.ESI.UMontreal.CA
To: linux-kernel@vger.kernel.org
Subject: page_alloc.c bug and heavy I/O
Message-ID: <Pine.SGI.4.44.0308081020540.107825-100000@esirch2.ESI.UMontreal.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My hardware and softare:

  Asus P4P800, 2GB memory, 2.8GHZ P4 with HT enabled.
  On-board 3com Giga bit network card
  1 parallel ata 160G maxtor disk
  Nvidia Gefore4 MX440-8x graphics card (Asus V9180)

  Redhat 7.3, original kernel 2.4.18-3
  Intel Fortran Compiler 7.1
  Intel Math Kernel Library 6.0

My problem is that one of my fortran code always crashes after 10-24 hours.
This code has a heavy IO. It writes out a 5MB binary file every 1 minute.

The error message in  /var/log/message is: (coulson is the name of the computer)

Aug  7 21:11:29 coulson kernel: kernel BUG at page_alloc.c:226!
Aug  7 21:11:29 coulson kernel: invalid operand: 0000
Aug  7 21:11:29 coulson kernel: nfsd lockd sunrpc binfmt_misc sr_mod soundcore
parport_pc lp parport autofs 3c
....

the line number with page_alloc.c varies for different crases (not always 226).

This code also had a heavy IO. Specifically, it writes out a 5MB file every
1 minute.

I have done a couple of tests to try to find the cause, but without success so
far.

1) I have rmmod the 3com2000.0 network driver. The driver source is downloaded
from asus website, and compiled by me. The crash still occurs.

2) I heard of Nvidia binary driver can cause page_alloc.c kernel bug.
I do have a Nvidia Gefore4 MX440-8x graphics card (Asus V9180), but I did
not use Nvidia binary driver. Instead I used the vesa driver coming with redhat
7.3.  Nevertheless, I changed to an old pci ATI rage graphics card. But the
crash still occurs.

3) when the crash occurs, my local X is up and running. I have not tried
the case with local X shutdown.

I also got the same crash when I run the code on a second computer with the
same hw and sw. This makes the hw defect less likely to be the cause.

I am thinking to recompile a new kernel. But now I focus on if it is caused
by some uncompatible module drivers.

I would appreciate your inputs on this. Please cc your answer to me. I am not on
the list.

Xiaogang



------------------------------------------------
Dr Xiaogang Wang
Departement de chimie
Universite de Montreal
C.P. 6128, succursale Centre-ville
Montreal (Quebec) H3C 3J7

Tel. (514) 3436111 ext 3947 (office)
FAX  (514) 3437586 (office)
e-mail: xiaogang.wang@umontreal.ca
homepage: http://www.esi.umontreal.ca/~wangx
------------------------------------------------


