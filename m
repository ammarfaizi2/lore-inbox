Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136692AbREASRw>; Tue, 1 May 2001 14:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136689AbREASRn>; Tue, 1 May 2001 14:17:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11277 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136687AbREASR0>; Tue, 1 May 2001 14:17:26 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AEEFD7F.3E7C6B3@transmeta.com>
Date: Tue, 01 May 2001 11:16:31 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        Andries.Brouwer@cwi.nl
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <200105011440.QAA12760@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> Are you sure that the arguments of the following casting
> 
> > +     return le16_to_cpu(*(u16 *)p);
> 
> > +     return be16_to_cpu(*(u16 *)p);
> 
> > +     return le32_to_cpu(*(u32 *)p);
> 
> > +     return be32_to_cpu(*(u32 *)p);
> 
> are properly aligned ?
> I did not revise the code to check it, but AFAIK improperly aligned
> char* pointers cause problem with casting to pointers to 16/32-bit data
> on some architectures (I heard of sucj a problem with alpha).
> 
> Maybe there was a reason that the original code did operate on bytes here...
> 

Oh bother, you're right of course.  We need some kind of standardized
macro for indirecting through a potentially unaligned pointer.  It can
just do the dereference (e.g. x86), use left/right accesses (e.g. MIPS),
or do it by byte (others).

Ports people, what do you think?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
