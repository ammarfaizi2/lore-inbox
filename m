Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136311AbRECJn2>; Thu, 3 May 2001 05:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136314AbRECJnS>; Thu, 3 May 2001 05:43:18 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:9991 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136311AbRECJnF>;
	Thu, 3 May 2001 05:43:05 -0400
Date: Thu, 3 May 2001 05:43:49 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
Message-ID: <20010503054349.C28728@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alexander Viro <viro@math.psu.edu>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de> <Pine.GSO.4.21.0105030452310.15957-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0105030452310.15957-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, May 03, 2001 at 05:14:45AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu>:
> Assertion: you can split the set of variables into disjoint union of
> small subsets X, Y_1,...,Y_m such that each constraint is concerned
> only with variables from X and at most one of Y_i.
> 
> IOW, there is a small "core" and for fixed values of core variables
> constraints fall into groups, each dealing with its own _small_
> set of variables.
> 
> If that assertion is true the complexity is nowhere near 3^N.
> 
> Eric, you probably have the most accurate information about the
> existing constraints. Care to verify the assertion above? I'm
> serious - the set of constraints is very far from generic and
> if nothing else, such preprocessing (splitting variables into
> core and peripherial groups) can make life easier in other
> parts of the thing.

You're almost right.  If you counted only explicit constraints, 
created by require statements, you get a bunch of cliques that
aren't that large.

Unfortunately....there are a huge bunch of implicit constraints
created by dependency relationships in the menu tree.  For example,
all SCSI cards are dependents of the SCSI symbol.  Set SCSI to N
and all the card symbols get turned off; set any card symbol to Y or M
and the value of SCSI goes to Y or M correspondingly.

So the way it actually works (I think; I've have to write code to do a
topological analysis to be sure) out is that there's sort of a light
dust of atoms (BSD quota is one of them) surrounding one huge gnarly
menu-tree-shaped clique.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Strict gun laws are about as effective as strict drug laws...It pains
me to say this, but the NRA seems to be right: The cities and states
that have the toughest gun laws have the most murder and mayhem.
        -- Mike Royko, Chicago Tribune
