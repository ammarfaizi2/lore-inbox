Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264241AbRFLHun>; Tue, 12 Jun 2001 03:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264245AbRFLHud>; Tue, 12 Jun 2001 03:50:33 -0400
Received: from 196-41-175-253.citec.net ([196.41.175.253]:57540 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S264241AbRFLHuT>; Tue, 12 Jun 2001 03:50:19 -0400
Date: Tue, 12 Jun 2001 09:46:18 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010612094618.A4846@prism.co.za>
In-Reply-To: <Pine.LNX.4.33.0106111401270.6622-100000@druid.if.uj.edu.pl> <Pine.LNX.4.33.0106111603390.1742-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.33.0106111603390.1742-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, Jun 11, 2001 at 04:04:45PM -0300, Rik van Riel wrote:
> On Mon, 11 Jun 2001, Maciej Zenczykowski wrote:
> > On Fri, 8 Jun 2001, Pavel Machek wrote:
> >
> > > That modulo is likely slower than dereference.
> > >
> > > > +               if (count % 256 == 0) {
> >
> > You are forgetting that this case should be converted to and 255
> > or a plain byte reference by any optimizing compiler

You read too much into my choice - 256 is a random number ;)

> What matters is that this thing calls schedule() unconditionally
> every 256th time.  Checking current->need_resched will only call
> schedule if it is needed ... not only that, but it will also
> call schedule FASTER if it is needed.

I will try this later today, but it seems right enough.

generic_file_write seems to do enough other work that a dereference
vs. and-255 shouldn't be too bad...

Bernd Jendrissek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Jciz/FmLrNfLpjMRAmI9AKCm2EYziCzG0qrobFooGLf3kepb/wCbBQf6
nXmD/OZNhGttwQejZtYi3ic=
=rWL2
-----END PGP SIGNATURE-----
