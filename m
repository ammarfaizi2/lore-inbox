Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290750AbSAYRl2>; Fri, 25 Jan 2002 12:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290749AbSAYRlT>; Fri, 25 Jan 2002 12:41:19 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:32987 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290750AbSAYRlN>; Fri, 25 Jan 2002 12:41:13 -0500
Date: Fri, 25 Jan 2002 12:41:10 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020125124110.A357@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201240858.g0O8wnH03603@bliss.uni-koblenz.de> <20020124121649.A7722@devserv.devel.redhat.com> <200201250728.g0P7SDH26738@bliss.uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201250728.g0P7SDH26738@bliss.uni-koblenz.de>; from krienke@uni-koblenz.de on Fri, Jan 25, 2002 at 08:28:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rainer Krienke <krienke@uni-koblenz.de>
> Date: Fri, 25 Jan 2002 08:28:13 +0100

> > Rainer, you missed the point. Nobody cares about small things
> > such as "cannot start nfsd" while your 4096 mounts patch
> > simply CORRUPTS YOUR DATA TO HELL.
> 
> Well I never said, I really knew what I was doing:-).  Thats exacly why I 
> asked about why to use more major devices? OK the anser to this question 
> seems to be that minor devices may only be 8 bit due to the static nature of 
> some kernel structures. Right?

Close enough... Actual reason is the implementation of MINOR().

> > If you need more than 1200 mounts, you have to add more majors
> > to my patch. There is a number of them between 115 and 198.
> > I suspect scalability problems may become evident
> > with this approach, but it will work.
> 
> The solution Richard posted seems to be interesting at this point isn't it?

I thought about the rgooch's suggestion, it sounds good for 2.5.
Red Hat do not ship devfs enabled currently, and I cannot use his
allocation function if someone uses static majors, or some modules
may not load. The patch does include a safety element (majorhog_xxx)
that reserves majors properly. The devfs would make that unnecessary.

-- Pete
