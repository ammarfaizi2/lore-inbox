Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUBFSf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUBFSf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:35:28 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:12674 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265578AbUBFSfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:35:15 -0500
Date: Fri, 6 Feb 2004 19:35:08 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040206183508.GA3268@vana.vc.cvut.cz>
References: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net> <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402060850380.30672@home.osdl.org> <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 06:22:08PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Umm...  How about
> 
> static inline void BUG() __attribute__((noreturn));
> 
> static inline void BUG(void)
> {
> 	__asm__ ....
> }

Unfortunately gcc thinks that it knows better than you whether function
can return or not. I attempted to use noreturn attribute in couple of
my projects, but it is useless - unless you terminate your function
with for(;;) or with call to _exit(), it won't work.

vana:~# more m.c
static inline void BUG() __attribute__((noreturn));

static inline void BUG(void) {
        __asm__ ("1: jmp 1b");
}

void main(void) {
        BUG();
}

vana:~# gcc -W -Wall m.c
m.c:7: warning: return type of `main' is not `int'
m.c: In function `BUG':
m.c:3: warning: `noreturn' function does return
vana:~#

(gcc version 3.3.3 20040125 (prerelease) (Debian))

> > Better to just initialize the variable to a default value and avoid the 
> > warning for now.
> 
> Alternatively, we can just turn the damn thing into
> 	if (dev->mode == IMM_NIBBLE || dev->mode = IMM_PS2)
> 		ports = 3;
> 	else
> 		ports = 8;
> and be done with that...

Yes.
				Petr Vandrovec

