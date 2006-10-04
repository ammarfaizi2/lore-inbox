Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWJDUCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWJDUCO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJDUCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:02:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:27111 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750969AbWJDUCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:02:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X78xRQMgm/cDnuldDtT1UQxDKWRTzleRrOOOrYtqQokNNgaJbDXANQX5u8Ox/3+EFOatU+4ziu5Kp2c9SLXwoh9OHxjOl1i9yKrBhPUKPpWMUzs8+pcL/ASwOc9YvDYaSEmgtBtNV27whgKYDytnnwZ/LukC0zzRXJLX5VGUA4w=
Message-ID: <9a8748490610041302i2bc4d1aave8fbc3e6c153759b@mail.gmail.com>
Date: Wed, 4 Oct 2006 22:02:12 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610041235380.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	 <20061002213809.7a3f995f.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
	 <20061003092339.999d0011.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>
	 <20061003094926.0e99d13f.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030950230.3952@g5.osdl.org>
	 <9a8748490610041224h7de321r6507a0d9e99ad015@mail.gmail.com>
	 <Pine.LNX.4.64.0610041235380.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Wed, 4 Oct 2006, Jesper Juhl wrote:
> >
> > I just tested 2.6.18-git21 and here's a small status report :
> >
> > The good news is: The kernel boots.
> > The bad news is: Userspace breaks left and right.
> >
> > I'm booting with "no387 nofxsr"
> >
> > On my first boot I just used the options above and the result was that
> > most of the bootup sequence looked quite normal until I got to the
> > point of starting sshd, then things started to go wrong. This is what
> > I got :
> >
> > ...
> > /etc/rc.d/rc.sshd: line 4: 1491 Illegal instruction    /usr/sbin/sshd
>
> Ok, I bet you have your sshd compiled to use MMX instructions
> unconditionally.
>

Probably, I haven't checked.


> > So that's great progress, but it could certainly work a lot better.
>
> I don't think there is a whole lot we can do about it. There's really two
> choices:
>
>  - make sure all user-space is able to function without MMX. This means,
>    for example, that you must certainly never compile with some code that
>    switches between MMX and non-MMX statically.
>
If the emulator can't handle it (which it cannot), that makes perfect sense :)

>    The most common cases you'd expect to use MMX is for encryption, but
>    graphics and 3D certainly sounds very possible too..
>
>    This isn't really somethign _we_ can do a lot about, although
>    distributions that care may of course try to test that their distro
>    works with "no387 nofxsr". You didn't say what distro you used, maybe
>    you can point it out to them.
>

Actually, I did (Slackware 11) :

   > broken (didn't really expect otherwise). I managed to get a login
   > prompt, logged in and successfully switched to runlevel 3 (which on my
   > distro (Slackware 11) is multi-user without X). Then I tried to


>  - we could try to extend the math emulator to emulate the new
>    instructions too.
>
That would, in my oppinion, be the right way forward.

I fondly remember the days of old when I had an old 386 with no 387
and I was able to move my kernel between my machine and my friends
486SX/DX & Pentium boxes and with the math emulator in place
*everything* just worked perfectly - it may have been a little slow
with the emulator, but it always worked correctly, even though the
disk I moved around was setup to always use the emulator... I would
love to get that back.


>    The thing is, it's probably not worth it. The only actual real usage
>    would be if somebody wants to take a disk image and switch to a really
>    old machine that lacked the MMX instruction, or for this particular
>    test-case.
>
I think I can think of a few more.

One is obviously, as you say, move a disk image (or live CD) to a
really old machine.
Another is just to test the math emulator (this test case).
Another is platforms that don't have a math co-processor or
MMX/SSE/3DNow etc at all, their life would be simplified if the
emulator "just worked".
Another example (a bit far fetched, I admit) would be a damaged CPU
where the FPU doesn't work.
Yet another case would be where someone wanted to use the emulator for
better precision than the hardware gives and the slowdown is
acceptable - I may be imagining this, but I seem to have this memory
telling me that for some things back in the days the emulator was
actually more precise than the hardware.


> so I suspect that in practice, the answer is "if the distro isn't compiled
> for a generic x86 target, screw it".
>
I guess I'll have to accept that or start hacking on the emulator
myself :)   Let's see...


There is one thing we can easily do though, to improve things.
I noticed when booting my Athlon 64 X2 4400+ with "no387 nofxsr" that
the "flags" line in /proc/cpuinfo still report stuff that's not
supported by the emulator :

...
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
...

When the emulator is in effect, shouldn't we remove things like "mmx,
sse2, mmxext, fxsr_opt, 3dnowext, 3dnow, pni" from the /proc/cpuinfo
output?
That would prevent silly apps that check the flags line from
/proc/cpuinfo for CPU capabilities from detecting a capability that we
are not able to support.    Yes, I know that an app that relies on
/proc/cpuinfo for detection of this is silly/stupid, but the last
stupid programmer has not been born yet, and such apps may very well
exist in the wild. Not printing stuff we can't emulate will probably
make a few apps out there behave correctly with math-emu in effect,
and I don't see any downside...   I can try to prepare a patch if you
like...?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
