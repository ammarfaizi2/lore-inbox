Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSH1JNI>; Wed, 28 Aug 2002 05:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSH1JNI>; Wed, 28 Aug 2002 05:13:08 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:43741 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318766AbSH1JNH>; Wed, 28 Aug 2002 05:13:07 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 28 Aug 2002 02:17:21 -0700
Message-Id: <200208280917.CAA39688@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002 10:36:29 +0200, Urban Widmark wrote:
>smbfs has aops but when used with the current loop.c it corrupts the file
>it is using. I can't say that the error is in loop.c but it is the only
>way I can trigger the corruption and the smbfs aops (locking) aren't all
>that different from the nfs ones.

        I think you're just exercising a bug in the stock
loop.c that I fixed in a recent patch for 2.5.31 loop.c.
It occurred when the of the file system block size was less than
than a page size, which I believe is what mke2fs will default to
for a ~20MB file system, as in your example.  The fix is item #3
discussed in my posting of an earlier version of the loop.c patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102924362322080&w=2

        although I posted a newer version of the loop.c patch
(which also has the fix but does not discuss it in the message text)
here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102941520919910&w=2

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
