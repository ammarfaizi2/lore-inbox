Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRI2Hbw>; Sat, 29 Sep 2001 03:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276450AbRI2Hbn>; Sat, 29 Sep 2001 03:31:43 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:27559 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276453AbRI2Hbb>;
	Sat, 29 Sep 2001 03:31:31 -0400
Message-ID: <3BB57915.7A702482@gmx.de>
Date: Sat, 29 Sep 2001 09:32:37 +0200
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: BHA Industries
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <356.1001580994@www46.gmx.net> <m1adzg66mq.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> Ouch.  This is where I give you the standard recommendation.  If you
> do this scatter gatter (so you don't need megs of continuous memory)
> you should be much better off, and your driver should be more
> reliable.

Yep, the firmware on the pixel DSP behind the PLX-9054 bridge wants
the base address of a linear 2K * 1K * 2 picture buffer so that it can
trigger the one of the 9054's DMA engines to transfer triangles line 
by line into my memory buffer. If I mmap the PCI space to userland, each read
cycle costs 700-900 ns. The DMA engine can use bursts and then a cycle costs
only 29.9 ns of PCI bandwidth.

>  All of the other techniques you have used like mmap should
> still apply.

> Also if you are exporting this data to user space, before your DMA
> complets you want to zero the pages you have allocated, so you don't
> have an information leak.

The DMA engine in the PLX 9054 can at least do Write-and-Invalidate cycles to
the Main RAM. :-)

Ciao,
-- 
Bernd Harries

bha@gmx.de           http://www.freeyellow.com/members/bharries
bha@nikocity.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org      8.48'21" E  52.48'52" N  | Medusa T40
