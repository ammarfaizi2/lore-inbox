Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWIVVMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWIVVMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWIVVMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:12:13 -0400
Received: from calf.ext.ti.com ([198.47.26.144]:45287 "EHLO calf.ext.ti.com")
	by vger.kernel.org with ESMTP id S932116AbWIVVML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:12:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6DE8B.840C990A"
Subject: RE: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Fri, 22 Sep 2006 16:10:12 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507C2379D@dlee02.ent.ti.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Thread-Index: AcbehtTOMsPfSX2BS7OsvlonczT8FAAA72kA
From: "Woodruff, Richard" <r-woodruff2@ti.com>
To: "Scott E. Preece" <preece@motorola.com>, <pavel@ucw.cz>
Cc: <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Sep 2006 21:10:23.0011 (UTC) FILETIME=[846BB730:01C6DE8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DE8B.840C990A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

> I've been hoping somebody would send a good description of exactly
what
> they mean by "power domain" or "voltage domain", so we could talk
about
> it...
>=20
> scott

Here are a couple early mails which illustrate it a bit (sorry if they
mess up any ones mail reader).  I try an place a device inside of some
of the abstractions.

Regards,
Richard W.


------_=_NextPart_001_01C6DE8B.840C990A
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit

X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: PM framework
Date: Sun, 28 May 2006 09:55:50 -0500
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PM framework
Thread-Index: AcaB7OHV1GRn/ciZRyu6aCiDq4UQPAAch6og
From: "Woodruff, Richard" <r-woodruff2@ti.com>
To: "David Brownell" <david-b@pacbell.net>,
	"Gross, Mark" <mark.gross@intel.com>
Cc: "Rhoads, Rob" <rob.rhoads@intel.com>,
	<alb@google.com>,
	<amit.kucheria@nokia.com>,
	<mail@dominikbrodowski.de>,
	<k.stewart@freescale.com>,
	<matthew.a.locke@comcast.net>,
	<sampsa.fabritius@nokia.com>,
	"Sven-Thorsten Dietrich" <sven@mvista.com>,
	<ext-tuukka.tikkanen@nokia.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Mochel, Patrick" <patrick.mochel@intel.com>,
	<mochel@digitalimplant.org>,
	<toddpoynor@gmail.com>,
	<abelay@mit.edu>,
	"Griffiths, Richard" <Richard.Griffiths@windriver.com>,
	"Loeliger Jon-LOELIGER" <jdl@freescale.com>,
	"deVries, Alex" <Alex.deVries@windriver.com>,
	<dsingleton@mvista.com>,
	"Cai, Stanley" <stanley.cai@intel.com>

> > We want to
> > support multiple parents, and the notion of dependencies and
> > constraints. Is a core capability that is needed to accommodate the
> > hierarchical and overlapping areas of influence for clock and
voltage
> > domains.
>=20
> It supports reparenting, which is how I read "multiple parents".
> If that's not what you mean by "multiple parents", please give an
> example of what you mean.  As a rule, once a base clock is generated
> (say, by a PLL) it gets gated into children (and maybe subdivided).
>=20
> Dependencies of the parent/child type are explicit, while any others
> (as well as constraints, if any) are platform-specific.  And right
> now there's no generic code that needs to know about **either** ...

I need to do a little catch up reading...  I'm not sure this bit is
complete on target, but...

As far as clocks go a functional module can have multiple independent
clocks required for operation.  Say for MMC on OMAP2, the DPLL derived
clock might supply the interface clock, a fixed APLL might provide the
functional clock, and a 32KHz clock might provide denounce.  All clocks
are necessary for proper operation.  And in the case of OMAP2 all 3 are
controllable at the module level.

In a more general sense for a module's functional operation there may be
many dependencies.  This kind of thing goes beyond just clocks.  This
can be inter-driver, LCD needs I2C to turn on a backlight.

If you look at any block of functionality you create a 'driver' for
there can be a lot of external dependencies.  How to best express these
dependencies is where things get unclear.  Currently things like sysfs
and the clk_api handle part of them.  They are not complete. =20

It all gets less and less clear as you layer on more intra-soc-chip
levels.  A chip has multiple voltage domains (VD), within each VD there
are several power domains (PD), across several of the PDs (or fully
within a PD) there are multiple clock domains (CD).  Each domain level
has a number of sub levels with certain functionality states.  Finally
you drop the end module function say MMC into this.  Software writes a
single end driver for this which is likely part of some subsystem stack.
This functional block (say MMC) will be part of a VD, PD, multiple CD's
(each domain has multiple levels of operation).  To achieve power
management at the end module you get somewhat simple controls
(clk_enable), to achieve domain power controls, you must act on entire
groups with-in each domain type.  Domains are contained with-in domains
(VD contains PD) so in order to make a VD change all internal PD need to
be at a certain state, and for this to happen all CD in a PD need to be
in at a certain state.  For this to happen end functions (MMC) must have
each managed their end clocks and idles properly. =20

If you handle each layer from the bottom up, you can achieve massive
power savings.  There are many explicit relationships in this picture
which need to be expressed.  You can't look at devices individually and
get a domain state, you must look at them together.

OMAP1 which you are very familiar with does not provide this type of
domain partitioning nor the intermediate states (and control of each)
with in each domain.  You get much more of the whole chip in sleep
states, but not all the partial states which are useable during active
mode.

Regards,
Richard W.




------_=_NextPart_001_01C6DE8B.840C990A
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit

X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from dlee70.ent.ti.com ([157.170.170.61]) by dlee02.ent.ti.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 29 May 2006 10:26:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received: from dflp50.itg.ti.com ([128.247.22.99]) by dlee70.ent.ti.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 29 May 2006 10:26:20 -0500
Received: from brazos.ext.ti.com (localhost [127.0.0.1]) by dflp50.itg.ti.com (8.12.11/8.12.11) with ESMTP id k4TFQIXM001606 for <r-woodruff2@ti.com>; Mon, 29 May 2006 10:26:18 -0500 (CDT)
Received: from smtp106.sbc.mail.mud.yahoo.com (smtp106.sbc.mail.mud.yahoo.com [68.142.198.205]) by brazos.ext.ti.com (8.13.6/8.13.6) with SMTP id k4TFQDSd008421 for <r-woodruff2@ti.com>; Mon, 29 May 2006 10:26:18 -0500
Received: (qmail 19673 invoked from network); 29 May 2006 15:26:12 -0000
Received: from unknown (HELO ascent-enet) (david-b@pacbell.net@69.226.238.181 with plain)  by smtp106.sbc.mail.mud.yahoo.com with SMTP; 29 May 2006 15:26:12 -0000
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A505EAA46B@dlee02.ent.ti.com>
Content-class: urn:content-classes:message
Subject: Re: PM framework
Date: Mon, 29 May 2006 10:20:48 -0500
Message-ID: <200605290820.51778.david-b@pacbell.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PM framework
Thread-Index: AcaDNDzIJh5jcgb4RFG7f5U9tV5YHQ==
X-Message-Flag: Follow up
X-Message-Completed: Tue, 30 May 2006 12:12:00 -0500
References: <EA12F909C0431D458B9D18A176BEE4A505EAA46B@dlee02.ent.ti.com>
From: "David Brownell" <david-b@pacbell.net>
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Gross, Mark" <mark.gross@intel.com>,
	"Rhoads, Rob" <rob.rhoads@intel.com>,
	<alb@google.com>,
	<amit.kucheria@nokia.com>,
	<mail@dominikbrodowski.de>,
	<k.stewart@freescale.com>,
	<matthew.a.locke@comcast.net>,
	<sampsa.fabritius@nokia.com>,
	"Sven-Thorsten Dietrich" <sven@mvista.com>,
	<ext-tuukka.tikkanen@nokia.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Mochel, Patrick" <patrick.mochel@intel.com>,
	<mochel@digitalimplant.org>,
	<toddpoynor@gmail.com>,
	<abelay@mit.edu>,
	"Griffiths, Richard" <Richard.Griffiths@windriver.com>,
	"Loeliger Jon-LOELIGER" <jdl@freescale.com>,
	"deVries, Alex" <Alex.deVries@windriver.com>,
	<dsingleton@mvista.com>,
	"Cai, Stanley" <stanley.cai@intel.com>

On Sunday 28 May 2006 7:55 am, Woodruff, Richard wrote:

> I need to do a little catch up reading...  I'm not sure this bit is
> complete on target, but...

In terms of explaining clock, power, and voltage domains I think it's a
good explanation, likely worth putting into the framework writeup.  The
concepts apply both within chips and across larger systems (like =
boards),
but they're not always apparent to folks who don't build computers that
run for a long time on itty bitty batteries.  ;)

