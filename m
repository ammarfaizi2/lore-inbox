Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933231AbWKNEHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbWKNEHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 23:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933294AbWKNEHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 23:07:22 -0500
Received: from mx27.mail.ru ([194.67.23.64]:3899 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S933231AbWKNEHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 23:07:20 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Tue, 14 Nov 2006 07:07:13 +0300
User-Agent: KMail/1.9.5
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru> <1163455396.9482.38.camel@localhost> <20061113225818.GG2760@suse.de>
In-Reply-To: <20061113225818.GG2760@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140707.17935.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 14 November 2006 01:58, Stefan Seyfried wrote:
> On Mon, Nov 13, 2006 at 03:03:16PM -0700, Zan Lynx wrote:
> > I have not checked if this is true, but it is a possible explanation:
> >
> > Perhaps the filesystem is not properly unmounted during a suspend?  That
>
> Of course not.
>
> > would mean GRUB is reading from a incoherent filesystem on resume.
>
> Exactly.
>
> > GRUB's filesystem drivers are not very fancy.  It could be it does
> > something silly like check the journal before returning each block.
>
> GRUB must not write to the fs, so it probably plays back the journal in
> memory only and it does this for every file it reads (at least that's how
> it feels :-)
>

Ah, OK, that makes sense. I did not expect GRUB to be *that* sophisticated :)

> > Maybe its a journal size thing, you could try "sync" before suspend and
> > see if it helps.
>
> We already sync inside the kernel, it does not help here, though.
> Blockdev freezing might help.
>

is there patch applicable to vanilla kernel? After repairing reiser several 
times (due to hard lockups during suspend-to-RAM) that sounds even more 
interesting.

> > Another thing would be to create /boot as a separate partition.
>
> Yes, that's what i always advise: /boot on separate ext2 partition. Then
> GRUB resumes fast.

well, this is small system, using yet another partition looked like useless 
waste :)

thank you for explanation

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWUD1R6LMutpd94wRAtWFAJ92STsDVby88UUWmNVK1q41X96RXgCeN6o4
ilUTLBdKZPsWPkWi5LOKsbg=
=U1xV
-----END PGP SIGNATURE-----
