Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWJWBuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJWBuA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWJWBuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:50:00 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:19849 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751130AbWJWBt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:49:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AE0XkBLz5pb1BOmXGDJRpCrmfsLgDRjFA51hhxD6Jl0pz0lqjc6HEYfHhY2w9kyzn0nSWyuSR2cIHvOvJ7NNdgXUDN/iNANs0wIxhwdMaxN/r0lJU0GffwFDc3nyfZeVhB663HB5kwlN8fR7wAD0fJQG8TSCwWNpcChNz65PXlQ=  ;
Message-ID: <453C1FB5.9070007@yahoo.com.au>
Date: Mon, 23 Oct 2006 11:49:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <200610230242.58647.ak@suse.de> <20061023010812.GE25210@parisc-linux.org> <200610230331.16573.ak@suse.de> <20061023013604.GF25210@parisc-linux.org>
In-Reply-To: <20061023013604.GF25210@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

> Let me try to explain the problem again, because what you wrote has
> nothing to do with the problem.
> 
> canonicalize_irq() is defined in <asm/irq.h>.  No .c file should be
> including <asm/irq.h> in order to get it.  It should be including
> <linux/interrupt.h>, which will indirectly pull in <asm/irq.h>
> 
> add_wait_queue() is defined in <linux/wait.h>.  .c files wishing to use
> add_wait_queue() should be including <linux/wait.h> rather than relying
> on it being pulled in through some other path.
> 
> This needs annotations to fix, or a big bag of unreliable heuristics.

Does fixing it really fix anything? I agree that cleaning it all up would
be great. But the aim should be to make less work for developers, rather
than more.

If you have an

#ifndef _LINUX_INTERRUPT_H
#error ...

That almost explicitly tells you which is the correct file to include to
get all definitions from this file. Wouldn't that help?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