Plus it didn't disagree with that point I was making:  the clock API has
no major issues handling some of the most complex real-world clock trees
that Linux deals with today, except the missing clk_must_disable() call.


> As far as clocks go a functional module can have multiple independent
> clocks required for operation.  Say for MMC on OMAP2, the DPLL derived
> clock might supply the interface clock, a fixed APLL might provide the
> functional clock, and a 32KHz clock might provide denounce.  All =
clocks
> are necessary for proper operation.  And in the case of OMAP2 all 3 =
are
> controllable at the module level.

And I'm sure Intel and Freescale can come up with similar examples using
their own most power-efficient chips:  devices that use multiple clock
domains, each clock having a single parent.


> In a more general sense for a module's functional operation there may =
be
> many dependencies.  This kind of thing goes beyond just clocks.  This
> can be inter-driver, LCD needs I2C to turn on a backlight.
>=20
> If you look at any block of functionality you create a 'driver' for
> there can be a lot of external dependencies.  How to best express =
these
> dependencies is where things get unclear.  Currently things like sysfs
> and the clk_api handle part of them.  They are not complete. =20

Well, sysfs is just a way to present kernel data structures, emphasis
currently being on device and driver related information.  Using that
kobject framework also helps solve some memory management nightmares.

One example of something that's missing would be an entity explicitly
representing a power or voltage domain.  While "struct clk" exposes
clock (sub)domains so drivers can work with them, and associates them
with device model tree nodes (which tend to reflect bus hierarchies not
power or clock hierarchies...) the corresponding notions for switching
power domains on/off/higher/lower are platform-specific rarities.
Any driver needing to use one adds lots of platform-specific code...
which is contrary to the goal of maintainability.


