Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSFXRYj>; Mon, 24 Jun 2002 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSFXRYi>; Mon, 24 Jun 2002 13:24:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41076 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314446AbSFXRYi>; Mon, 24 Jun 2002 13:24:38 -0400
To: "Gross, Mark" <mark.gross@intel.com>
Cc: "'Christopher E. Brown'" <cbrown@woods.net>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] RE: ext3 performance bottleneck as the number of s pindles gets large
References: <59885C5E3098D511AD690002A5072D3C057B49C9@orsmsx111.jf.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jun 2002 11:14:08 -0600
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B49C9@orsmsx111.jf.intel.com>
Message-ID: <m1y9d4r44f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gross, Mark" <mark.gross@intel.com> writes:

> We are running the tests with the following mother board.
> http://www.intel.com/design/servers/scb2/index.htm?iid=ipp_browse+motherbd_s
> cb2&
> 
> Its a very nice box with 2 independent 64/66 PCI buses.  
> Capable of 2x503MB/sec, using your logic ;)
> 
> Regardless, the 640MB/s number was computed without considering the PCI bus
> limitations, or the dual port nature of the base 160MB/sec nature of the
> Adabptec SCSI-39160.
> http://www.adaptec.com/worldwide/product/proddetail.html?sess=no&prodkey=ASC
> -39160&cat=Products
> 
> Realistically, we are looking for a max throughput of about 320MB/sec with 4
> adapters with enough drives attached.

Careful even with at 320MB/sec this requires 50% of your systems theoretical
memory bandwidth in DMA transfers.  

Application level benchmarks like streams can only achieve memory copy numbers
on a PIII platform of about 320MB/sec.  A highly tuned mmx, or sse memory
copy can do better but it is a challenge.

That close to the hardware limits finding the actual bottleneck can
get very tricky.  At the very least I would run the system with
just one processor, and attempt to get the numbers that way.  I can
trivially see spinlock hold times staying high simply because
the memory is busy with a DMA transfer, and so cannot be used to
transfer the new contents of the lock.

Eric
