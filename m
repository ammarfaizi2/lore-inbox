Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbUDFMlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbUDFMlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:41:15 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:5035 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263753AbUDFMlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:41:12 -0400
Date: Tue, 06 Apr 2004 21:41:25 +0900 (JST)
Message-Id: <20040406.214123.129013798.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [patch 0/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I also updated memory hotplug patches for hugetlbpages.
The patches are against linux 2.6.5 and work with 
memory hotplug patches which Iwamoto just posted.

Main changes from previous version are:

	* Now remap code is shared between hugetlbpage handling
	  and normal page handling. New remap_operations table is
	  introduced for this purpose and it can handle any kind
	  of pages which have diffirent feature from normal one.
	  This made the remap code simple.

	* Made pagefault routine for hugetlbpage stable.
	  Two or more threads can happen to make pagefault
	  at the same hugetlbpage, at the same time.


/proc/memhotplug interface also provide infomation about Hugetlbpages.

  ex.)
   $ cat /proc/memhotplug 
   Node 0 enabled nonhotremovable
           DMA[0]: free 964, active 34, present 4096 / HugePage free 0, total 0

           Normal[1]: free 9641, active 36633, present 126976 / HugePage free 0, total 0

   Node 1 enabled hotremovable
           Normal[5]: free 208, active 86115, present 94208 / HugePage free 0, total 0

           HighMem[6]: free 0, active 17234, present 34816 / HugePage free 8, total 16

   Node 2 enabled hotremovable
           HighMem[10]: free 272, active 109643, present 128000 / HugePage free 0, total 0


How to apply:

 # cd linux-2.6.5

   First of all, apply Iwamoto's patches here.

 # patch -p1 < va00-hugepagealloc.patch
 # patch -p1 < va01-hugepagefault.patch
 # patch -p1 < va02-hugepagelist.patch
 # patch -p1 < va03-hugepagermap.patch
 # patch -p1 < va04-hugeremap.patch
 # patch -p1 < va05-hugepageproc.patch


Thank you,
Hirokazu Takahashi.
