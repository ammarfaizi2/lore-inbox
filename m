Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129864AbQKLTeK>; Sun, 12 Nov 2000 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbQKLTeA>; Sun, 12 Nov 2000 14:34:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:26637 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129864AbQKLTd4>;
	Sun, 12 Nov 2000 14:33:56 -0500
Date: Sun, 12 Nov 2000 20:33:53 +0100
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112203353.A13289@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random> <m1bsvlauic.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1bsvlauic.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 12, 2000 at 11:57:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is quite a bizarre discussion, but I'll answer anyways. I am not exactly
sure what your point is]

On Sun, Nov 12, 2000 at 11:57:15AM -0700, Eric W. Biederman wrote:
> 
> > > I can tell you don't have real hardware.  The non obviousness
> 
> I need to retract this a bit.  You are still building a compressed image,
> and the code in the boot/compressed/head.S remains unchanged and loads
> segment registers, so it works by luck.  If you didn't build a
> compressed image you would be in trouble.

boot/compressed/head.S does run in 32bit legacy mode, where you of course
need segment registers. After you got into long mode segments are only
needed to jump between 32/64bit code segments and and for a the data segment
of the 32bit emulation (+ the iretd bug currently which I hope will be fixed
in final hardware) 

Also note that boot/compressed/* currently does not even link, because the 
x86-64 toolchain cannot generate relocated 32bit code ATM (the linker chokes
on the 32bit relocations) The tests we did so far used a precompiled 
relocated binary compressed/{head,misc}.o from a IA32 build.

> > 	In 64-bit mode, the contents of the ES, DS, and SS segment registers
> > 	are ignored. All fields (base, limit, and attribute) in the
> > 	corresponding segment descriptor registers (hidden part) are also
> > 	ignored.
> 
> Hmm.  I'll have to look and see if FS & GS are also ignored.

They are not, you to fully use them you need privileged MSRs. 
Their limit is ignored.

> > Sure, go ahead if you weren't missing that basic part of the long mode specs.
> > Thanks.
> 
> Nope.  Though I suspect we should do the switch to 64bit mode in
> setup.S and not have these issues pollute head.S at all.

I see no advantage in doing it there instead of in head.S



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
