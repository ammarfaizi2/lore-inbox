Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030674AbWF0HCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030674AbWF0HCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030675AbWF0HCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:02:53 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5557 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1030674AbWF0HCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:02:52 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Suspend2][ 0/2] Cryptoapi deflate fix.
Date: Tue, 27 Jun 2006 17:02:46 +1000
User-Agent: KMail/1.9.1
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
References: <E1Fv6cg-000617-00@gondolin.me.apana.org.au>
In-Reply-To: <E1Fv6cg-000617-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4793537.XlzWIs92rS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271702.49408.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4793537.XlzWIs92rS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 16:00, Herbert Xu wrote:
> Nigel Cunningham <nigel@suspend2.net> wrote:
> > Sorry for the bad choice of heading. I have posted this before and
> > emailed it direct to Herbert, but he (rightly) doesn't see the need whi=
le
> > suspend2 isn't merged.
>
> Hmm, I don't recall ever telling you that.

Ok. Sorry for my wonky memory then :)

> I searched through my mail archive here is what I said to you last year
> on these two patches.  As far as I can see I don't have a reply from you
> on either subject.  So if you could reply to my questions below then I
> can consider your patches again.
>
> 1. Deflate fix:
> > > Hi Nigel, I need a bit more information about this patch.
> > > Do you have a specific input stream that requires a fix like
> > > this?
> >
> > Yes, Suspend2 if the user selects deflate as their compressor. The
> > output data will be PAGE_SIZE chunks, but deflate sometimes thinks it
> > has an extra byte to give us back.
>
> Are you saying that you're feeding it PAGE_SIZE chunks and it's
> giving you back something bigger than a page? That is expected
> since the nature of compression in general is that not everything
> is compressible.  Data streams which are not compressible will
> end up bigger than what you start with.
>
> What would be a bug is if you feed it something that's
> deflateBound^-1(PAGE_SIZE) bytes long and it spits back
> something that's longer than a page.

Yes, I'm always feeding it PAGE_SIZE chunks and compressing each page=20
separately. It's a long time since I looked at or thought about this, so I'=
ll=20
spend some more time getting it fresh in my head if you like.

> > I agree that it's ugly and don't recall using it when I had gzip support
> > in an earlier version of Suspend2. Are you thinking there might be a
> > better way? If so, I can dig out the old (non crypto api) code.
>
> Well if you could give me a snippet of code that actually uses this
> stuff to compress pages then I might have a better idea of what it's
> trying to do.
>
> 2. LZF:
> > +static int lzf_compress_init(void *context)
> > +{
> > +     struct lzf_ctx *ctx =3D (struct lzf_ctx *)context;
> > +
> > +     /* Get LZF ready to go */
> > +     ctx->hbuf =3D vmalloc_32((1 << hlog) * sizeof(char *));
>
> Any reason why vmalloc can't be used?

I just left Marc's original code as it was, so I'm not completely sure, but=
 I=20
guess it's because we want lowmem.

> > +     /* Allocate local buffer */
> > +     ctx->local_buffer =3D (char *)get_zeroed_page(GFP_ATOMIC);
> >
> > +     /* Allocate page buffer */
> > +     ctx->page_buffer =3D (char *)get_zeroed_page(GFP_ATOMIC);
>
> Where are these two buffers used anyway?

Page_buffer is the destination buffer passed to the compressor. Local buffe=
r=20
is used to buffer the output for writing (and vv).

> > +     if (!ctx->page_buffer) {
> > +             free_page((unsigned long)ctx->local_buffer);
> > +             lzf_compress_exit(ctx);
>
> This is a double-free of local_buffer.

Is that from our previous correspondence? I can't find anything like it now.

Regards,

Nigel

> Cheers,

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart4793537.XlzWIs92rS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoNgZN0y+n1M3mo0RAqcaAJ4wOpkH5b19wUcXMKy2YujHJseD/wCcDMk+
QWz1U8+TyyyT+Gl2lCgTqRM=
=xAbi
-----END PGP SIGNATURE-----

--nextPart4793537.XlzWIs92rS--
