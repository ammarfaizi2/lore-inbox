Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUFXCPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUFXCPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 22:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUFXCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 22:15:31 -0400
Received: from holomorphy.com ([207.189.100.168]:63366 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263736AbUFXCP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 22:15:29 -0400
Date: Wed, 23 Jun 2004 19:15:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624021527.GQ1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624003249.GM1552@holomorphy.com> <20040623180722.69a8ea6f.akpm@osdl.org> <20040624012435.GN1552@holomorphy.com> <20040624015229.GP1552@holomorphy.com> <20040623190150.4a182cfc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623190150.4a182cfc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 07:01:50PM -0700, Andrew Morton wrote:
> Well let's see how the patch ends up looking.
> I have bad feelings about the overcommit logic - several times we have
> accidentally noticed (and fixed) gross inaccuracies in it, and I am sure
> others remain.
> I am not aware of anyone getting down and explicitly testing it in lots of
> different scenarios (including mlock), and perhaps it gets inaccurate when
> zone fallbacks are involved.
> If you're prepared to undertake that level of thinking and coverage testing
> and fix up the fallout, that would certainly be good.  If you think it's
> worth the effort, and, again, depending upon the performance and ickiness
> impact of the patches.

This has some importance to database users, as orderly shutdown of
userspace is required for data integrity there in a similar fashion as
it is for the kernel to undergo orderly shutdown so as not to corrupt
filesystems (in both cases, some pains are taken to recover from these
kinds of situations as best as possible, however, neither's recovery is
infallible). So OOM kills during client overloads are highly undesirable.
I'll take this as a more general directive to audit and clean up the
non-overcommit accounting, which I don't have an issue with taking on,
before moving on to refining the semantics.

I'll do this up as a series of small fixes and so on. mlock coverage is
a certainty given database usage patterns and my current position.


-- wli
