Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbTCRQBt>; Tue, 18 Mar 2003 11:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262507AbTCRQBt>; Tue, 18 Mar 2003 11:01:49 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:16035 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262506AbTCRQBs>; Tue, 18 Mar 2003 11:01:48 -0500
Message-Id: <200303181611.h2IGBsGi018064@locutus.cmf.nrl.navy.mil>
To: Till Immanuel Patzschke <tip@inw.de>
cc: Mitchell Blank Jr <mitch@sfgoth.com>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] first pass at fixing atm spinlock 
In-reply-to: Your message of "Mon, 17 Mar 2003 17:13:38 PST."
             <3E7672C2.635C7D58@inw.de> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 18 Mar 2003 11:11:54 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>good job, cleaning the ATM stuff up -- on the note below: I've been having lot
>problems w/ the close and "dangeling" vccs, since in my scenarios traffic was
>coming in AFTER the close.  I tried to defer the destruction and it got rid of

what driver are you using?  this seem like wrong behavior imho.  the first
part of close should stop the card from delivering anymore traffic on the
particular vpi/vci.  close should return after it is certain that no more
traffic will arrive on said vpi/vci pair.

>Anyway, how about re-doing the VCC stuff mor in the way you did it for the
>HE device driver - having an array, indexed by a pvc hash -- and one could eas

almost all the drivers walk the vcc list trying to find a vpi/vci pair.  
enough that there should be a real lookup that is hashed.  however,
some drivers (like the nicstar) keep an indexed array of vpi/vcc pointing
to the approriate vcc.

>BTW: Have you addressed the difficulty that, depending on the ATM board, some
>packet receives are handled while still in the IRQ and others (the newer/bette
>ones always go through a tasklet?

that's really up the driver authors.  convince the author to change to a
tasklet.  change it yourself.  it shouldnt be too difficult in most cases.
