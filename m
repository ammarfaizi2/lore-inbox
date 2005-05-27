Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVE0Kux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVE0Kux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVE0Kuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:50:52 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:32392 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262435AbVE0KuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:50:19 -0400
Message-ID: <002e01c562b1$463ec760$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>, <linux-kernel@vger.kernel.org>
Cc: <mikpe@csd.uu.se>
References: <007001c56290$25dd4d00$2800000a@pc365dualp2> <200505271235.41353.vda@ilport.com.ua>
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
Date: Fri, 27 May 2005 07:43:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right about AAD16 Denis :)

Sometimes my mind forgets we're not dealing with something having only 4K of
ROM/RAM to play with.  An embedded Linux won't fit on THAT ;->  A few bytes
more here is definately worth it.  No matter anyway, I've managed to rip
several hundred bytes out of the emulator in the .S assembler files and made
it faster in the process.  I've just now started looking at the .c files and
this opportunity kind of jumped out at me and seemed significant since this
BCD stuff is common in C runtimes printf/sprintf for generating displayable
floating point numbers.

AAM/SHL/OR/MOV looks like a big win though compared to multiple trips
through the extended precision divide routines for a BCD pair.

Mikael: The reason I say "quasi/mutant" is because Intel didn't officially
confess to this particular AAD behavior until many years later.  All the
earlier 8086-486 programmer refs describe only the base 10 form (i.e. their
instruction pseudocode in those manuals is in fact wrong).  As Denis
mentions, it was NEC (on the V20/V30) who got one of these wrong by trusting
the printed manual rather than the silicon - never a good thing to do with
Intel ;->   It took Intel until the Pentium to confess to SETALC's existence
which had been around since 8088/86.<g>

 Tony

----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>; <linux-kernel@vger.kernel.org>
Sent: Friday, May 27, 2005 05:35
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?


> On Friday 27 May 2005 10:44, cutaway@bellsouth.net wrote:
> > Brain fade...example should be:
> >
> > 1) Start with AX = 0x0023
> > 2) Execute AAM instruction
> > 3) Now AX = 0x0305 (unpacked BCD)
> > 4) Execute base 16 AAD instruction
> > 5) Now AX = 0x0035 (packed BCD)
>
> Intel syntax:
>
> shl ah,4
> or al,ah
> mov ah,0  (if needed)
>
> No need to use AAD16, it is
> a) doesnt work on some obscure ancient NEC x86 clones IIRC
> b) is microcoded (slow)
> --
> vda
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

