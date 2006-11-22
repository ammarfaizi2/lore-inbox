Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756678AbWKVTKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbWKVTKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbWKVTKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:10:21 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:58282 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1756678AbWKVTKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:10:20 -0500
Date: Wed, 22 Nov 2006 20:10:08 +0100
From: The Peach <smartart@tiscali.it>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
Message-ID: <20061122201008.17072c89@localhost>
In-Reply-To: <8764d7v4nh.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
	<8764d7v4nh.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 01:15:46 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> Thanks. Probably instead of some overheads, this patch will fix a problem.

here it is, did the very same experiments than before.
Normal file:
# cp -v DSCN5970\(1\).JPG /mnt/loop/
`DSCN5970(1).JPG' -> `/mnt/loop/DSCN5970(1).JPG'

dmesg:
vfat_hashi: parent d1801e94, parent->d_op e0fbc620
vfat_hashi: parent /, name DSCN5970(1).JPG
vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
vfat_revalidate: name DSCN5970(1).JPG, nd d65eaeec, flags 00000001
vfat_lookup: name DSCN5970(1).JPG
vfat_hashi: parent d1801e94, parent->d_op e0fbc620
vfat_hashi: parent /, name DSCN5970(1).JPG
vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
vfat_revalidate: name DSCN5970(1).JPG, nd d65eaf24, flags 00000300
vfat_lookup: name DSCN5970(1).JPG
vfat_create: name DSCN5970(1).JPG
vfat_add_entry: 0: DSCN59~1, JPG
vfat_add_entry: 1: DSCN5, 970(1), .J
vfat_add_entry: 2: PG
vfat_create: err 0

Abnormal file:
# cp -v DSCN5980.JPG /mnt/loop/
`DSCN5980.JPG' -> `/mnt/loop/DSCN5980.JPG'

dmesg:
vfat_hashi: parent d1801e94, parent->d_op e0fbc620
vfat_hashi: parent /, name DSCN5980.JPG
vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
vfat_cmpi: a dscn5980.jpg, b DSCN5980.JPG
vfat_revalidate: name dscn5980.jpg, nd d65eaeec, flags 00000001
vfat_lookup: name DSCN5980.JPG
vfat_hashi: parent d1801e94, parent->d_op e0fbc620
vfat_hashi: parent /, name DSCN5980.JPG
vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
vfat_cmpi: a DSCN5980.JPG, b DSCN5980.JPG
vfat_revalidate: name DSCN5980.JPG, nd d65eaf24, flags 00000300
vfat_lookup: name DSCN5980.JPG
vfat_create: name DSCN5980.JPG
vfat_add_entry: 0: DSCN5980, JPG
vfat_create: err 0

and:
# ls -l /mnt/loop/
totale 1363
-rwxr-xr-x 1 root root 695514 22 nov 20:04 DSCN5970(1).JPG
-rwxr-xr-x 1 root root 699770 22 nov 20:07 dscn5980.jpg

dmesg:
vfat_hashi: parent d1801e94, parent->d_op e0fbc620
vfat_hashi: parent /, name DSCN5970(1).JPG
vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
vfat_revalidate: name DSCN5970(1).JPG, nd d2512eec, flags 00000000
vfat_lookup: name DSCN5970(1).JPG
vfat_hashi: parent d1801e94, parent->d_op e0fbc620
vfat_hashi: parent /, name dscn5980.jpg
vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
vfat_cmpi: a DSCN5980.JPG, b dscn5980.jpg
vfat_revalidate: name DSCN5980.JPG, nd d2512eec, flags 00000000



:(


-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
