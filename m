Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285396AbRLNP10>; Fri, 14 Dec 2001 10:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285394AbRLNP1R>; Fri, 14 Dec 2001 10:27:17 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S285393AbRLNP1A>;
	Fri, 14 Dec 2001 10:27:00 -0500
Message-ID: <0ddd01c184b3$ce15c470$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <066801c183f2$53f90ec0$5601010a@prefect>  <20011213160007.D998D23CCB@persephone.dmz.logatique.fr>  <25867.1008323156@redhat.com>
Subject: Re: Mounting a in-ROM filesystem efficiently 
Date: Fri, 14 Dec 2001 10:27:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "David Woodhouse" <dwmw2@infradead.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>; <linux-kernel@vger.kernel.org>
Sent: Friday, December 14, 2001 4:45 AM
Subject: Re: Mounting a in-ROM filesystem efficiently


> brad@ltc.com said:
> >  have maintained, on and off, a patch to crafms that supports
> > traditional cramfs decompress-and-read/run-from-RAM, plus direct
> > mmaping with no decompression and read/run straight out of ROM:
>
> > http://www.ltc.com/~brad/mips/cramfs-linear-root-xip-linux-2.4.9-2.diff
>
> + if (remap_page_range(vma->vm_start, KSEG0ADDR(address), length,
> +      vma->vm_page_prot))
>
>
> Cute, but not very generic.

Yes, sorry, I should have mentioned that MIPSism in there.  I haven't tried,
but I imagine it wouldn't be that hard to adjust for other platforms.

(In case anyone isn't familiar with KSEG0ADDR on MIPS, it takes a physical
address as it's only paramter and returns a cacheable virtual address in
"kernel address segment 0" (0x80000000 - 0xafffffff) which is hardwire 1:1
mapped with physical address space).

> The approach I was contemplating was to
> allocate a set of 'struct page's for the pages containing XIP data, then
> add those pages to the page cache manually on read_inode().
>
> It's a shame that ->readpage() doesn't get to say 'actually I used my own
> page for that, I didn't want one allocated for me'.

That sounds nice, but I cannot imagine how much trouble it would be to
implement.

> Extending the MTD API to return a set of pages representing a particular
> device, and handling the locking so that we don't try to write to the
chips
> while pages are mapped, will also be necessary if we want to do it with
> flash chips that are used for anything else.

Actually, I've used that patch on a system that had a cramfs/xip and a jffs
partition on the same flash chip where the kernel was running xip out of
flash.  :-)

Regards,
Brad

