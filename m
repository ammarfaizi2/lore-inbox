Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWFRN05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWFRN05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWFRN04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:26:56 -0400
Received: from hosting-agency.de ([194.145.226.10]:49033 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S932222AbWFRN04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:26:56 -0400
From: Simon Raffeiner <sturmflut@lieberbiber.de>
Reply-To: sturmflut@lieberbiber.de
Organization: Lieberbiber, Inc.
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding memory maps
Date: Sun, 18 Jun 2006 15:25:35 +0200
User-Agent: KMail/1.9.3
References: <200606171614.58610.sturmflut@lieberbiber.de> <20060617215818.7bc728af.rdunlap@xenotime.net> <20060617225813.1f0fbe15.akpm@osdl.org>
In-Reply-To: <20060617225813.1f0fbe15.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2806721.4ZgOjkFUAu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606181525.42199.sturmflut@lieberbiber.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2806721.4ZgOjkFUAu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag, 18. Juni 2006 07:58 schrieben Sie:
> On Sat, 17 Jun 2006 21:58:18 -0700
>
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > On Sat, 17 Jun 2006 16:14:52 +0200 Simon Raffeiner wrote:
> > > When compiling 2.6.17-rc6-mm2 (which contains this patch) my gcc 4.0.3
> > > (Ubuntu 4.0.3-1ubuntu5) complains about "int len;" being used
> > > uninitialized in print_vma(). AFAICS len is not initialized and then
> > > passed to
> > > pad_len_spaces(int len), which uses it for some calculations.
> > >
> > > I also noticed that similar code is used in fs/proc/task_mmu.c, where
> > > show_map_internal() passes an uninitialised int len; to
> > > pad_len_spaces(struct seq_file *m, int len).
> >
> > Ack both of those.  And both of them pass &len as a parameter to
> > printk/seq_printf where it looks as though they want just <len>
> > (after it has been initialized).
>
> printk("%n", &len) will initialise `len'.  gcc is being wrong again.

pad_len_spaces() is called in the following way:


static int print_vma(struct vm_area_struct *vma)
{
	int len;

	(...)

	pad_len_spaces(len);

	(...)


and is defined as:


static void pad_len_spaces(int len)
{
       len =3D 25 + sizeof(void*) * 6 - len;

       if (len < 1)
               len =3D 1;

       printk("%*c", len, ' ');
}


len is passed to pad_len_spaces() without initialization and is used for=20
calculations BEFORE printk() is called.

=2D-=20
OpenPGP/GnuPG Key: 0xB2204FA0 @ subkeys.pgp.net

"There is no point in having Linux on the Desktop if it's at the cost of it=
=20
being the same crap that Windows is."
  - Benjamin Herrenschmidt

--nextPart2806721.4ZgOjkFUAu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBElVRWd2q78rIgT6ARAs99AJ9L3yvuv8HLHH0ej9n9pRV1v5BlQwCfR115
sVfxCJQVazyxSyEL6VmQ/ss=
=T1Wx
-----END PGP SIGNATURE-----

--nextPart2806721.4ZgOjkFUAu--
