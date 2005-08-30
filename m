Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbVH3QCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVH3QCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVH3QCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:02:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24994 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751447AbVH3QCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:02:21 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<1125413136.8276.14.camel@localhost.localdomain>
	<200508301650.23149.ak@suse.de>
	<17172.31726.480750.90360@alkaid.it.uu.se>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Aug 2005 10:01:40 -0600
In-Reply-To: <17172.31726.480750.90360@alkaid.it.uu.se> (Mikael Pettersson's
 message of "Tue, 30 Aug 2005 17:31:58 +0200")
Message-ID: <m1vf1npg63.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Andi Kleen writes:
>  > On Tuesday 30 August 2005 16:45, Alan Cox wrote:
>  > > On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
>  > > > ways.  Currently this code only allows for an additional flavor
>  > > > of uncached access to physical memory addresses which should be hard
>  > > > to abuse, and should raise no additional aliasing problems.  No
>  > > > attempt has been made to fix theoretical aliasing problems.
>  > >
>  > > Even an uncached/cached alias causes random memory corruption or an MCE
>  > > on x86 systems. In fact it can occur even for an alias not in theory
>  > > touched by the CPU if it happens to prefetch into or speculate the
>  > > address.
>  > >
>  > > Also be sure to read the PII Xeon errata - early PAT has a bug or two.
>  > 
>  > 
>  > We can always force cpu_has_pat == 0 on these machines.
>  > I don't think it is worth it to add any more complicated workarounds 
>  > for old broken systems.
>
> I don't have the spec updates in front of me, but I believe the PAT
> bug existed well into the P4 line. The workaround is simply to make
> the high 4 PAT entries identical to the low 4 entries. (But I confess
> to not having a clue as to whether it's still useful then or not.)

It is still useful even if that is the case.  Unless we need something
more than WC we don't have a need for anything else.  

If you could track down the reference you are thinking of I would
appreciate it.  According to the errata I can find simply not using
the high 4 entries is sufficient, to avoid the problem.

Eric


