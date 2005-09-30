Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVI3M7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVI3M7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVI3M7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:59:07 -0400
Received: from vaxjo.synopsys.com ([198.182.60.75]:43205 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S1030287AbVI3M7G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:59:06 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: Strange Virtual Memory Mapping...!
Date: Fri, 30 Sep 2005 18:28:58 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE9168302@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: Strange Virtual Memory Mapping...!
Thread-Index: AcXFvriVTjysqfCpSKGG2Nl50MvooA==
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Sep 2005 12:59:02.0629 (UTC) FILETIME=[BB45A950:01C5C5BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have RH3.0 installed in an AMD64 machine. 
 
In this system, when I look at the virtual address space mappings of a
process (say a sleep process), I see quite a few strange memory region
mappings which are neither readable, nor writable/executable and all of
them are Private (i.e. unshared). Check this:
 
      1024    ---p    /lib64/tls/libc-2.3.2.so
      1024    ---p    /lib64/tls/libm-2.3.2.so
      1024    ---p    /lib64/tls/librtkaio-2.3.2.so
      1024    ---p    /lib64/tls/libpthread-0.60.so
 
On the other hand, when I look at the same info in a Rh7.2 system, I
don't see anything like that...
 
Question: How do I make sense of an unreadable/unwritable/unexecutable
privately mapped memory region? What is its usage? It looks like a 100%
wastage of the process's address space. How is the process using it? Any
idea...anybody?
 
You can find the sample "sleep" commands below.
 
Thanks,
Arijit
 
RH3.0 on AMD64:
=============
vgamd126:arijit>sleep 400 &

[1] 19916
vgamd126:arijit>pmap 19916
 Size (KB)    Perm    Associated files (if any)                    
==========    ====    =============================================
        16    r-xp    /bin/sleep
         4    rw-p    /bin/sleep
       132    rwxp    
      1108    r-xp    /lib64/ld-2.3.2.so
         4    rw-p    /lib64/ld-2.3.2.so
         4    rw-p    
       540    r-xp    /lib64/tls/libm-2.3.2.so
      1024    ---p    /lib64/tls/libm-2.3.2.so
         4    rw-p    /lib64/tls/libm-2.3.2.so
         4    rw-p    
        36    r-xp    /lib64/tls/librtkaio-2.3.2.so
      1024    ---p    /lib64/tls/librtkaio-2.3.2.so
         4    rw-p    /lib64/tls/librtkaio-2.3.2.so
        64    rw-p    
      1260    r-xp    /lib64/tls/libc-2.3.2.so
      1024    ---p    /lib64/tls/libc-2.3.2.so
        20    rw-p    /lib64/tls/libc-2.3.2.so
        16    rw-p    
        60    r-xp    /lib64/tls/libpthread-0.60.so
      1024    ---p    /lib64/tls/libpthread-0.60.so
         4    rw-p    /lib64/tls/libpthread-0.60.so
        20    rw-p    
     31396    r--p    /usr/lib/locale/locale-archive
        24    rw-p    
Total Virtual Memory = 38816 KB
vgamd126:arijit>
 
 
RH7.2 in i686
==========
eurika120:arijit>sleep 400 &

[1] 11065
eurika120:arijit>pmap 11065
 Size (KB)    Perm    Associated files (if any)                    
==========    ====    =============================================
        12    r-xp    /bin/sleep
         4    rw-p    /bin/sleep
         8    rwxp    
        88    r-xp    /lib/ld-2.2.4.so
         4    rw-p    /lib/ld-2.2.4.so
         4    r--p    /usr/lib/locale/en_US/LC_IDENTIFICATION
         4    r--p    /usr/lib/locale/en_US/LC_MEASUREMENT
         4    r--p    /usr/lib/locale/en_US/LC_TELEPHONE
         4    r--p    /usr/lib/locale/en_US/LC_ADDRESS
         4    r--p    /usr/lib/locale/en_US/LC_NAME
         4    r--p    /usr/lib/locale/en_US/LC_PAPER
         4    r--p    /usr/lib/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES
         4    r--p    /usr/lib/locale/en_US/LC_MONETARY
        24    r--p    /usr/lib/locale/en_US/LC_COLLATE
         4    r--p    /usr/lib/locale/en_US/LC_TIME
         4    r--p    /usr/lib/locale/en_US/LC_NUMERIC
         4    rw-p    
       136    r-xp    /lib/i686/libm-2.2.4.so
         4    rw-p    /lib/i686/libm-2.2.4.so
        28    r-xp    /lib/librt-2.2.4.so
         4    rw-p    /lib/librt-2.2.4.so
        40    rw-p    
      1224    r-xp    /lib/i686/libc-2.2.4.so
        20    rw-p    /lib/i686/libc-2.2.4.so
        16    rw-p    
        52    r-xp    /lib/i686/libpthread-0.9.so
        32    rw-p    /lib/i686/libpthread-0.9.so
       172    r--p    /usr/lib/locale/en_US/LC_CTYPE
        24    rwxp    
Total Virtual Memory = 1936 KB
eurika120:arijit>
