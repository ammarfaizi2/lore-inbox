Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbSJ1Hli>; Mon, 28 Oct 2002 02:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbSJ1Hli>; Mon, 28 Oct 2002 02:41:38 -0500
Received: from marc1.theaimsgroup.com ([63.238.77.171]:43019 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S263016AbSJ1Hlf>; Mon, 28 Oct 2002 02:41:35 -0500
Date: Mon, 28 Oct 2002 02:49:25 -0500 (EST)
From: hlein@progressive-comp.com
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ARGH!  (Is there an HTML archive for linux-kernel that patches
 work from?)
In-Reply-To: <200210271945.20084.landley@trommello.org>
Message-ID: <010210280207090.19866-100000@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 27 Oct 2002, Rob Landley wrote:

> On Sunday 27 October 2002 22:34, Hank Leininger wrote:
> > Also, I'm interested in any corner cases where the attachment-parser messes
> > up--most of all when it fails to make attachments properly downloadable,
> > but also, to a lesser extent, any predictably readable mime-type, encoding,
> > etc which it currently doesn't try to print in-line, but could.
>
> This one went totally bonkers, but the post it was embedded in could have been
> too long:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103559201620433&q=p3

Hm.  Actually I think the only problem with this is a browser issue.
[ But not any more, see below. ]  That attachment is named
"linux-2.4.20-pre9-agp3.patch.gz".  Netscape (at least) has absolutely
idiotic behavior when downloading .gz files: it will strip the .gz
extension, but not decompress the file!  So when I use Netscape to save
the above, I get:

- -rw-r--r--    1 hlein    users        7023 Oct 28 02:06 linux-2.4.20-pre9-agp3.patch

Which is a bunch of binary crap.  But 'file' realizes it's compressed:

$ file linux-2.4.20-pre9-agp3.patch
linux-2.4.20-pre9-agp3.patch: gzip compressed data, deflated, original filename, `linux-2.4.20-pre9-agp3.patch', last modified: Thu Oct 24 19:09:39 2002, os: Unix

And if you rename it to put the .gz back on, and/or gunzip -c it, you
should get what looks like a proper diff file.  (I don't know a way for
a server to override this behavior; if anyone does, please contact me
off-list.)

Hm.  OTOH, I just tested that with Konqueror (v 3.mumble) and it
segfaults trying to download it.  Bad.

[tests]

OK.  I was basically reproducing the Content-Disposition header from the
mail, which contains a filename hint.  In an email it looks like:

Content-Disposition: attachment; filename="linux-2.4.20-pre9-agp3.patch.gz"

Netscape and at least some other browsers eat that just fine (and take
the filename hint).  Konqueror segfaults.  If I remove that header, it's
fine, but then there's no filename hint.  If I s/attachment;// then
Konqueror doesn't segfault.  Netscape 4.8 and MSIE 6sp1 both still grok
the filename hint.  Konqueror's handling of the filename hint seems
inconsistent (sometimes doesn't work at all; sometimes thinks the
closing double quote is part of the filename).  Still investigating.
But this is better than before, so just committed that change.

I'll file a bug report on Konqueror (the header was admittedly bogus
before, but it shouldn't have caused a SEGV), and try to figure out how
to get filename hints working better for Konq as well.

> linux-kernel mailing list blurb was at the end of them.  The penultimate list
> will be posted in a few minutes, just trying to catch up on linux-kernel
> first to see if I missed anything.

If these mails don't cross each other, please check if you can if the
other cases you've seen are similar to the above.

Thanks,

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQE9vOwMIvjvEYYapvERAhZwAJ4pNssBzCb5rRnt3A9t3hDp0od6FwCffStm
cUM7WhDPAGdaQSgyNecGMU0=
=6Z+U
-----END PGP SIGNATURE-----


