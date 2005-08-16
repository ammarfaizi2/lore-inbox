Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVHPUg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVHPUg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHPUg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:36:28 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:57462 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbVHPUg1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:36:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jjwt58tZY0gEF2JIxylFsMh+p4SJxbNp82H5N62Qj45etQGTKKb6u/CJmyC1IXcsFBgRyc5MIFwPcvRpAxYcOT+dyXJ00tLe2kMFCTnqzCAuCCT2SqTJJtG11+tlus31lZSTu4tN7wh58+RyhLMRdbSl5Rz979pB4o3YAnCev9k=
Message-ID: <3faf056805081613365f5237de@mail.gmail.com>
Date: Wed, 17 Aug 2005 02:06:26 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
To: linux-ia64@vger.kernel.org
Subject: Multiple virtual address mapping for the same code on IA-64 linux kernel.
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Sorry to interrupt you.

I have been investigating a problem in which there has been a dramatic
 core size (complete program size) of a program running on a IA-64
machine running kernel version 2.4.21-4.0.1 (A redhat advanced server
distribution) compared to other 64-bit architectures like amd64 and
EM64T. There has been an increase of around 20% of the size.

I verified the virtual address mappings in /proc/<>/maps file and
found that several .so files (other segments of same size) are getting
mapped multiple times as follows.
<------------------------------------------------------------------------------------------------>
200000000005c000-200000000007c000 r-xp 0000000000000000 08:07 6521003 
  /usr/X11R6/lib/libXext.so.6.4
200000000007c000-2000000000090000 rw-p 0000000000010000 08:07 6521003 
  /usr/X11R6/lib/libXext.so.6.4
2000000000090000-2000000000268000 r-xp 0000000000000000 08:07 6520995 
  /usr/X11R6/lib/libX11.so.6.2
2000000000268000-2000000000270000 ---p 00000000001d8000 08:07 6520995 
  /usr/X11R6/lib/libX11.so.6.2
2000000000270000-2000000000284000 rw-p 00000000001d0000 08:07 6520995 
  /usr/X11R6/lib/libX11.so.6.2
2000000000284000-200000000028c000 r-xp 0000000000000000 08:07 6094863 
  /lib/libdl-2.2.4.so
200000000028c000-2000000000294000 ---p 0000000000008000 08:07 6094863 
  /lib/libdl-2.2.4.so
2000000000294000-200000000029c000 rw-p 0000000000000000 08:07 6094863 
  /lib/libdl-2.2.4.so
200000000029c000-20000000002b8000 r-xp 0000000000000000 08:07 6094883 
  /lib/libpthread-0.9.so
20000000002b8000-20000000002bc000 ---p 000000000001c000 08:07 6094883 
  /lib/libpthread-0.9.so
20000000002bc000-20000000002d4000 rw-p 0000000000010000 08:07 6094883 
  /lib/libpthread-0.9.so
20000000002d4000-2000000000358000 r-xp 0000000000000000 08:07 376886  
  /usr/lib/libncurses.so.5.2
2000000000358000-2000000000364000 ---p 0000000000084000 08:07 376886  
  /usr/lib/libncurses.so.5.2
2000000000364000-2000000000374000 rw-p 0000000000080000 08:07 376886  
  /usr/lib/libncurses.so.5.2
2000000000374000-2000000000378000 rw-p 0000000000000000 00:00 0
2000000000378000-2000000000400000 r-xp 0000000000000000 08:07 6094865 
  /lib/libm-2.2.4.so
2000000000400000-2000000000408000 ---p 0000000000088000 08:07 6094865 
  /lib/libm-2.2.4.so
2000000000408000-2000000000414000 rw-p 0000000000080000 08:07 6094865 
  /lib/libm-2.2.4.so
2000000000414000-200000000065c000 r-xp 0000000000000000 08:07 6094859 
  /lib/libc-2.2.4.so
200000000065c000-2000000000664000 ---p 0000000000248000 08:07 6094859 
  /lib/libc-2.2.4.so
2000000000664000-2000000000678000 rw-p 0000000000240000 08:07 6094859 
  /lib/libc-2.2.4.so
<------------------------------------------------------------------------------------------->

example /lib/libc-2.2.4.so size 6094859    got mapped 3 times with
permissions 'r-xp' , '---p' and 'rw-p' from the bottom.

I found the similar mappings for all the programs running on a IA-64
machine. Is this some special kernel kind of feature on IA-64 ??

Your kind inputs on this problem are greatly appreciated.

Looking forward to hear from you.

Thanks in advance,
Vamsi kundeti
