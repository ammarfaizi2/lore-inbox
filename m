Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271872AbRH1Se1>; Tue, 28 Aug 2001 14:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271873AbRH1SeR>; Tue, 28 Aug 2001 14:34:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:36293 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S271872AbRH1SeC>;
	Tue, 28 Aug 2001 14:34:02 -0400
Date: Tue, 28 Aug 2001 11:34:18 -0700
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Multicast
Message-ID: <20010828113418.B8147@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010828111321.A8147@bougret.hpl.hp.com> <200108281830.f7SIUu928840@buggy.badula.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108281830.f7SIUu928840@buggy.badula.org>; from ionut@cs.columbia.edu on Tue, Aug 28, 2001 at 02:30:56PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 02:30:56PM -0400, Ion Badulescu wrote:
> On Tue, 28 Aug 2001 11:13:21 -0700, Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> 
> >        And finally, I tried :
> > ------------------------------------------
> > bind(sock, ONE_INTERFACE, MY_PORT);
> > ------------------------------------------
> >        First instance : Tx ok, doesn't Rx anything at all. I can
> > understand why, the Rx packet don't have a dest IP address matching
> > ONE_INTERFACE.
> 
> This is the correct approach, I think. Have you tried adding the two
> setsockopt() calls after the bind, or at the very least the
> IP_ADD_MEMBERSHIP one, to see if you can Rx?

	Hum, I thought it was obvious. I did mention only this call
because that's the only difference, but what I did was :
------------------------------------------
socket(AF_INET, SOCK_DGRAM, 0);
bind(sock, ONE_INTERFACE, MY_PORT);
setsockopt(IP_ADD_MEMBERSHIP, INADDR_ALLHOSTS_GROUP, ONE_INTERFACE);
setsockopt(IP_MULTICAST_IF, ONE_INTERFACE);
------------------------------------------
	And in this case, no Rx at all !

> Otherwise quite obviously
> your physical interface will not have the multicast MAC address added to
> its filters and no packets will reach the IP stack.
> 
> 'ip maddr ls' is a useful tool for inspecting what your NIC is letting
> through.

	I'll try that...

> Ion

	Jean
