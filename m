Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTCEQCo>; Wed, 5 Mar 2003 11:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbTCEQCo>; Wed, 5 Mar 2003 11:02:44 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:26847 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S267581AbTCEQCL>; Wed, 5 Mar 2003 11:02:11 -0500
Date: Wed, 5 Mar 2003 11:12:39 -0500
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Local APIC support interacting badly with cardbus/orinoco
Message-ID: <20030305161239.GA21465@delft.aura.cs.cmu.edu>
Mail-Followup-To: Mikael Pettersson <mikpe@user.it.uu.se>,
	Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
References: <20030305063801.GB25599@delft.aura.cs.cmu.edu> <15973.63728.763833.140185@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15973.63728.763833.140185@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:17:36PM +0100, Mikael Pettersson wrote:
> Jan Harkes writes:
>  > I've been tracing a problem where my wavelan card causes lockups on my
>  > thinkpad X20 laptop.
>  > Mar  4 23:42:55 mentor kernel: Local APIC disabled by BIOS -- reenabling.
>  > Mar  4 23:42:55 mentor kernel: Could not enable APIC!
>  > 
>  > Which made me think that the APIC code wasn't used, so I don't know how
>  > any changes in that area could be responsible for the cardbus/orinoco
>  > flakiness.
> 
> The message means that you have one of those mobile P6 processors
> where Intel actually removed the local APIC.
> (`grep flags /proc/cpuinfo` should not contain "apic" in your case.)

Correct, cpuinfo tells me it is a Pentium III (Coppermine), and the apic
flag is not net.

> So the local APIC really isn't being enabled or used, and any
> instability is caused by something else.
> 
> Please try 2.5.63 or .64 instead. Your 2.5.58/.59/.60 hybrid is
> getting old, and your mixing of stuff may itself cause problems.

2.5.57 - wavelan worked
2.5.58 - couldn't recognize the card
2.5.59 - Oops during boot when loading modules
2.5.60 - wavelan broken
2.5.61/62 - skipped these
2.5.63 - wavelan still broken

2.5.64 wasn't released yet, and noone seems to have reported a similar
problem. So I went back, trying 2.5.58 with enough patches from .59 that
it could load the card, and it worked. Then I tried 2.5.59 with just
enough patches to avoid the Oops during module loading and it didn't
work.

I am running 2.5.64 without Local APIC support and it seems to work.
I'll rebuild with Local APIC, which clearly shouldn't make a difference
because my CPU doesn't have one and see if the problem returns.

Jan

