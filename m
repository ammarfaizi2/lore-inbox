Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317476AbSFRQWX>; Tue, 18 Jun 2002 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317477AbSFRQWW>; Tue, 18 Jun 2002 12:22:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53973 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317476AbSFRQWU>; Tue, 18 Jun 2002 12:22:20 -0400
Date: Tue, 18 Jun 2002 11:22:21 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: James Bottomley <James.Bottomley@steeleye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: make dep fails on 2.5.22
In-Reply-To: <200206181550.g5IFoQ005746@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206181115180.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, James Bottomley wrote:

> It currently errors out for me with my NCR_D700 controller because 53c700.c 
> requires 53c700_d.h which is an automatically generated header file and thus 
> doesn't exist when make dep is run.
> 
> I can fix this by adding the rule:
> 
> $(MODVERDIR)/53c700.ver: 53c700_d.h
> 
> but this looks wrong.  The dependency is already listed in the existing rule:
> 
> 53c700.o: 53c700_d.h

Well, actually, it looks right to me: It says to build the .ver file, we
need the header (since it'll be included during the process).

It looks somewhat ugly, but I think it's one of the very few places where
something like this is needed.  Of course, if there was a way to tell make
"$(MODVERDIR)/%.ver has the same prequisites as %.o" that'd be nicer, but
there isn't AFAICT.

Another possibility would be to record these kind of explicit dependencies 
on generated files into variables, so Rules.make could do the right thing.

Something like

	53c700.o-needs := 53c700_d.h

But I'm not sure that's so much nicer.

--Kai

