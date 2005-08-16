Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbVHPVGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbVHPVGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVHPVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:06:38 -0400
Received: from spirit.analogic.com ([208.224.221.4]:14087 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932463AbVHPVGh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:06:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <3faf056805081613365f5237de@mail.gmail.com>
References: <3faf056805081613365f5237de@mail.gmail.com>
X-OriginalArrivalTime: 16 Aug 2005 21:06:35.0566 (UTC) FILETIME=[62CADCE0:01C5A2A6]
Content-class: urn:content-classes:message
Subject: Re: Multiple virtual address mapping for the same code on IA-64 linux kernel.
Date: Tue, 16 Aug 2005 17:05:59 -0400
Message-ID: <Pine.LNX.4.61.0508161657410.24338@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multiple virtual address mapping for the same code on IA-64 linux kernel.
Thread-Index: AcWipmLSaM5BiYXXSsCFf7uI6zn8oA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Aug 2005, vamsi krishna wrote:

> Hello All,
>
> Sorry to interrupt you.
>
> I have been investigating a problem in which there has been a dramatic
> core size (complete program size) of a program running on a IA-64
> machine running kernel version 2.4.21-4.0.1 (A redhat advanced server
> distribution) compared to other 64-bit architectures like amd64 and
> EM64T. There has been an increase of around 20% of the size.
>

The IA-64 instruction-set is bigger than, for instance, AMD-64.
This could account for some code-size increase. It's also possible
that the 'C' compiler was doing more in-lining as well when the
libraries were built.

> I verified the virtual address mappings in /proc/<>/maps file and
> found that several .so files (other segments of same size) are getting
> mapped multiple times as follows.
> <------------------------------------------------------------------------------------------------>
> 200000000005c000-200000000007c000 r-xp 0000000000000000 08:07 6521003
>  /usr/X11R6/lib/libXext.so.6.4
> 200000000007c000-2000000000090000 rw-p 0000000000010000 08:07 6521003
>  /usr/X11R6/lib/libXext.so.6.4
> 2000000000090000-2000000000268000 r-xp 0000000000000000 08:07 6520995
>  /usr/X11R6/lib/libX11.so.6.2
> 2000000000268000-2000000000270000 ---p 00000000001d8000 08:07 6520995
>  /usr/X11R6/lib/libX11.so.6.2
> 2000000000270000-2000000000284000 rw-p 00000000001d0000 08:07 6520995
>  /usr/X11R6/lib/libX11.so.6.2
> 2000000000284000-200000000028c000 r-xp 0000000000000000 08:07 6094863
>  /lib/libdl-2.2.4.so
> 200000000028c000-2000000000294000 ---p 0000000000008000 08:07 6094863
>  /lib/libdl-2.2.4.so
> 2000000000294000-200000000029c000 rw-p 0000000000000000 08:07 6094863
>  /lib/libdl-2.2.4.so
> 200000000029c000-20000000002b8000 r-xp 0000000000000000 08:07 6094883
>  /lib/libpthread-0.9.so
> 20000000002b8000-20000000002bc000 ---p 000000000001c000 08:07 6094883
>  /lib/libpthread-0.9.so
> 20000000002bc000-20000000002d4000 rw-p 0000000000010000 08:07 6094883
>  /lib/libpthread-0.9.so
> 20000000002d4000-2000000000358000 r-xp 0000000000000000 08:07 376886
>  /usr/lib/libncurses.so.5.2
> 2000000000358000-2000000000364000 ---p 0000000000084000 08:07 376886
>  /usr/lib/libncurses.so.5.2
> 2000000000364000-2000000000374000 rw-p 0000000000080000 08:07 376886
>  /usr/lib/libncurses.so.5.2
> 2000000000374000-2000000000378000 rw-p 0000000000000000 00:00 0
> 2000000000378000-2000000000400000 r-xp 0000000000000000 08:07 6094865
>  /lib/libm-2.2.4.so
> 2000000000400000-2000000000408000 ---p 0000000000088000 08:07 6094865
>  /lib/libm-2.2.4.so
> 2000000000408000-2000000000414000 rw-p 0000000000080000 08:07 6094865
>  /lib/libm-2.2.4.so
> 2000000000414000-200000000065c000 r-xp 0000000000000000 08:07 6094859
>  /lib/libc-2.2.4.so
> 200000000065c000-2000000000664000 ---p 0000000000248000 08:07 6094859
>  /lib/libc-2.2.4.so
> 2000000000664000-2000000000678000 rw-p 0000000000240000 08:07 6094859
>  /lib/libc-2.2.4.so
> <------------------------------------------------------------------------------------------->
>
> example /lib/libc-2.2.4.so size 6094859    got mapped 3 times with
> permissions 'r-xp' , '---p' and 'rw-p' from the bottom.
>

Looks okay. Several different offsets are mapped with different
permissions.

> I found the similar mappings for all the programs running on a IA-64
> machine. Is this some special kernel kind of feature on IA-64 ??
>

Same features on ix86....

08048000-08050000 r-xp 00000000 03:01 1392661    /sbin/init
08050000-08051000 rw-p 00008000 03:01 1392661    /sbin/init
08051000-08072000 rw-p 08051000 00:00 0          [heap]
4a956000-4a96b000 r-xp 00000000 03:01 9371722    /lib/ld-2.3.3.so
4a96b000-4a96c000 r--p 00014000 03:01 9371722    /lib/ld-2.3.3.so
4a96c000-4a96d000 rw-p 00015000 03:01 9371722    /lib/ld-2.3.3.so
4a973000-4aa88000 r-xp 00000000 03:01 9371733    /lib/tls/libc-2.3.3.so
4aa88000-4aa8a000 r--p 00115000 03:01 9371733    /lib/tls/libc-2.3.3.so
4aa8a000-4aa8c000 rw-p 00117000 03:01 9371733    /lib/tls/libc-2.3.3.so
4aa8c000-4aa8e000 rw-p 4aa8c000 00:00 0
4bbfd000-4bc0b000 r-xp 00000000 03:01 9371763    /lib/libselinux.so.1
4bc0b000-4bc0d000 rw-p 0000d000 03:01 9371763    /lib/libselinux.so.1
b7f03000-b7f04000 rw-p b7f03000 00:00 0
bfa0d000-bfa23000 rw-p bfa0d000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

.... just doesn't look so enormous!


> Your kind inputs on this problem are greatly appreciated.
>
> Looking forward to hear from you.
>
> Thanks in advance,
> Vamsi kundeti
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
