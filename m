Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUAYXNc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbUAYXNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:13:32 -0500
Received: from gizmo02bw.bigpond.com ([144.140.70.12]:61059 "HELO
	gizmo02bw.bigpond.com") by vger.kernel.org with SMTP
	id S265332AbUAYXNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:13:19 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Keywords: module,use,unloading,modules,kernel,refcounting,proper,cdrom
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
	<Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: The Right Time --- [Hoodoo Gurus]
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, Linus
 Torvalds <torvalds@osdl.org>
Date: Mon, 26 Jan 2004 09:12:58 +1000
In-Reply-To: <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> (Linus
 Torvalds's message of "Sun, 25 Jan 2004 11:02:58 -0800")
Message-ID: <microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Linus Torvalds <torvalds@osdl.org> writes:

  >  - doing proper refcounting of modules is _really_ really
  >    hard. The reason is that proper refcounting is a "local"
  >    issue: you reference count a single data structure. It's
  >    basically impossible to make a "global" reference count
  >    without jumping through hoops.

Please understand that I coming from an _extremely_ naive perspective,
but why do refcounting at all?  Couldn't the refcount be a simple
boolean?  For example:

  - The cdrom module is "in use" when a cdrom filesystem is mounted
    and it isn't "in use" when there are _no_ cdrom filesystems
    mounted. 

  - An ethernet module is "in use" while the device is attached to an
    IP. 

  - A packet filter module is "in use" while there are iptables rules
    (or similar) existing that require it.

I see the process working along these lines: When a module is loaded
into the kernel it (the module) exports a symbol (a function) that the
kernel can use for determining whether or not the module is still in
use.  If no such symbol is exported the kernel would mark the module
as being "non-unloadable" (its refcount would always be non-nil), and
send an appropriate message to root via syslog saying "xyz module
cannot be automatically unloaded".

It should also be possible for modules to tell the kernel, through the
same mechanism, that they should _never_ be unloaded.

I don't, yet, have the knowledge to turn my ideas into code so I won't
be offended in the slightest if you ignore them.  Just tell me
why. :-) 

  >  - lack of testing. 

A moot point once the kernel can safely and efficiently do module
unloading. 

  >    Unloading a module happens once in a blue moon, if even then.

We get an awful lot of blue moons here.

  > The proper thing to do (and what we _have_ done) is to say
  > "unloading of modules is not supported".

Wouldn't it be better to say "unloading of modules is currently
discouraged because we haven't _yet_ solved the problems related to
unloading modules".

  > But it basically boils down to: don't think of module unload as a "normal
  > event". It isn't. Getting it truly right is (a) too painful and (b) would
  > be too slow, so we're not even going to try.

Now there's a cop out if ever I saw one.  Surely, Linus, you've
overcome _much_ bigger problems than this at different times.  Just
because the only solutions that have been thought of so far are hard
to implement, are too inefficient, and aren't very safe doesn't mean
you should give up.  It just means that you need a different
solution. 

  > (As an example of "too painful, too slow", think of something like a 
  > packet filter module.

See my examples above.



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

iEYEABECAAYFAkAUTYcACgkQHSfbS6lLMAPdRgCgzMUDKcLVGEin5+GZjoezPqHx
bMYAnj7m+Jw8a8ofoOjFODdMbS4qD6w9
=dAJv
-----END PGP SIGNATURE-----
--=-=-=--
