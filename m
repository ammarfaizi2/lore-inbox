Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbRCBWUZ>; Fri, 2 Mar 2001 17:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129564AbRCBWUP>; Fri, 2 Mar 2001 17:20:15 -0500
Received: from colorfullife.com ([216.156.138.34]:5894 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129555AbRCBWUC>;
	Fri, 2 Mar 2001 17:20:02 -0500
Message-ID: <3AA01CAF.98726DEC@colorfullife.com>
Date: Fri, 02 Mar 2001 23:20:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: pat@isis.co.za, linux-kernel@vger.kernel.org, Alan@redhat.com,
        Donald Becker <becker@scyld.com>
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
In-Reply-To: <3A9A30C7.3C62E34@colorfullife.com> <3A9AB84C.A17D20AE@mandrakesoft.com> <3A9AC372.A86DC6C7@colorfullife.com> <3AA00D5A.44FA21D0@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Manfred Spraul wrote:
> > Could you double check the code in tulip_core.c, around line 1450?
> > IMHO it's bogus.
> >
> > 1) if the network card contains multiple mii's, then the the advertised
> > value of all mii's is changed to the advertised value of the first mii.
> 
> I'm really curious about this one myself.
> 
> Since I haven't digested all of the tulip media stuff in my brain yet,
> and since I'm not familiar with all the corner cases, I'm loathe to
> change the tulip media stuff without fully understanding what's going
> on.
> 
> If you have a single controller with multiple MII phys...  how does one
> select the phy of choice (for tulip, in the absence of SROM media
> table...)?

I'd choose the first one with a link partner.

> And once phy A has been selected out of N available as the
> active phy, should you care about the others at all?
>

Not until the link beat disappears.
Then scan all existing phy's and select the phy with a link beat as the
new active phy.

At least that's what the sis900.c driver does. Are there other linux
drivers that support multiple phy's?

--
	Manfred
