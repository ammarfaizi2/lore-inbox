Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRBVQZQ>; Thu, 22 Feb 2001 11:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRBVQZH>; Thu, 22 Feb 2001 11:25:07 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:1247 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S130130AbRBVQZB>; Thu, 22 Feb 2001 11:25:01 -0500
Date: Thu, 22 Feb 2001 17:24:58 +0100
From: Christoph Baumann <baumann@kip.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA buffer (in 2.2.15)
Message-ID: <20010222172458.A9717@kip.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I messed up my subscription to this list yesterday so any answer to my question
didn't reach me (I looked through the archive up to 20:50 yesterday).
Now as I read my question again I decided to add some more details.

>But when reading the buffer isn't allocated
This is of course rubbish. I meant the buffer isn't initialized.

Some more details about what I'm doing:
I have a PCI board with 1M of RAM and a PLX9080 on it (and some more chips 
which don't matter here). So far I have established normal communication with
the board (to program the PLX etc.). Now I want to write larger junks of data
to the RAM. So I startet to resolve the physical addresses of the user space
data to generate a chain list. Everything works fine for writing to the RAM.
The problem is reading. If I allocate a new buffer for reading back it isn't
of course not yet mapped to physical memory. The "quick and dirty"(tm) hack
was writing a zero to each buffer element to get it mapped. The better version
is to do this in steps of PAGE_SIZE. What I'm looking for is a kernel routine
to force the mapping of previous unmapped pages. Browsing through the source
in mm/ I found make_pages_present(). Could this be the solution? I hadn't the 
time to try it out yet.


Christoph

-- 
**********************************************************
* Christoph Baumann                                      *
* Kirchhoff-Institut für Physik - Uni Heidelberg         *
* Mail: baumann@kip.uni-heidelberg.de                    *
* Phone: ++49-6221-54-4329                               *
**********************************************************

