Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRHKLDL>; Sat, 11 Aug 2001 07:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266673AbRHKLDC>; Sat, 11 Aug 2001 07:03:02 -0400
Received: from CPE-61-9-149-76.vic.bigpond.net.au ([61.9.149.76]:41198 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S266488AbRHKLCu>;
	Sat, 11 Aug 2001 07:02:50 -0400
Message-ID: <3B750F77.FAA9A123@eyal.emu.id.au>
Date: Sat, 11 Aug 2001 20:56:55 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: quintaq@yahoo.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Errors compiling emu10k1 module under 2.4.8
In-Reply-To: <20010811101557Z266921-760+224@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quintaq@yahoo.co.uk wrote:
> 
> Hi,
> 
> I just d/ld the 2.4.8 patch and compilation of emu10k1 fails with :
> 
> main.o(.modinfo+0x20): multiple definition of `__module_author'
> joystick.o(.modinfo+0x80): first defined here
> ld: Warning: size of symbol `__module_author' changed from 67 to 81 in
> main.o
> main.o(.modinfo+0x80): multiple definition of `__module_description'
> joystick.o(.modinfo+0xe0): first defined here
> ld: Warning: size of symbol `__module_description' changed from 83 to 96 in
> main.o
> main.o: In function `init_module':
> main.o(.text+0x1878): multiple definition of `init_module'
> joystick.o(.text+0x240): first defined here
> ld: Warning: size of symbol `init_module' changed from 64 to 67 in main.o
> main.o: In function `cleanup_module':
> main.o(.text+0x18bc): multiple definition of `cleanup_module'
> joystick.o(.text+0x280): first defined here
> make[3]: *** [emu10k1.o] Error 1

Seems that joystick.c wants to be a module by itself, so it cannot be
linked with the rest of the modules here.

Removing 'joystick.o' from drivers/sound/emu10k1/Makefile solves the
compile problem, but I do not know that it is the correct solution.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
