Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVCDLAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVCDLAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVCDLAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:00:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64218 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262765AbVCDK6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:58:55 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303182820.46bd07a5.akpm@osdl.org>
References: <42268749.4010504@pobox.com>
	 <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
	 <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <1109894511.21781.73.camel@localhost.localdomain>
	 <20050303182820.46bd07a5.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109933804.26799.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 10:56:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 02:28, Andrew Morton wrote:
> > I would disagree, and I suspect anyone else who has maintained a distro
> > stable kernel would likewise. It needs one or more people who know who
> > to ask about stuff, are careful, have a good grounding in bug spotting,
> > races, common mistakes and know roughly how all the kernel works.
> > Maintainers aren't very good at it in general and they don't see
> > overlaps between areas very well.
> > 
> That is all inappropriate activity for a 2.6.x.y tree as it is being
> proposed.
> 
> Am I right?  All we're proposing here is a tree which has small fixups for
> reasonably serious problems.  Almost without exception it would consist of
> backports.

Almost without exception maintainers will forget the backport (there are
some notable exceptions). Almost without exception maintainers will not
be aware that their backport fix clashes with another fix because that
isn't their concern.

Linus will try and sneak stuff in that is security but not mentioned
which has to be dug out (because the bad guys read the patches too).

And finally Linus throws the occasional gem into the backporting mix
because he will (rightly) do the long term fix that rearranges a lot of
code when the .x.y patch needs to be the ugly band aid.

So for example Linus will happily changed remap_vm_area to fix a
security bug by changing the API entirely and making it do some other
things. Or in the case of the exec bug he did a fix that defaulted any
missed fixes to unsafe. Fine for upstream where the goal is cleanness,
bad for .x.y because the arch people hadn't caught up and did have
remaining holes.

You also have to review the dependancy tree for a backport and what was
tested - so I skipped the NFS df fix as one example as it had never been
tested standalone only on a pile of other NFS fixes.

Alan

