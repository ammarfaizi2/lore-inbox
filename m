Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbUCCFnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUCCFnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:43:14 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:39298 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262371AbUCCFnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:43:11 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Date: Wed, 3 Mar 2004 11:13:02 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040302213901.GF20227@smtp.west.cox.net> <20040302230018.GL20227@smtp.west.cox.net> <40451CCA.4070907@mvista.com>
In-Reply-To: <40451CCA.4070907@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031113.02822.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2004 5:16 am, George Anzinger wrote:
> Tom Rini wrote:
> > On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
> >>Hi!
> >>
> >>>>Tom Rini wrote:
> >>>>>Hello.  The following interdiff kills kgdb_serial in favor of function
> >>>>>names.  This only adds a weak function for kgdb_flush_io, and
> >>>>> documents when it would need to be provided.
> >>>>
> >>>>It looks like you are also dumping any notion of building a kernel that
> >>>> can choose which method of communication to use for kgdb at run time. 
> >>>> Is this so?
> >>>
> >>>Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> >>>you try and allow for any 2 of 3 methods.
> >>
> >>I do not think that having kgdb_serial is so ugly. Are there any other
> >>uglyness associated with that?
> >
> > More precisely:
> > http://lkml.org/lkml/2004/2/11/224
>
> Andrew seems to be comming from the point of view of a developer rather
> than a developer/ maintainer.
>
> So, the counter argument is the user who is sending the thing into the
> field and wants to send just one binary kernel to all locations.  But then
> he needs to debug some problem that will work fine over the lan and later
> one that requires an early connection which the lan can not, as yet, do.  I
> agree that for you or me, this is not an issue, but what of the IT folks...

This is the same reason specifying 8250 parameters on a kernel command line is 
good. If one builds a different kernel for each test machine, fixing kgdb 
interface parameters during a build doesn't cause any problems. I don't think 
compiling different kernels is good when you have more than 2 machines (of 
same architecture). It's much easier to build a single kernel with drivers 
required by all of them and then boot them with kgdb as and when required 
with interface parameters coming from grug.conf (or equivalent on other 
archs).

kgdb_serial isn't ugly. It's just a function switch, similar to several of 
them in the kernel. ppc is ugly, but that's anyway the case because of so 
many varieties of ppc. If we are trying to make ppc code clean, it makes more 
sense to move this weak function thing into ppc specific files IMHO.

-Amit


>
> As to KGDB_MORE and KGDB_OPTIONS, they were put in for those who want to
> change the "O" option.  I feel it should NOT be changed, but I recognize
> that some folks want to reduce the optimizer distortions.  I opted for a
> generalized capability to cover all bases...
>
> KGDB_TS is for code developers.  I invented it to give a poor mans LTT and
> it has served me well.  I am not sure we need to be able to turn it off,
> however.
>
> The stack overflow thing is, I think, now in the kernel AND I have never
> had a machine behave so badly that it actually caught one.  It can go.

