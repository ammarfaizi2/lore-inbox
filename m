Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRD1Kap>; Sat, 28 Apr 2001 06:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbRD1Kaf>; Sat, 28 Apr 2001 06:30:35 -0400
Received: from warande3094.warande.uu.nl ([131.211.123.94]:7530 "EHLO
	warande3094.warande.uu.nl") by vger.kernel.org with ESMTP
	id <S132822AbRD1KaW>; Sat, 28 Apr 2001 06:30:22 -0400
Date: Sat, 28 Apr 2001 10:23:56 +0200
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: #define HZ 1024 -- negative effects?
Message-ID: <20010428102355.A341@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.gh4u8sv.17i1q6@ifi.uio.no> <004f01c0cdf4$f17f4ce0$0701a8c0@morph>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <004f01c0cdf4$f17f4ce0$0701a8c0@morph>; from dmaas@dcine.com on Wed, Apr 25, 2001 at 10:02:26PM -0400
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2001 at 10:02:26PM -0400, Dan Maas wrote:

> > Are there any negative effects of editing include/asm/param.h to change
> > HZ from 100 to 1024? Or any other number? This has been suggested as a
> > way to improve the responsiveness of the GUI on a Linux system.
[...]
> Of course, the appearance of better interactivity could just be a placebo
> effect. Double-blind trials, anyone? =)

I tried HZ=1024 on my i386 kernel, to check two things. One was a timer
routine. The performance of the timer routine depends heavily on the
granularity of the nanosleep() or select() system call. Since those calls
always block at least 1/HZ seconds, the timer precision indeed increased by a
factor 10 when I changed the HZ value from 100 to 1024.

However, another thing I wanted to do was to generate profiling statistics for
freesci. Profiling is done with 1/HZ granularity. Any subroutine in a program
executed in less than 1/HZ cannot be profiled correctly (for example a routine
that executes in 1 nanosecond and one that needs 1/HZ/2 seconds both show up
as taking 1 sample).

Now, you would think that profiling would be a lot better with HZ=1024.
However, the program didn't even run anymore! The reason is that some system
calls are being interupted by SIGPROF every 1/HZ, and return something like
ERESTARTSYS to the libraries. The libraries then try to restart the system
call but a SIGPROF is bound to follow shortly, again interrupting the system
call, and so on...

-------------------------------------------
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>
-------------------------------------------
See also: http://tinc.nl.linux.org/
          http://www.kernelbench.org/
-------------------------------------------

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE66n4bAxLow12M2nsRAk5fAKCiMFnA9vpWvrTv5ETu3jByqzOU5ACeOf9X
H47az1jTJEmZc3hUziK2TCE=
=8TxM
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
