Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291905AbSBASlV>; Fri, 1 Feb 2002 13:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291907AbSBASlM>; Fri, 1 Feb 2002 13:41:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291905AbSBASk6>; Fri, 1 Feb 2002 13:40:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Continuing /dev/random problems with 2.4
Date: 1 Feb 2002 10:40:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3enf3$93p$1@cesium.transmeta.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1012582401.813.1.camel@phantasy>
By author:    Robert Love <rml@tech9.net>
In newsgroup: linux.dev.kernel
>
> On Fri, 2002-02-01 at 04:17, Ken Brownfield wrote:
> 
> > Robert Love did some /dev/random maintenance a while back, and his
> > netdev patches are essential for low disk-activity systems.  While his
> > patches have helped the situation greatly, it appears that there is
> > something in the random code that can cause extraction of entropy to
> > permanently exhaust the pool.  Some kind of issue when entropy is near
> > zero at the time of a read?
> 
> Most of the useful fixes actually came in a large update from Andreas
> Dilger.  Perhaps he would have some insight, too.
> 
> Exhausting entropy to zero under high use is not uncommon (that is a
> motivation for my netdev-random patch).  What boggles me is why it does
> not regenerate?
> 

The kernel itself sometimes need randomness, and probably manages to
keep the enthropy pool completely drained.  Remember, /dev/random
means "don't give me anything unless you can promise it's fresh
entrophy."

Anything that is meant to be a server really pretty much needs an
enthropy generator these days.  We really should push vendors to
provide it (together with serial console firmware and other "well,
duh" things rackmount servers should have as a matter of course.)

Once you have software to assist you, meaning that you don't require
that every bit stepping off the wire is truly random, just a
predictable minimum, then building an RNG is a trivial number of
components -- although some care has to be taken in their assembly.
This means, IMO, that we should push on server motherboard
manufacturers more so than, for example, chipsets: although
integration tend to improve pervasiveness, ICs are awfully noisy
beasts.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
