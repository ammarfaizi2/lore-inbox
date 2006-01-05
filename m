Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWAEMXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWAEMXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWAEMXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:23:30 -0500
Received: from gate.perex.cz ([85.132.177.35]:25009 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751855AbWAEMX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:23:29 -0500
Date: Thu, 5 Jan 2006 13:23:23 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-200087672-1136463803=:10350"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-200087672-1136463803=:10350
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Jan 2006, Tomasz K=B3oczko wrote:

> On Wed, 4 Jan 2006, Jaroslav Kysela wrote:

> > Well, the ALSA primary goal is to be the complete HAL not hidding the
> > extra hardware capabilities to applications. So API might look a bit
> > complicated for the first glance, but the ALSA interface code for simpl=
e
> > applications is not so big, isn't?
>=20
> Sorry Jaroslav byt this not unix way.
> Wny applications myst know anything about hardware layer ?
> In unix way all this details are rolled on kernel layer.

It means that you are saying that kernel should be bigger and bigger.
Please, see the graphics APIs. Why we have X servers in user space (and
only some supporting code is in the kernel) then? It's because if we=20
would move everything into kernel it will be even more bloated. The kernel=
=20
should do really the basic things like direct hardware access, DMA=20
transfer etc.

> > Also, note that app developers are not forced to use ALSA directly -=20
> > there is a lot of "portable" sound API libraries having an ALSA=20
> > backend doing this job quite effectively. We can add a simple (like=20
> > OSS) API layer into alsa-lib, but I'm not sure, if it's worth to do=20
> > it. Perhaps, adding some support functions for the easy PCM device=20
> > initialization might be a good idea.
>=20
> If we have so many "portable" sound API libraries .. look most of them=20
> uses the same way for handle sound on kernel interaction. Is this=20
> complicated ALSA way is realy neccessary ? For example .. jackd can use=
=20
> OSS API for handle sound device.

The grounds of ALSA APIs are not complicated. The complicated are the=20
extra features (like stream linking) which can be included conditionaly.=20
Note that during API development, mostly users requesting extra features=20
were speak loudly, others were only watching.

We know that the reduction requests have points for embedded systems etc.
And we will definitely try to sort "real-core" and "extra" things.

Also, note that if OSS used a library to access to sound devices, we won't=
=20
ever have such problems with the OSS API redirection to another API.
I already created a prototype of OSS API redirector (part of alsa-oss=20
package), see:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-oss/oss-redir/README?rev=3D=
1.1&view=3Dmarkup
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-oss/oss-redir/oss-redir.h?r=
ev=3D1.6&view=3Dmarkup
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-oss/oss-redir/oss-redir.c?r=
ev=3D1.9&view=3Dmarkup

But it's a question, if OSS application developers take this proposal.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
--8323584-200087672-1136463803=:10350--
