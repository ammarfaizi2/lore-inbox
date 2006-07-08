Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWGHDmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWGHDmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWGHDmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:42:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:54156 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932501AbWGHDmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:42:42 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sat, 8 Jul 2006 13:42:32 +1000
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net, Olivier Galibert <galibert@pobox.com>,
       grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz>
In-Reply-To: <20060708002826.GD1700@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1245645.kjnKsUnlyN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607081342.40686.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1245645.kjnKsUnlyN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 08 July 2006 10:28, Pavel Machek wrote:
> I really looked at suspend2 hard, year or so ago, when I was pretty
> tired of the flamewars. At that point I decided it is way too big to
> be acceptable to mainline, and got that crazy idea about uswsusp, that
> surprisingly worked out at the end.
>
> uswsusp makes suspend2 obsolete, and suspend2 now looks
> misdesigned. It puts too much stuff into the kernel, you know that
> already.

No, I don't. From my point of view, uswsusp is misdesigned, but suspend2=20
isn't. Suspend2 keeps the stuff that ought to be done by the kernel in the=
=20
kernel. It doesn't shift data out to userspace, only to copy it straight ba=
ck=20
to the kernel for I/O. It will keep working even if userspace crashes and=20
burns. It leverages support for compression and encryption that's already i=
n=20
the kernel. It does a real image of memory, not a half-pie attempt that=20
causes lots of faulting of pages etc post-resume. If there's any misdesign =
in=20
Suspend2, it's that I haven't made it a special case of checkpointing. But,=
=20
of course, there's no support for checkpointing in the rest of the kernel a=
t=20
the moment anyway.

> From your point of view, uswsusp is misdesigned, too. It is too damn
> hard to install. There's no way it could survive as a standalone patch
> -- the way suspend2 survives. Fortunately, from distro point of view,
> being hard to install does not matter that much. Distros already have
> their own initrds, etc. And in the long term, distros matter, and I'm
> quite confident I can make 90% distributions ship uswsusp + its
> userland; cleaner kernel code matters, too, and maybe you'll agree
> that if you only look at the kernel parts, uswsusp looks nicer.

It looks simple, I agree. But that's only because it's doing the minimum=20
required.

> Now, you are asking me to review 14000 lines of code. That's quite a
> lot of code, and you did not exactly make reviewer's life easy. Also
> reviews usually stop at first "fatal" problem, and you still drive
> user interface from kernel. (Yes, drawing is done in userland, but
> core user interface code is still in kernel). That is "fatal".

I agree that I didn't do the best job of making the reviewer's life easy. B=
ut=20
let's give me some credit. I did all those patches because I genuinely=20
thought that's what was requested the last time I submitted patches for=20
review. I didn't like splitting up the files into all those patches - it wa=
s=20
a lot of work and took a lot of time. But I did it because I wanted to do=20
what was asked and wanted to do what was necessary to get a good=20
implementation into the vanilla kernel.

=46rankly, I'd rather be working on improving drivers and helping implement=
 the=20
run-time power management than working on getting Suspend2 merged. But for=
=20
now, this is the immediate task.

I don't know why you see the user interface code as a problem. All the kern=
el=20
is doing is telling the userspace program, via a netlink socket, what's goi=
ng=20
on and receiving messages from the userspace program sometimes.

> (Greg mentioned /proc usage being "fatal", too).

> Now... moving user interface into userland, and removing /proc usage
> are big tasks, do you agree? And they will mean lot of changes, and
> lot of new testing.

Removing /proc isn't a big task. It will affect the hibernate script far mo=
re=20
that the kernel code. The user interface is already in userland.

> Perhaps at this point right solution is to just drop suspend2
> codebase, and do it again, this time in userland? Kernel
> infrastructure is already there, and even if you wanted to replace
> [u]swsusp by suspend2, you have to understand how the old code
> works. (Another point you may like is that forking suspend.sf.net code
> is relatively easy; so even if we disagree about coding style of the
> userland parts, I can't veto it or something. And given that your only
> problem is including all the possible features, I probably will not
> have reason to stop you or something -- having all the features is
> okay in userland).

I don't want to fork anything. I didn't fork swsusp to start with, and I do=
n't=20
want to start forking things now. (If you want to debate that point, can yo=
u=20
check the mailing list archives on Sourceforge, Berlios and suspend2.net=20
first? You'll find that I just carried on where Florent left off).

> Now... switching to uswsusp kernel parts will make it slightly harder
> to install in the short term (messing with initrd). OTOH there's at
> least _chance_ to get to the point where suspend "just works" in
> Linux, in the long term...
>
> (Of course, you can just ignore this and keep maintaining out-of-tree
> suspend2. We'll also get to the point where it "just works"... it will
> just take a little longer.)

With your current design, I don't see how you're ever going to get to the=20
level of functionality that Suspend2 has. I'm of course thinking of a full=
=20
image of memory (although Rafael's patch a while back looked hopeful there)=
=20
and support for other-than-just-one-swap-partition.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1245645.kjnKsUnlyN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErymwN0y+n1M3mo0RAudRAKC782CK962MQNRpAJD7fBT9PsQMgQCfbGpx
gNo4+MNI53/dXrdpFfPzf0o=
=rBpX
-----END PGP SIGNATURE-----

--nextPart1245645.kjnKsUnlyN--
