Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWBFOvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWBFOvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWBFOvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:51:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:29071 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932135AbWBFOvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:51:08 -0500
Date: Mon, 6 Feb 2006 08:51:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
Message-ID: <20060206145104.GB11887@sergelap.austin.ibm.com>
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <20060203140229.GA16266@ms2.inr.ac.ru> <43E38D40.3030003@fr.ibm.com> <20060206094843.GA6013@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206094843.GA6013@ms2.inr.ac.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Kuznetsov (kuznet@ms2.inr.ac.ru):
> > > 2. It is very inconvenient not to see processes inside VPS from host system.
> > > To do ps, strace, gdb etc. we have to move inside VPS. With VPID approach I can
> > > gdb even "init" process of VPS in a way invisible to VPS, see?
> > 
> > that's another container model issue again. your init process of a VPS
> > could be the real init. why do you need a fake one ? just trying to
> > understand all the issues you had to solve and I'm sure they are valid.
> 
> It is not a fake init, it is a real init. Main goal of openvz is to allow
> to start even f.e. the whole instance of stock redhat inside container
> including standard init. It is not a strict architectural requirement,
> but this option must be present.
> 
> BTW the question sounds strange. I would think that in (container, pid)
> approach among another limitations you get requirement that you _must_
> have a child reaper inside container. With VPIDs this does not matter,
> wait() made by parent inside host always returns global pid of child.
> But with (container, pid) children can be reaped only inside container, right?

Nah, we can just special-case the lookup for pid==1 to always return the
single real init, or insert the single real init into the pidhash for
every container.

If we're going to provide the option which you need to have your own
init, then I guess the best behavior is to add a flag to whatever
mechanism creates a container specifying to either hash the real init
into the pidhash, or make the first exec()d process the container's
init?  Does that seem reasonable?

thanks,
-serge
