Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbTCMMSL>; Thu, 13 Mar 2003 07:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262271AbTCMMSL>; Thu, 13 Mar 2003 07:18:11 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:49300 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S262264AbTCMMSJ>; Thu, 13 Mar 2003 07:18:09 -0500
Message-ID: <04d701c2e95c$18ac6710$0a000043@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: 2.5.64-mm6
Date: Thu, 13 Mar 2003 13:28:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   This means that when an executable is first mapped in, the kernel will
>   slurp the whole thing off disk in one hit.  Some IO changes were made to
>   speed this up.
>
>   This means that large cache-cold executables start significantly faster.
>   Launching X11+KDE+mozilla goes from 23 seconds to 16.  Starting
OpenOffice
>   seems to be 2x to 3x faster, and starting Konqueror maybe 3x faster too.
>   Interesting.

Sounds nice indeed.

Do you think we could try to use 4Mo pages instead of 4Ko to map some
libraries/executables ?

libc.so could be linked to align text to a 4Mo boundary, and to set a an ELF
marker to tell the kernel/loader to try to use
HugeTLB page to map the text portion. The space wasted (the current glibc
use about 2Mo instead of 4Mo) is neglictable if the same page is used for
all processes in the machine...

HPUX11 has a chattr command that can mark binaries to use BigPages (for text
pages or data pages). We could 'mark' big programs with an ELF attribute to
ask for the behavior you describe (force the load of all the mapped portion
at mmap time) or/and to try to use HugeTLBPages...

Eric

