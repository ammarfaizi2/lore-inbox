Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTDWTAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTDWTAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:00:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264260AbTDWTAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:00:38 -0400
Date: Wed, 23 Apr 2003 12:11:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Kirilenko <icedank@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Message-Id: <20030423121123.0a5c3171.rddunlap@osdl.org>
In-Reply-To: <200304232200.20028.icedank@gmx.net>
References: <200304231958.43235.icedank@gmx.net>
	<200304232125.22270.icedank@gmx.net>
	<Pine.LNX.4.53.0304231446090.25670@chaos>
	<200304232200.20028.icedank@gmx.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003 22:00:20 +0300 Andrew Kirilenko <icedank@gmx.net> wrote:

| Hello!
| 
| > > > > I've written something similar to this before - and it wont' work, so
| > > > > I've reimplemented it. The problem is, that I don't know how to set
| > > > > ES properly. I only know, that BIOS data (and code) is located in
| > > > > 0xe000..0xf000 (real address).
| > > >
| > > > Yeah. So. I set ES and DS to be exactly where CS is. This means that
| > > > if your &!)(^$&_ code executes it will work. So, instead of trying
| > > > it, you just blindly ignore it and state that it won't work.
| > > >
| > > > Bullshit. I do this for a living and I gave you some valuable time
| > > > which you rejected out-of-hand. Have fun.
| > >
| > > Of course, I've tried your code as well - the same result! Sorry, if you
| > > haven't understand me.
| > >
| > > The problem is, that I don't know where this BIOS code is relative to
| > > current code segment (CS). I only know (hope), that it should be in
| > > 0x0:0xe000...0x0:0xf000. I have tried to set ES to 0 (xor %ax, %ax; mov
| > > %ax, %es) - no luck as well. BTW, `strings /dev/mem | grep "REQUESTED
| > > STRING"` founds it perfectly...
| > >
| > > Best regards,
| > > Andrew.
| > > -
| >
| > The bios is in segment 0xf000. You set ES to that area. ES:DI will
| > start at 0 if bx=0 in the code shown. The BIOS is only 64k.
| > This means that where bx is being incremented (it should be incw, not
| > incb). It would generate an assembly error with incb which is why
| > I knew you didn't even try it.  -- you just jnz back to 1b, without
| > any additional test.
| 
| 1. How to set ES to this area? "movw $0xf000, %ax ; movw %ax, %es" will be 
| enough?

That should do it.

| 2. Is the are really starts from 0xf000? Or 0xe000?

Most current ones that I know of are 128 KB, so start at segment 0xe000:0
thru 0xf000:ffff.
Just boot DOS, run debug, and display those areas.  That will answer
it for you.  :)

| 3. I'm smart enough to correct "incb %bx" to "incw %bx" ;)

--
~Randy
