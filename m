Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281648AbRLBRyQ>; Sun, 2 Dec 2001 12:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281663AbRLBRyH>; Sun, 2 Dec 2001 12:54:07 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:54524 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281648AbRLBRxx>; Sun, 2 Dec 2001 12:53:53 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16AIZ8-0008Re-00@the-village.bc.nu> 
In-Reply-To: <E16AIZ8-0008Re-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: maze@druid.if.uj.edu.pl (Maciej Zenczykowski),
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Dec 2001 17:53:37 +0000
Message-ID: <12969.1007315617@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > I would like to have a 64 KBarray (of char), that's trivial, however
> > what I would like is for the last 4 KB [yes thankfully this is exactly
> > one page... (assume i386)] to reference the same physical memory as the
> > first four.

> mmap will do what you need. Create a 60K object on disk and mmap it at
> the base address and then 60K further on for 4K.  

You said 'assume i386', but just to make it clear - this is likely to break
horribly on some non-i386 platforms, due to dcache aliasing. You may find
that the second mmap(MAP_FIXED) fails, or if it succeeds then changes made
with one virtual address won't be instantly visible through the other
mapping. About the best case on such hardware is that Linux will just map
the offending page uncached.

--
dwmw2


