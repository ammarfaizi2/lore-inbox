Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLGP13>; Thu, 7 Dec 2000 10:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLGP1K>; Thu, 7 Dec 2000 10:27:10 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:38409 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129257AbQLGP1H>; Thu, 7 Dec 2000 10:27:07 -0500
Date: Thu, 7 Dec 2000 17:09:12 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.21.0012071359210.970-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012071642300.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> > On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> > > On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> > > > Reserved fd's for superuser doesn't work.
> > > It does actually work,
> >
> > What do you mean under "work"? I meant user apps are able to
> > exhaust fd's completely and none is left for superuser.
>
> really? how did you manage to do that? On a 2.4.0-test12-pre7 system I

Just as you but I think you are testing on a margin condition [when
all file structure were already allocated], just reboot and try it
again. The failed logic is also clear from the kernel code [user
happily allocates when freelist < NR_RESERVED_FILES].

Note, I tested only 2.2 but 2.4 apparently also has the same bad
logic. Maybe with 2.4 you are also just lucky because of several other
reasons [e.g. kernel tries harder to keep freelist high and you also
have the fast enough box for it, etc].

> cannot reproduce the behaviour you describe. I.e. at least
> NR_RESERVED_FILES (which I agree with you should be increased!) are left
> to superuser processes whilst the user processes are denied.
>
> How exactly are you reproducing this? I wrote a simple while (1)
> {open("/dev/null", 0); } program and run many instances of it as user. At
> some stage user starts failing but superuser happily draws from the
> freelist. Of course, the superuser cannot start complex programs which
> require many descriptos but that is entirely the issues of

Well, about maybe 'dmesg' will work, not others for the current
default value (10). Note, the number of fd's aren't the *currently*
used one but apparently about all of them - even if they were closed
after the open - during the existence of the app [probably buffering
and maybe this changed in 2.4].

> NR_RESERVED_FILES being too small on which I totally agree with you.

Yep, with it's current value it's just a code decoration without any
gains.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
