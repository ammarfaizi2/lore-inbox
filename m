Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272527AbTHNQIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272480AbTHNQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:06:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:4805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272468AbTHNQGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:06:32 -0400
Date: Thu, 14 Aug 2003 09:06:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lincoln Durey <lincoln@emperorlinux.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@emperorlinux.com>
Subject: Re: 2GB laptop has pcmcia_cs looking for _insane_ sockets
In-Reply-To: <1060875427.15508.2438.camel@tori>
Message-ID: <Pine.LNX.4.44.0308140901320.8148-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Aug 2003, Lincoln Durey wrote:
> 
> There can't be that many laptops with 2GB RAM, but surely this report
> indicates an error somewhere in the pcmcia_cs code (it is looking for
> socket number e9b91000 !!)

The socket number is just a random allocation (but useful to keep two 
different sockets separated - think of it as just a unique ID). That value 
actually looks reasonable, it's in the kernel virtual address space.

However, the fact that it doesn't work clearly means that _something_ is 
wrong, and the memory size part is interesting:

>			  This bug is a feature of having 2GB ram in
> the system and has nothing to do with specific PC cards drop back to 1GB
> and all is well

It's almost certainly the Yenta PCI resource that got allocated in the 
wrong area, and instead of pointing to PCI memory-mapped space it just 
points to RAM. 

Can you show the results of "cat /proc/iomem" and "lspci -vvxxx", and also
try this with a 2.6.0-test3 kernel just to see if the resource handling is
fixed?

			Linus

