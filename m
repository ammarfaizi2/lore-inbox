Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136604AbREAJxi>; Tue, 1 May 2001 05:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136603AbREAJx2>; Tue, 1 May 2001 05:53:28 -0400
Received: from riker.dsl.inconnect.com ([209.140.76.229]:13396 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S136604AbREAJxJ>;
	Tue, 1 May 2001 05:53:09 -0400
Message-ID: <3AEE8747.2258EF0@Rikers.org>
Date: Tue, 01 May 2001 03:52:07 -0600
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-tr1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <3AEE4A06.3666F4BE@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa,

I'd remove the __BIG_ENDIAN test cases if I were you. Having written
many a iso9660 decoder I will tell you that the "required" bi-endian
implementation is sometimes broken as many vendors only test CDs with a
certain single endian OS. I've seen these set to 0s, or -1 or just a
copy of the le data byte for byte. I opened many a bug report with the
different CD formatting software vendors, some fixed them, many didn't
care. The extra savings does not justify the hassles IMHO.

The other changes look great!

Tim

"H. Peter Anvin" wrote:
> 
> Hi guys,
> 
> I was looking over the iso9660 code, and noticed that it was doing
> endianness conversion via ad hoc *functions*, not even inlines; nor did
> it take any advantage of the fact that iso9660 is bi-endian (has "all"
> data in both bigendian and littleendian format.)
> 
> The attached patch fixes both.  It is against 2.4.4, but from the looks
> of it it should patch against -ac as well.
> 
>         -hpa
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
