Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTDWRxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTDWRxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:53:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:6159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264192AbTDWRxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:53:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Date: Wed, 23 Apr 2003 21:05:38 +0300
User-Agent: KMail/1.4.3
References: <200304231958.43235.icedank@gmx.net> <Pine.LNX.4.53.0304231311460.25222@chaos>
In-Reply-To: <Pine.LNX.4.53.0304231311460.25222@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304232105.38722.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If you need to search the whole BIOS for that string, you need to
> set up an outer loop using an unused register which starts at
> the offset of the BIOS and increments by one byte everytime
> you can't find the string. This value gets put into %di, instead
> of the absolute number specified above.
>
> Like:
>
> scan:	movw	%cs, %ax
> 	movw	%ax, %ds
> 	movw	%ax, %es
> 	movw	$where_in_BIOS_to_start, %bx
> 	cld
> 1:	movw	$cl_id_str, %si		# Offset of search string
> 	movw	$cl_id_end, %cx		# Offset of string end + 1
> 	subw	%si, %cx		# String length
> 	decw	%cx			# Don't look for the \0
> 	movw	%bx, %di		# ES:DI = where to look
> 	repz	cmpsb			# Loop while the same
> 	jz	found			# Found the string
> 	incb	%bx			# Next starting offset
> 	cmpb	$_BIOS_END, %bx		# Check for limit
> 	jb	1b			# Continue
> never_found_anywhere:
>
> found:

I've written something similar to this before - and it wont' work, so I've 
reimplemented it. The problem is, that I don't know how to set ES properly. I 
only know, that BIOS data (and code) is located in 0xe000..0xf000 (real 
address).

Best regards,
Andrew.
