Return-Path: <linux-kernel-owner+w=401wt.eu-S1030205AbWLTQk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWLTQk5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWLTQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:40:57 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3034 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030205AbWLTQk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:40:56 -0500
Date: Wed, 20 Dec 2006 17:40:54 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
Message-ID: <20061220164054.GA27938@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <1166621931.3365.1384.camel@laptopd505.fenrus.org> <20061220152701.GA22928@dspnet.fr.eu.org> <1166628858.3365.1425.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166628858.3365.1425.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 04:34:17PM +0100, Arjan van de Ven wrote:
> 5 seconds is unfair and unrealistic though. The *hardware* negotiation
> before link is seen can easily take upto 45 seconds already.
> That's a network topology/hardware issue (spanning tree fun) that
> software or even the hardware in your PC can do nothing about.

It's about ergonomics, not technical capabilities or fairness.


> this means that the "power up time" needs to be at least 45 seconds, if
> it's then down 5 seconds inbetween... that's not real power savings.

Then that means you can't have usable autodetection and power savings
at the same time.  That's a pefectly acceptable answer, you just have
to give the choice between the two to the user.  From the kernel
p.o.v, it just means that you probably need 3 modes:
1- active and exchanging packets

2- inactive but waiting for plugging and able to tell something is
   going on fast (like 0.5s fast)

3- powered off

and they probably already exist (UP+addr/procmisc. set, UP and DOWN).
And if the second mode can't be lower power than the first, that's
just life.  An hypothetical mode 4 identical to 2 without the "fast"
part is just not worth bothering with.

  OG.
