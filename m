Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284010AbRLROzy>; Tue, 18 Dec 2001 09:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284163AbRLROzl>; Tue, 18 Dec 2001 09:55:41 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:16310 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S284010AbRLROy6>; Tue, 18 Dec 2001 09:54:58 -0500
Message-ID: <3C1F57C6.23DECC61@didntduck.org>
Date: Tue, 18 Dec 2001 09:50:46 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Lubitz <h.lubitz@internet-factory.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: modify_ldt returning ENOMEM on highmem
In-Reply-To: <200112171852.fBHIqJR05703@orp.orf.cx> <3C1F5076.3B6A509E@internet-factory.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Lubitz wrote:
> 
> Leigh Orf proclaimed:
> > Do you have an NTFS disk mounted? I had a similar problem which was
> > "fixed" by not having an NTFS vol mounted. Apparently the ntfs code
> > makes a lot of calls to vmalloc which leads to badness.
> 
> Yes, I have. I'll try not mounting it. Which would be a better
> workaround than disabling 1/8 of my RAM.
> The funny thing is just - why does it work fine with up to 896 MB, but
> gives ENOMEM with _more_ RAM?

Because of the way the kernel uses its 1GB of virtual address space. 
Physical memory is mapped 1:1 up to 960 MB, with the remaining virtual
address space (64MB or more) is reserved for virtual mappings like
vmalloc and ioremap.

-- 

						Brian Gerst
