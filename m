Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTDWSNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264166AbTDWSNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:13:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:37981 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264178AbTDWSNW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:13:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Date: Wed, 23 Apr 2003 21:25:22 +0300
User-Agent: KMail/1.4.3
References: <200304231958.43235.icedank@gmx.net> <200304232105.38722.icedank@gmx.net> <Pine.LNX.4.53.0304231412450.25545@chaos>
In-Reply-To: <Pine.LNX.4.53.0304231412450.25545@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304232125.22270.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > > scan:	movw	%cs, %ax
> > > 	movw	%ax, %ds
> > > 	movw	%ax, %es
> > > 	movw	$where_in_BIOS_to_start, %bx
> > > 	cld
> > > 1:	movw	$cl_id_str, %si		# Offset of search string
> > > 	movw	$cl_id_end, %cx		# Offset of string end + 1
> > > 	subw	%si, %cx		# String length
> > > 	decw	%cx			# Don't look for the \0
> > > 	movw	%bx, %di		# ES:DI = where to look
> > > 	repz	cmpsb			# Loop while the same
> > > 	jz	found			# Found the string
> > > 	incb	%bx			# Next starting offset
> > > 	cmpb	$_BIOS_END, %bx		# Check for limit
> > > 	jb	1b			# Continue
> > > never_found_anywhere:
> > >
> > > found:
> >
> > I've written something similar to this before - and it wont' work, so
> > I've reimplemented it. The problem is, that I don't know how to set ES
> > properly. I only know, that BIOS data (and code) is located in
> > 0xe000..0xf000 (real address).
>
> Yeah. So. I set ES and DS to be exactly where CS is. This means that
> if your &!)(^$&_ code executes it will work. So, instead of trying
> it, you just blindly ignore it and state that it won't work.
>
> Bullshit. I do this for a living and I gave you some valuable time
> which you rejected out-of-hand. Have fun.

Of course, I've tried your code as well - the same result! Sorry, if you 
haven't understand me.

The problem is, that I don't know where this BIOS code is relative to current 
code segment (CS). I only know (hope), that it should be in 
0x0:0xe000...0x0:0xf000. I have tried to set ES to 0 (xor %ax, %ax; mov %ax, 
%es) - no luck as well. BTW, `strings /dev/mem | grep "REQUESTED STRING"` 
founds it perfectly...

Best regards,
Andrew.
