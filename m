Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754709AbWKVPaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbWKVPaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbWKVPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:30:22 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:60289 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1754709AbWKVPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:30:22 -0500
Date: Wed, 22 Nov 2006 16:30:01 +0100
From: The Peach <smartart@tiscali.it>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
Message-ID: <20061122163001.0d291978@localhost>
In-Reply-To: <87mz6kajks.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 00:46:43 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> Can you try the attached debug patch? 

Here is the debug for the copy of a normal file over vfat:

# cp -v DSCN5970\(1\).JPG /mnt/loop/
`DSCN5970(1).JPG' -> `/mnt/loop/DSCN5970(1).JPG'

and the output on dmesg:
vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
vfat_hashi: parent /, name DSCN5970(1).JPG
vfat_lookup: name DSCN5970(1).JPG
vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
vfat_hashi: parent /, name DSCN5970(1).JPG
vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
vfat_revalidate: name DSCN5970(1).JPG, nd c9f1af30, flags 00000300             
vfat_lookup: name DSCN5970(1).JPG
vfat_create: name DSCN5970(1).JPG
vfat_add_entry: 0: DSCN59~1, JPG
vfat_add_entry: 1: DSCN5, 970(1), .J
vfat_add_entry: 2: PG
vfat_create: err 0

and the copy of an "abnormal" file:

# cp -v DSCN5980.JPG /mnt/loop/
`DSCN5980.JPG' -> `/mnt/loop/DSCN5980.JPG'

and its dmesg output:
vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
vfat_hashi: parent /, name DSCN5980.JPG
vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
vfat_cmpi: a dscn5980.jpg, b DSCN5980.JPG
vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
vfat_hashi: parent /, name DSCN5980.JPG
vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
vfat_cmpi: a dscn5980.jpg, b DSCN5980.JPG
vfat_create: name dscn5980.jpg
vfat_add_entry: 0: DSCN5980, JPG
vfat_add_entry: 1: dscn5, 980.jp, g
vfat_create: err 0

then:

# ls -l /mnt/loop/
totale 1363
-rwxr-xr-x 1 root root 695514 22 nov 16:21 DSCN5970(1).JPG
-rwxr-xr-x 1 root root 699770 22 nov 16:25 dscn5980.jpg

and its output:
vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
vfat_hashi: parent /, name DSCN5970(1).JPG                                     
vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
vfat_revalidate: name DSCN5970(1).JPG, nd c9f18ef8, flags 00000000
vfat_lookup: name DSCN5970(1).JPG
vfat_hashi: parent d528a514, parent->d_op e0fbf5c0
vfat_hashi: parent /, name dscn5980.jpg
vfat_cmpi: parent d528a514, parent->d_op e0fbf5c0
vfat_cmpi: a dscn5980.jpg, b dscn5980.jpg


> And if you comment-in the
> following parts, does this problem fix?

I will repatch asap and post the result.

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
