Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274918AbTHFICY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274920AbTHFICY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:02:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65088 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S274918AbTHFICQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:02:16 -0400
To: Werner Almesberger <werner@almesberger.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com>
	<3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net>
	<m1fzkiwnru.fsf@frodo.biederman.org>
	<20030804162433.L5798@almesberger.net>
	<m1u18wuinm.fsf@frodo.biederman.org>
	<20030806021304.E5798@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Aug 2003 01:58:56 -0600
In-Reply-To: <20030806021304.E5798@almesberger.net>
Message-ID: <m1llu7ushr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <werner@almesberger.net> writes:

> Eric W. Biederman wrote:
> > MPI is not a transport.  It an interface like the Berkeley sockets
> > layer.
> 
> Hmm, but doesn't it also unify transport semantics (i.e. chop
> TCP streams into messages), maybe add reliability to transports
> that don't have it, and provide addressing ? Okay, perhaps you
> wouldn't call this a transport in the OSI sense, but it still
> seems to have considerably more functionality than just
> providing an API.

Those are all features of the MPI implementation.  It is
not that MPI does not have an underlying transport.  MPI has
a lot of underlying transports.  And there is a different MPI
implementation for each transport.  Although a lot of them start
with a common base.
 
> > Mostly I think the that is less true, at least if they can stand the
> > process of severe code review and cleaning up their code.
> 
> Hmm, people putting dozens of millions into building clusters
> can't afford to have what is probably their most essential
> infrastructure code reviewed and cleaned up ? Oh dear.

Afford, they can do.  A lot of the users are researchers and
a lot of people doing the code are researchers.  So corralling
them up and getting production quality code can be a challenge,
or getting them to take small enough steps that they don't
frighten the rest of the world.

Plus ten million dollars pretty much buys you a spot in the top 10 of
the top 500 supercomputers.  The bulk of the clusters are a lot less
expensive than that.
 
> > But of course to get through the peer review process people need
> > to understand what they are doing.
> 
> A good point :-)
> 
> > So store and forward of packets in a 3 layer switch hierarchy, at 1.3 us
> > per copy.
> 
> But your switch could just do cut-through, no ? Or do they
> need to recompute checksums ?

Correct, switches can and generally do implement cut-through in that
kind of environment.  I was just showing that even at 10Gbps treating
a packet as an atomic unit has issues.  cut-through is necessary
to keep your latency down.  Do any ethernet switches do cut-through?
 
> > A lot of the NICs which are used for MPI tend to be smart for two
> > reasons.  1) So they can do source routing. 2) So they can safely
> > export some of their interface to user space, so in the fast path
> > they can bypass the kernel.
> 
> The second part could be interesting for TOE, too. Only that
> the interface exported would just be the socket interface.

Agreed.  

Eric
