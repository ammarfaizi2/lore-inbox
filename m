Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVKMV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKMV0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKMV0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:26:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:25062 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750713AbVKMV0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:26:53 -0500
From: Neil Brown <neilb@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>, "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 14 Nov 2005 08:26:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17271.44949.625740.612801@cse.unsw.edu.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: x86 building altivec for raid ?
In-Reply-To: message from J.A. Magallon on Sunday November 13
References: <20051113220213.55fc6fae@werewolf.auna.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 13, jamagallon@able.es wrote:
> 
> Kernel is 2.6.14-mm2.
> This is an x86 box, why does it compile raid6altivec*.c ? I suppose it
> does not generate any code, because of some #ifdef magic, but why does
> it build them anyways ? Looks a bit strange.

It's probably just easier that way.
I guess you could do the following, but I'm not sure that it is really
worth it.

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

diff ./drivers/md/Makefile~current~ ./drivers/md/Makefile
--- ./drivers/md/Makefile~current~	2005-11-14 08:13:43.000000000 +1100
+++ ./drivers/md/Makefile	2005-11-14 08:23:29.000000000 +1100
@@ -8,12 +8,15 @@ dm-multipath-objs := dm-hw-handler.o dm-
 dm-snapshot-objs := dm-snap.o dm-exception-store.o
 dm-mirror-objs	:= dm-log.o dm-raid1.o
 md-mod-objs     := md.o bitmap.o
+raid6-$(CONFIG_ALTIVEC) :=  \
+		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
+		   raid6altivec8.o
+raid6-$(CONFIG_X86) :=  raid6mmx.o raid6sse1.o
+raid6-$(CONFIG_X86_64) := raid6sse2.o
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
-		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
-		   raid6altivec8.o \
-		   raid6mmx.o raid6sse1.o raid6sse2.o
+		   $(raid6-y)
 hostprogs-y	:= mktables
 
 # Note: link order is important.  All raid personalities

