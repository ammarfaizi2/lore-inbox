Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbRF0Q2y>; Wed, 27 Jun 2001 12:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264026AbRF0Q2n>; Wed, 27 Jun 2001 12:28:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13572 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263979AbRF0Q2d>; Wed, 27 Jun 2001 12:28:33 -0400
Subject: Re: 2.2.x series and mm
To: adam@eax.com (Adam)
Date: Wed, 27 Jun 2001 17:27:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106271008010.16671-100000@eax.student.umd.edu> from "Adam" at Jun 27, 2001 10:08:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FI9n-0005Qz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I'm fairly sure it is the file buffers as the apache is already
> 	reniced to 20, it is got max 50 processes and each of processes is
> 	limited to like 1.5mb of size via ulimit.

nice wont help you, it controls scheduling priority. Similar a ulimit just 
ensures that no apache process goes mad and eats lots of memory (good idea
but not helpful here). If your working set (and thats the bit the matters)
really is exceeding memory by a fair bit then

a)	Add more RAM - that is the real optimal approach
b)	Make the processes smaller (eg switch to thttpd from www.acme.com)
c)	Speed up the I/O throughput relative to CPU speed
	- eg the 2.2 IDE UDMA patches

2.2.19+ do make slightly better decisions on the VM front, but at the end of
the day swapping only works usefully when the working set still fits in 
RAM (ie all the stuff you keep needing). 

