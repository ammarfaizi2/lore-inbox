Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbSKVHwr>; Fri, 22 Nov 2002 02:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbSKVHwr>; Fri, 22 Nov 2002 02:52:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3591 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266975AbSKVHwq>; Fri, 22 Nov 2002 02:52:46 -0500
Date: Fri, 22 Nov 2002 00:00:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] export e820 table on x86
In-Reply-To: <3DDDE1DC.3080408@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211212355060.7728-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Nov 2002, Dave Hansen wrote:
>
>   BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
>   BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
>   BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 000000003fff9380 (usable)
>   BIOS-e820: 000000003fff9380 - 0000000040000000 (ACPI data)
>   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>   BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 
> I added a " e820" onto the end of each of the cases in 
> register_memory().  Where does the "00000000000e0000 - 
> 0000000000100000 (reserved)" entry go?

The kernel removes all region claims in the 0xa0000 - 0x100000 area, since 
there are broken bioses that claim there is good memory there even if 
there isn't.

>  I wonder if it is vital to the  next boot...

Nope, the next boot would also just remove it..

		Linus

