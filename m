Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSEICh6>; Wed, 8 May 2002 22:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315596AbSEICh5>; Wed, 8 May 2002 22:37:57 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:49620 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S315595AbSEICh5>; Wed, 8 May 2002 22:37:57 -0400
Message-Id: <5.1.0.14.2.20020509122919.01645ff0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 09 May 2002 12:37:07 +1000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] 2.5.14 IDE 56
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <E175QmK-0001V8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:42 PM 8/05/2002 +0100, Alan Cox wrote:
>The SCSI layer is significant overhead even in 2.5.

i did some benchmarking on a high-end dual P3 Xeon (Serverworks chipset ) 
with QLogic 2300 (2gbit/s) 64/66 Fibre Channel controllers.

using the '/dev/sgX' interface to issue scsi reads/writes allowed me to hit 
the magical limit of 200mbyte/sec throughput.  (basically just about 
linerate).  (simultaneous "sg_read if=/dev/sgX mmap=1 bs=512 count=35M"; 
sg_read from the sg-tools package)

doing the same test thru the block-layer was basically capped at around 
135mbyte/sec.  (simultaneous "dd if=/dev/sdX of=/dev/null bs=512 count=35M").

whether the bottleneck was copy-from-kernel-to-userspace (ie. exhaustion of 
Front-Side-Bus / memory bandwidth) or related to block-layer overhead and 
scsi layer overheads, i haven't yet validated, but at a ~35% performance 
difference is relatively significant nontheless.

cpu utlization on the sg interface was under 10%.  using 'dd' on the sd 
interface, both gigahertz P3 Xeons had 0% idle time.


cheers,

lincoln.

