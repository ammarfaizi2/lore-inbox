Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276260AbRI1ThT>; Fri, 28 Sep 2001 15:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276258AbRI1Tg7>; Fri, 28 Sep 2001 15:36:59 -0400
Received: from elin.scali.no ([62.70.89.10]:4626 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S276257AbRI1Tg4>;
	Fri, 28 Sep 2001 15:36:56 -0400
Message-ID: <3BB4D072.4D3EE56B@scali.no>
Date: Fri, 28 Sep 2001 21:33:06 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: mm: critical shortage of bounce buffers
In-Reply-To: <E15n2Rf-0007xv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I've recently encountered the following message on a machine running RedHat's
> > 2.4.3-12 kernel :
> >
> > "mm: critical shortage of bounce buffers"
> >
> > I've searched through the kernel sources, but my 'find' just can't locate this
> > string anywhere.
> 
> Its in the high mem handling routines. It means the machine stalled for
> a moment doing I/O because it had no memory below 1Gb to use.

But why does it need to have memory below 1Gb ?? Normally, 32bit PCI DMA
controllers (such as network cards and disk controllers) can access up to 4GB of
physical memory within the machine, so unless you are using the CONFIG_HIGHMEM4G
option it shouldn't need bounce buffers. Or am I missing something here
(something like the second physical GB is actually in the address range
4GB->)???

> 
> > Why does this message appear (apparently during high network load with the intel
> > eepro100 driver or e1000 driver). Is bounce buffers really in use on a x86
> > machine with 2GB of RAM (normal smp RedHat kernel, not enterprise)??
> 
> The answer is yes. You can actually build yourself a custom none bounce
> buffer 1.8GB kernel with about 2Gb of user virtual space per app. For some
> applications it will perform better.

There's no CONFIG option for that right (like the old CONFIG_2GB option on 2.2
kernels) ? I'll have to manually go in and edit the header files in asm-i386.
Would the 2.2 (e.g 2.2.19) kernel have the same problems with bounce buffers or
is this not implemented on 2.2 ??

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
