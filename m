Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTEIXts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTEIXtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:49:24 -0400
Received: from pop.gmx.de ([213.165.65.60]:48755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263607AbTEIXsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:48:31 -0400
Message-ID: <3EBC4119.B5C8F11A@gmx.de>
Date: Sat, 10 May 2003 02:00:25 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2A3C.8040409@redhat.com> <3EBC3167.2030302@techsource.com> <3EBC38C1.6020305@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > Why does there ever need to be an explicit HINT that you would prefer a
> > <32 bit address, when it's known a priori that <32 is better?  Why
> > doesn't the mapping code ALWAYS try to use 32-bit addresses before
> > resorting to 64-bit?
> 
> Because not all memory is addressed via GDT entries.  In fact, almost
> none is, only thread stacks and similar gimicks.  If all mmap memory
> would by default be served from the low memory pool you soon run out of
> it and without any good reason.

As if there are so many apps that would suffer from that...

Anyway, what's so bad about the idea someone (Linus?) suggested?
Without MAP_FIXED the address given to mmap is already taken as a
hint where to start looking for free memory.  So use mmap(4GB,...)
for regular memory and mmap(4kB, ...) for stacks.  What's wrong
with that?  And if you are really frightend to run out of "low"
memory make the above-4GB allocation the default for addr==0.

Ciao, ET.
