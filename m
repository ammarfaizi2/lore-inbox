Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287148AbSAaAb0>; Wed, 30 Jan 2002 19:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSAaAbP>; Wed, 30 Jan 2002 19:31:15 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:33284 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287148AbSAaAbA>;
	Wed, 30 Jan 2002 19:31:00 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15448.36800.86321.115729@argo.ozlabs.ibm.com>
Date: Thu, 31 Jan 2002 11:28:48 +1100 (EST)
To: Larry McVoy <lm@bitmover.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130081134.F18381@work.bitmover.com>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin>
	<Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
	<20020130154233.GK25973@opus.bloom.county>
	<20020130080308.D18381@work.bitmover.com>
	<20020130160707.GL25973@opus.bloom.county>
	<20020130081134.F18381@work.bitmover.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:

> On Wed, Jan 30, 2002 at 09:07:07AM -0700, Tom Rini wrote:
> > Then how do we do this in the bk trees period?  To give a concrete
> > example, I want to move arch/ppc/platforms/prpmc750_setup.c from
> > 2_4_devel into 2_4, without loosing history.  How?  And just this file
> > and not all of _devel.
> 
> That question doesn't parse.  There are multiple ways you can do it but 
> once you do patches will no longer import cleanly from Linus.  The whole
> point of the pristine tree is to give yourself a tree into which you can
> import Linus patches.  If you start putting extra stuff in there you will
> get patch rejects.

I think there is a misunderstanding here: we actually have 3 trees:

linux_2_4		"pristine" tree, identical to Marcelo's latest
linuxppc_2_4		"stable" tree, stuff we are pushing to Marcelo
linuxppc_2_4_devel	"devel" tree, bleeding edge stuff

Normally linuxppc_2_4 pulls from linux_2_4 and linuxppc_2_4_devel
pulls from linuxppc_2_4.  That is, linuxppc_2_4_devel has all of the
changesets that are in linuxppc_2_4, and more.  When Marcelo does a
new release the changes go into linux_2_4 and propagate from there
into linuxppc_2_4 and then linuxppc_2_4_devel.

Now when we decide that some stuff in linuxppc_2_4_devel has matured
to the point where we want it in linuxppc_2_4, what we currently do,
conceptually at least, is to generate a patch with the changes we want
and apply that to the linuxppc_2_4 tree.  If we had the ability to
apply changesets out-of-order, presumably what we could do is to push
the particular changesets of interest from linuxppc_2_4_devel back up
into linuxppc_2_4.  Then when we pulled from linuxppc_2_4 into
linuxppc_2_4_devel, bk would presumably say "got that one already"
about those changesets.

At the moment the process of applying a patch to linuxppc_2_4 and
doing the pull into linuxppc_2_4_devel results in conflicts which bk
mostly handles automatically *except* in the cases where the patch
creates new files.

Paul.
