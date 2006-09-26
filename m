Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWIZHJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWIZHJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWIZHJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:09:58 -0400
Received: from mail.suse.de ([195.135.220.2]:11499 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751720AbWIZHJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:09:58 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
Date: Tue, 26 Sep 2006 09:09:47 +0200
User-Agent: KMail/1.9.3
Cc: Martin Bligh <mbligh@google.com>, LKML <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
References: <45185A93.7020105@google.com> <200609260841.27413.ak@suse.de> <20060926000714.bd12361b.akpm@osdl.org>
In-Reply-To: <20060926000714.bd12361b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260909.47555.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 09:07, Andrew Morton wrote:
> On Tue, 26 Sep 2006 08:41:27 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Tuesday 26 September 2006 00:39, Martin Bligh wrote:
> > > http://test.kernel.org/abat/49037/debug/test.log.0	
> > > 
> > >    AS      arch/x86_64/boot/bootsect.o
> > >    LD      arch/x86_64/boot/bootsect
> > >    AS      arch/x86_64/boot/setup.o
> > >    LD      arch/x86_64/boot/setup
> > >    AS      arch/x86_64/boot/compressed/head.o
> > >    CC      arch/x86_64/boot/compressed/misc.o
> > >    OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> > > BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file 
> > > offset 0x804700c0.
> > 
> > Most likely that is the problem. I don't know what patch it could be
> > (none of mine have been merged yet).
> 
> That was 2.6.18-mm1 - it has around 300 of "yours" ;)
> 
> > Can you bisect?
> 
> I was unable to reproduce it.  Lack of disk space is suspected.

I suppose the BFD warning (writing to negative file offset) will cause that.
I guess it tried to write ~4GB into the executable.

Probably it's a toolchain problem of some sort then.

-Andi


