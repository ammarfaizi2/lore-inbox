Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVCZNxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVCZNxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCZNxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:53:24 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:39082 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S262070AbVCZNxM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:53:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bart Oldeman <bartoldeman@users.sourceforge.net>
Subject: Re: 2.6.12-rc1 breaks dosemu
Date: Sat, 26 Mar 2005 14:49:44 +0100
User-Agent: KMail/1.7.1
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
References: <20050320021141.GA4449@stusta.de> <1111824629.6293.19.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0503262009040.3040@enm-bo-lt.localnet>
In-Reply-To: <Pine.LNX.4.58.0503262009040.3040@enm-bo-lt.localnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503261449.46219.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 26 März 2005 09:18, Bart Oldeman wrote:
> On Sat, 26 Mar 2005, Arjan van de Ven wrote:
> 
> > > eip: 0x000069ee  esp: 0xbfdbffcc  eflags: 0x00010246
> >
> > hmm interesting. Can you check if at the time of the crash, the esp is
> > actually inside the stack vma? If it's not, I wonder what dosemu does to
> > get its stack pointer outside the vma... (and on which side of the vma
> > it is)

The esp value is always slightly below the stack vma and above ld.so.
Running it a few times gives 

stack VMA         crash esp
bfc8f000-bfca4000 bfc5ffcc  
bffa0000-bffb7000 bff5ffcc  
bfe0c000-bfe23000 bfdbffcc  
bf7ff000-bf814000 bf7bffcc  
bfaa9000-bfabe000 bfa5ffcc  
bfaa9000-bfabe000 bfa5ffcc  
bffc5000-bffda000 bff7ffcc  
bfba9000-bfbbf000 bfb5ffcc  
bf865000-bf87b000 bf81ffcc  
bfe7d000-bfe92000 bfe3ffcc
...  
bff9f000-bffb4000 bff5ffcc  
bfc73000-bfc89000 bfc3ffcc
bffe3000-bfff8000 -> works

> To Arnd:
> 
> Another thing you should probably do is to build dosemu with debug
> information, and then look into ~/.dosemu/boot.log after it crashes.
> That will give you the contents of /proc/self/maps, a gdb backtrace and
> various other goodies.
> 
> I've checked it myself but can't reproduce, neither with plain dosemu
> 1.2.2 nor with current CVS.

I'm using the dosemu-1.2.1-3 binary that currently comes with debian
sarge, and would prefer not having to build a new dosemu. As far as
I can tell, the command.com that is started belongs to freedos, not
comcom.
The crash however does happen shortly after the command.com file
is opened.

 Arnd <><
