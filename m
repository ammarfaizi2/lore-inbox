Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbTFLW7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbTFLW7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:59:24 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:53121 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S265038AbTFLW7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:59:18 -0400
Message-Id: <200306122312.h5CNCwhk002147@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       robn@verdi.et.tudelft.nl, linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD .. 
In-Reply-To: Your message of "Thu, 12 Jun 2003 15:17:04 +0200."
             <20030612151704.A2588@pclin040.win.tue.nl> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 13 Jun 2003 01:12:57 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries Brouwer wrote:
>        O_DIRECT
>               Try to minimize cache effects of  the  I/O  to  and
>               from  this file.  In general this will degrade per-
>               formance, but it is useful in  special  situations,
>               such  as  when  applications  do their own caching.
>               File  I/O  is  done  directly  to/from  user  space
>               buffers.  The I/O is synchronous, i.e., at the com-
>               pletion of the read(2)  or  write(2)  system  call,
>               data   is  guaranteed  to  have  been  transferred.
>               Transfer sizes, and the alignment  of  user  buffer
>               and  file offset must all be multiples of the logi-
>               cal block size of the file system.

FYI:
It appears that somewhere between RH kernels 2.4.18-27.7.x and 2.4.20-18.9
something has changed so that my application needs a O_SYNC too besides
the O_DIRECT to make sure that writes will be synchronous.  If I leave
the O_SYNC out with 2.4.20-18.9 the write will happen physically 35
seconds after the write() was done.

Haven't tested with a vanilla 2.4.* kernel yet but will try.
(All modern 2.4.2? kernels I tried will hang for > 30s during boot while
probing the CompactFlash and are because of that kind of useless: my
application needs a 5s boot-time ..)

	greetings,
	Rob van Nieuwkerk
