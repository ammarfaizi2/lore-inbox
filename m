Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTDWN17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTDWN17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:27:59 -0400
Received: from mail.gmx.de ([213.165.65.60]:61029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264029AbTDWN15 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:27:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Stored data missed in setup.S
Date: Wed, 23 Apr 2003 16:39:57 +0300
User-Agent: KMail/1.4.3
References: <200304231617.23243.icedank@gmx.net> <Pine.LNX.4.53.0304230925150.23037@chaos>
In-Reply-To: <Pine.LNX.4.53.0304230925150.23037@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231639.57148.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > I feel myself stupid, when fighting against setup.S. Here is small piece
> > of code (/arch/i386/boot/setup.S)
> >
> > --->
> > start_of_setup: # line 160
> > 	# bla bla bla - some checking code
> >         movb    $1, %al
> >         movb    %al, (0x100)
> > ....
> > ....
> >         pushw   %ax
> >         movb    (0x100), %al
>
> You put something from offset 0x100 into %al.
>
> >         cmpb    $1, %al
>
> Then you compared it against 1. This is where the comparaison
> occurred.
>
> >         popw    %ax # pop don't change any flags - 386 asm reference
>
> Then you put something else into %ax. Whatever it is, doesn't count.
>
> >         je     bail820 # and it don't jump -- al != 1
>
> Then you jumped based upon the comparison you made before you
> destroyed the contents of %al by poping %eax (%eax is (%ah << 8) | %al).
>
> If you don't want to muck with registers, just do:
>
> 		cmpb	$1, (0x100)
> 		jz	wherever
>
> You don't need to put memory oprands into registers to compare.
>
> > meme820: # line 300
> > <---

OK. And now code looks like:
-->
start_of_setup: # line 160
	# bla bla bla - some checking code
        movb    $1, %al
        movb    %al, (0x100)
....
....
	cmpb    $1, (0x100)
	je bail820 # and it DON'T jump here
<--

I'm sure, I'm doing something wrong. But what???

Best regards,
Andrew.

