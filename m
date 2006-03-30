Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWC3Adw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWC3Adw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWC3Adv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:33:51 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:41887 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751301AbWC3Adv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:33:51 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Date: Thu, 30 Mar 2006 10:32:27 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
References: <20060329220808.GA1716@elf.ucw.cz> <200603300953.32298.ncunningham@cyclades.com> <20060329161258.A13186@unix-os.sc.intel.com>
In-Reply-To: <20060329161258.A13186@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1592196.Le3P8lMxlp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603301032.32862.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1592196.Le3P8lMxlp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 30 March 2006 10:12, Ashok Raj wrote:
> On Thu, Mar 30, 2006 at 09:53:26AM +1000, Nigel Cunningham wrote:
> > >  config SUSPEND_SMP
> > >         bool
> > > -       depends on HOTPLUG_CPU && X86 && PM
> > > +       depends on HOTPLUG_CPU && X86 && PM && X86_GENERICARCH
> > >         default y
> >
> > Sounds like the right approach to me, but I think it's better to use
> > selects. I reckon that if the user selects SMP and then selects suspend
> > support, everything else required should be automatic. If we do too many
> > 'depends on's, they have to mess about figuring out what they haven't
> > selected yet and why they can't find the option to suspend. Most people
> > don't seem to know about '/' in make menuconfig.
>
> I tried the same with HOTPLUG_CPU as well, to just say
>
> select X86_GENERICARCH
>
> but problem was this didnt enforce the selection, i.e user still could go
> and revert the selection made automatic for him, i.e go ahead and select
> X86_PC, and it would still leave the HOTPLUG_CPU=3Dy around. I thought
> "depends" sort of forces the selection.
>
> Maybe i didnt try correctly, if you have alternatives please do, actually
> even for HOTPLUG_CPU if this could be made automatic select, and at the
> same time enforced strictly, thats great.
>
> (for e.g i shoud;t be able to select X86_PC=3Dy and leave
> CONFIG_HOTPLUG_CPU=3Dy around)

I tried too, with the same results. It seems to me that the problem is that=
=20
Kconfig doesn't enforce select for choices in the same way that it does for=
=20
bools. Should this be filed as a bug with the Kconfig guys?

Regards,

Nigel

--nextPart1592196.Le3P8lMxlp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKycgN0y+n1M3mo0RAhqtAKCsM5Ya4rM/bymtHguEvNIn3tiUZQCcC0Rw
UjTbB0Pxi6Kc5zkVkHb5ptc=
=chkq
-----END PGP SIGNATURE-----

--nextPart1592196.Le3P8lMxlp--
