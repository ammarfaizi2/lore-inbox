Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136560AbRECKAi>; Thu, 3 May 2001 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136595AbRECKA3>; Thu, 3 May 2001 06:00:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9356 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136560AbRECKAR>;
	Thu, 3 May 2001 06:00:17 -0400
Date: Thu, 3 May 2001 06:00:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503054349.C28728@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0105030545470.15957-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 May 2001, Eric S. Raymond wrote:

> You're almost right.  If you counted only explicit constraints, 
> created by require statements, you get a bunch of cliques that
> aren't that large.
> 
> Unfortunately....there are a huge bunch of implicit constraints
> created by dependency relationships in the menu tree.  For example,
> all SCSI cards are dependents of the SCSI symbol.  Set SCSI to N
> and all the card symbols get turned off; set any card symbol to Y or M
> and the value of SCSI goes to Y or M correspondingly.
> 
> So the way it actually works (I think; I've have to write code to do a
> topological analysis to be sure) out is that there's sort of a light
> dust of atoms (BSD quota is one of them) surrounding one huge gnarly
> menu-tree-shaped clique.

Errrmmm... _That_ is not too horrible - e.g. SCSI definitely belongs
to core. Individual drivers, OTOH, do not and there's a lot of them.

I'm not talking about connectedness of the thing. However, I suspect that
graph has a small subset such that removing it makes it fall apart.

IOW, you have a small well-connected backbone and a lot of small groups
around it, such that each path from one group to another hits the
backbone. ACK? Picture you've described doesn't contradict that - there's
a relatively small number of symbols that correspond to subsystems and
tons of stuff hanging from that subset.

Look at it as a network. How many sites do you need to nuke to break it
into tiny bits?

