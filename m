Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQL0Xcg>; Wed, 27 Dec 2000 18:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQL0Xc0>; Wed, 27 Dec 2000 18:32:26 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:62396 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129477AbQL0XcL>;
	Wed, 27 Dec 2000 18:32:11 -0500
Date: Wed, 27 Dec 2000 23:52:09 +0100 (CET)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: old binary works not with 2.2.18 (fwd)
Message-ID: <Pine.LNX.4.21.0012272349070.26290-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old 4GL application (from SCO3.2v4) that is a neat database
tool. Under 2.2.17 with iBCS this works well:

schoen3:~ #  file /usr/SCULPTOR/bin/sage
/usr/SCULPTOR/bin/sage: Microsoft a.out separate pure segmented
word-swapped V2.3 V3.0 386 small model executable  

I did some checking with tracing on with iBCS:

The "same" ibcs source tree on 2.2.17 gives with this application:

Dec 27 23:22:46 renske1 kernel: iBCS: socksys registered on character major 30
Dec 27 23:22:48 renske1 kernel: iBCS: trace code set to 0x100
Dec 27 23:22:58 renske1 kernel: XOUT: binfmt_xout entry: /usr/SCULPTOR/bin/sage
Dec 27 23:22:58 renske1 kernel: XOUT: 0001 8048 003f 00 00000400 00013e38 00013e38 00000000
Dec 27 23:22:58 renske1 kernel: XOUT: 0002 8044 0047 00 00014400 00001c50 00005070 01880000
Dec 27 23:22:58 renske1 kernel: XOUT: flushing executable
Dec 27 23:22:58 renske1 kernel: XOUT: entry point = 0x3f:0x00000000
Dec 27 23:22:58 renske1 kernel: XOUT: mmap to 0x00000000 from 0x00000400, length 0x00013e38
Dec 27 23:22:58 renske1 kernel: XOUT: mmap to 0x01880000 from 0x00014400, length 0x00001c50
Dec 27 23:22:58 renske1 kernel: XOUT: un-initialized storage 0x01881c50, length 0x000003b0
Dec 27 23:22:58 renske1 kernel: XOUT: Null map 0x01882000, length 0x00003070
Dec 27 23:22:58 renske1 kernel: XOUT: start code 0x00000000, end code 0x00013e38, end data 0x01881c50, brk 0x01886000
Dec 27 23:22:58 renske1 kernel: XOUT: binfmt_xout: result = 0

With 2.2.18 (and 2.2.19p3) I get:

Dec 27 23:27:32 schoen3 kernel: iBCS: trace code set to 0x100
Dec 27 23:27:41 schoen3 kernel: XOUT: binfmt_xout entry: /usr/SCULPTOR/bin/sage
Dec 27 23:27:41 schoen3 kernel: XOUT: 0001 8048 003f 00 00000400 00013e38 00013e38 00000000
Dec 27 23:27:41 schoen3 kernel: XOUT: 0002 8044 0047 00 00014400 00001c50 00005070 01880000
Dec 27 23:27:41 schoen3 kernel: XOUT: flushing executable
Dec 27 23:27:41 schoen3 kernel: XOUT: entry point = 0x3f:0x00000000
Dec 27 23:27:41 schoen3 kernel: XOUT: mmap to 0x00000000 from 0x00000400, length 0x00013e38
Dec 27 23:27:41 schoen3 kernel: XOUT: start code 0x00000000, end code 0x00013e38, end data 0x00015a88, brk 0x00018ea8
Dec 27 23:27:41 schoen3 kernel: XOUT: loader forces seg fault (status=-22)
Dec 27 23:27:41 schoen3 kernel: XOUT: binfmt_xout: result = 0
Dec 27 23:27:49 schoen3 kernel: XOUT: binfmt_xout entry: /usr/bin/less

Note how the m-mapping for the data segment fails with 2.2.18

Kees
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