> It all gets less and less clear as you layer on more intra-soc-chip
> levels.  A chip has multiple voltage domains (VD), within each VD =
there
> are several power domains (PD), across several of the PDs (or fully
> within a PD) there are multiple clock domains (CD).  Each domain level
> has a number of sub levels with certain functionality states.  Finally
> you drop the end module function say MMC into this.  Software writes a
> single end driver for this which is likely part of some subsystem =
stack.
> This functional block (say MMC) will be part of a VD, PD, multiple =
CD's
> (each domain has multiple levels of operation).  To achieve power
> management at the end module you get somewhat simple controls
> (clk_enable), to achieve domain power controls, you must act on entire
> groups with-in each domain type.  Domains are contained with-in =
domains
> (VD contains PD) so in order to make a VD change all internal PD need =
to
> be at a certain state, and for this to happen all CD in a PD need to =
be
> in at a certain state.  For this to happen end functions (MMC) must =
have
> each managed their end clocks and idles properly. =20

Most of that also applies at the board integration level.  MMC is a good
example to build on here, because "supply 1.8V to slot 2" is likely to
have a variety of board-specific implementations, and a given MMC card
might well need a voltage that is not currently available.


> If you handle each layer from the bottom up, you can achieve massive
> power savings.  There are many explicit relationships in this picture
> which need to be expressed.  You can't look at devices individually =
and
> get a domain state, you must look at them together.

Does "need to be expressed" need to be much more than "here's the
API that drivers use"?  That is, what's the point of expressing
that stuff?  It's easy to understand "writing power-aware drivers".
Also "monitoring power-aware systems".  Neither of those goals would
seem to need much in terms of infrastructure, beyond adopting some
lightweight APIs, analagous to the current clock API.


> OMAP1 which you are very familiar with does not provide this type of
> domain partitioning nor the intermediate states (and control of each)
> with in each domain.  You get much more of the whole chip in sleep
> states, but not all the partial states which are useable during active
> mode.

So who defines the states a given Linux system will use ... in terms
of the scope this new "framework" will address?

SOC/chip vendor docs more or less define what the SOC is expected to =
handle.=20
Board designers add to that, including constraints that reduce scope, as
does that platform's Linux support.  The application software layer(s) =
do
the same.  And most end users won't care about many of the details.

- Dave


------_=_NextPart_001_01C6DE8B.840C990A--
