Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSHIR6N>; Fri, 9 Aug 2002 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHIR6M>; Fri, 9 Aug 2002 13:58:12 -0400
Received: from B52d0.pppool.de ([213.7.82.208]:37014 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S315260AbSHIR6L>; Fri, 9 Aug 2002 13:58:11 -0400
Subject: mmapping large files hits swap in 2.4?
From: Daniel Egger <degger@fhm.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 09 Aug 2002 19:26:14 +0200
Message-Id: <1028913975.3832.14.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hija,

I'm currently looking into optimizing GIMPs own swapping algorithm
by replacing naive file operations by mmap-based ones. Unfortunately
my test machine (PPC, 256MB) gets hit really hard by mmapping files over
100MB into memory: The swap utilization grows up to the file size
and the machine is completely unresponsive for several seconds up to
a few minutes. Seemingly the writes to the mmaped area first hit the
swap and then are read from there again to fit the designated file.

I'm doing something along the lines of:
area = mmap (0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

I also tried MAP_PRIVATE and MAP_LOCKED both with a private and a
shared mapping, but to no avail.

This is kernel version 2.4.19-rc3 (in the benh-variant).

Is there anything I can do to improve the situation or is it just 
the kernel or the architecture?

-- 
Servus,
       Daniel

