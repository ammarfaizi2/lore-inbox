Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbSA2W5n>; Tue, 29 Jan 2002 17:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSA2W5h>; Tue, 29 Jan 2002 17:57:37 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:57745
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285692AbSA2W5R>; Tue, 29 Jan 2002 17:57:17 -0500
Message-Id: <200201292256.g0TMu1U20885@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mingo@elte.hu
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 17:57:08 -0500
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (linux-kernel),
        axboe@suse.de (Jens Axboe), esr@thyrsus.com
In-Reply-To: <E16VYVH-0003x8-00@the-village.bc.nu>
In-Reply-To: <E16VYVH-0003x8-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 08:40 am, Alan Cox wrote:
> > for code areas where there is not active maintainer or the maintainer has
> > ignored patches? Eg. the majority of the kdev transition patches went in
> > smoothly.
>
> No you merely aren't watching. Most of the maintainers btw are ignoring 2.5
> if you do some asking. And a measurable number of the listed maintainer
> addresses just bounce.

I'm under the impression Michael Elizabeth Chastain is one such burned out 
maintainer, but hasn't been able to hand over maintainership because Linus 
keeps dropping his patch to change the maintainers file to say "Peter 
Samuelson", and he eventually just gave up trying.

I could be wrong about this.  Ask him.  Or maybe his maintainer hand-over 
patch needs more code review?

> > Another reason is that you do much more housekeeping in areas that are
> > not actively maintained. But wouldnt it be better if there were active
> > maintainers in those areas as well so you could spend more time on eg.
> > doing the kernel-stack coloring changes?
>
> There never will be maintainers proper for large amounts of stuff, and the
> longer Linus deletes and ignores everything from someone new the less
> people will bother sending to him.

Case in point:

--- linux/arch/i386/boot/bootsect.S.old Tue Jan  1 19:41:22 2002
+++ linux/arch/i386/boot/bootsect.S     Tue Jan  1 19:44:02 2002
@@ -158,9 +158,7 @@
        movw    $sread, %si             # the boot sector has already been 
read
        movw    %ax, (%si)

-       xorw    %ax, %ax                # reset FDC
-       xorb    %dl, %dl
-       int     $0x13
+       call    kill_motor              # reset FDC
        movw    $0x0200, %bx            # address = 512, in INITSEG
 next_step:
        movb    setup_sects, %al

Dumb little nit I noticed a few weeks ago, but never bothered to follow up 
on, because it's just not worth it.  Not that potentially saving 3 bytes out 
of the boot sector is a BAD thing, but it's not good enough to be worth the 
effort anymore.  Warning fixing patches are largely the same way: easy to do, 
but why?

This didn't strike me as a healthy development, really...

> Just look at the size of the diff set
> between all the vendor kernels and Linus 2.4.x trees before the giant -ac
> merge.
>
> Think gcc, think egcs. History is merely beginning to repeat itself

I was actually hoping to AVOID that.  (There IS still time.  We're not that 
badly off.  Yet.  I'm just a bit nervous about direction.  The kind of 
stresses I've seen seem (to me) unlikely to improve with time...)

And we ARE using a patch penguin.  You were around, and Dave is around.  I'm 
kind of confused at the level of resistence to formally recognizing what 
basically IS current practice, and has been for YEARS.  (The reason for 
naming the position is we can't just say "alan's tree" anymore.  The position 
went from one person to another person, and as such the position seemed to 
need to be recognized as being separate from the individual.  I didn't expect 
to hit a brick wall on that.  It  didn't seem like a revolutionary idea to 
me...)

> Alan

