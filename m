Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285313AbRLNJqW>; Fri, 14 Dec 2001 04:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285315AbRLNJqN>; Fri, 14 Dec 2001 04:46:13 -0500
Received: from t2.redhat.com ([199.183.24.243]:17145 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285313AbRLNJqG>; Fri, 14 Dec 2001 04:46:06 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <066801c183f2$53f90ec0$5601010a@prefect> 
In-Reply-To: <066801c183f2$53f90ec0$5601010a@prefect>  <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> 
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Dec 2001 09:45:56 +0000
Message-ID: <25867.1008323156@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



brad@ltc.com said:
>  have maintained, on and off, a patch to crafms that supports
> traditional cramfs decompress-and-read/run-from-RAM, plus direct
> mmaping with no decompression and read/run straight out of ROM:

> http://www.ltc.com/~brad/mips/cramfs-linear-root-xip-linux-2.4.9-2.diff 

+	if (remap_page_range(vma->vm_start, KSEG0ADDR(address), length,
+			     vma->vm_page_prot))


Cute, but not very generic. The approach I was contemplating was to 
allocate a set of 'struct page's for the pages containing XIP data, then 
add those pages to the page cache manually on read_inode(). 

It's a shame that ->readpage() doesn't get to say 'actually I used my own 
page for that, I didn't want one allocated for me'.

Extending the MTD API to return a set of pages representing a particular
device, and handling the locking so that we don't try to write to the chips
while pages are mapped, will also be necessary if we want to do it with
flash chips that are used for anything else.

--
dwmw2


