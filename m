Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUAZFIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUAZFIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:08:00 -0500
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:2711 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S265516AbUAZFG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:06:56 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Keywords: module,users,kernel,once,number,hard,extremely,count
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
	<Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
	<microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org>
	<20040125222242.A24443@mail.kroptech.com>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Mon, 26 Jan 2004 15:06:48 +1000
In-Reply-To: <20040125222242.A24443@mail.kroptech.com> (Adam Kropelin's
 message of "Sun, 25 Jan 2004 22:22:42 -0500")
Message-ID: <microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Adam Kropelin <akropel1@rochester.rr.com> writes:

  > On Mon, Jan 26, 2004 at 09:12:58AM +1000, Steve Youngs wrote:
  >> * Linus Torvalds <torvalds@osdl.org> writes:
  >> 
  >> >  - doing proper refcounting of modules is _really_ really
  >> >    hard. The reason is that proper refcounting is a "local"
  >> >    issue: you reference count a single data structure. It's
  >> >    basically impossible to make a "global" reference count
  >> >    without jumping through hoops.
  >> 
  >> Please understand that I coming from an _extremely_ naive perspective,
  >> but why do refcounting at all?  Couldn't the refcount be a simple
  >> boolean?

  > A boolean is just a one-bit reference count. If the maximum number of
  > simultaneous 'users' for a given module is one, then a boolean will work.
  > If there is potential for more than one simultaneous user then you need
  > more bits.

Why?  A module is either being used or it isn't, the number of uses
shouldn't even come into it.

  >> I see the process working along these lines: When a module is loaded
  >> into the kernel it (the module) exports a symbol (a function) that the
  >> kernel can use for determining whether or not the module is still in
  >> use.

  > And how will the module know when it is or is not "in use"? By keeping
  > a count of the number of current users, of course.

No, the number of current users wouldn't have any bearing on it whatsoever.
How each module does it would be up to the module itself.  For an ethernet
card it could be while the card is associated with a IP; for a USB keyboard
it could be while the keyboard is plugged in; for a sound driver it could
be while anything is accessing the sound devices. etc etc.

I'm suggesting that the responsibility for determining when it is safe
to unload a particular module should lay with the module itself and
not with the kernel.

  >> >  - lack of testing. 
  >> 
  >> A moot point once the kernel can safely and efficiently do module
  >> unloading. 

  > I don't follow your logic. Once it works we don't have to test it so 
  > therefore we never need to test it?

Possibly a poor choice of words on my part.  What I meant was that
once the functionality goes into the kernel testing will happen on
every single Linux box in the land that has this future kernel.  Some
of those users will report bugs if there are any.  And some of those
users may even help to fix those bugs.

Also what I meant is that you can't test something that doesn't
exist.

  >> >    Unloading a module happens once in a blue moon, if even then.
  >> 
  >> We get an awful lot of blue moons here.

  > This moon's not worth barking at.

There are an awful lot of users out there who would disagree with you
on that.  _One_ of the reasons that I believe that this moon is worth
barking at is:

If a module should never, in the normal course of events, be unloaded,
then there isn't _any_ point to being able to load them in the first
place.  Not being able to unload them _totally_ defeats the purpose of
modules.

Yes, I could be wrong, I sure as anything don't know the full story,
but I'm not convinced that I am wrong yet.

  > Several extremely bright people have tackled the problem and eventually
  > concluded it's extremely hard to solve and generally not worth the
  > trouble. It's time to let go.  

Several extremely bright people thought Galileo was a heretic and a
fool. 

Tell me that this problem is _impossible_ to solve and providing you
can show me _why_ it is impossible I'll speak no more on this
matter.

But if you tell me that this problem is too hard to solve, then I have
no alternative than to think: "you're not trying hard enough".


-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkAUoGsACgkQHSfbS6lLMAOTjACglzJ4gC8KjBA0V6DcOhDP2/Or
WgsAnia2TUBDUwOFi0W/QEqQVQleVg8G
=SVSR
-----END PGP SIGNATURE-----
--=-=-=--
