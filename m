Return-Path: <linux-kernel-owner+w=401wt.eu-S1030227AbWLTSLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWLTSLV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWLTSLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:11:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41806 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030227AbWLTSLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:11:20 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Jiri Benc <jbenc@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20061220150009.1d697f15@griffin.suse.cz>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612191959.43019.david-b@pacbell.net>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <20061220150009.1d697f15@griffin.suse.cz>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 13:12:51 -0500
Message-Id: <1166638371.2798.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 15:00 +0100, Jiri Benc wrote:
> On Wed, 20 Dec 2006 12:53:14 +0000, Matthew Garrett wrote:
> > The situation is more complicated for wireless. Userspace expects to be 
> > able to get scan results from the card even if the interface is down.
> 
> User space should get an error when trying to get scan results from the
> interface that is down. Some drivers are broken and don't do this but
> when they're fixed there is no problem here.

Entirely correct.  If the card is DOWN, the radio should be off (both TX
& RX) and it should be in max power save mode.  If userspace expects to
be able to get the card to do _anything_ when it's down, that's just
110% wrong.  You can't get link events for many wired cards when they
are down, so I fail to see where userspace could expect to do anything
with a wireless card when it's down too.

> > In that case, I'm pretty sure we need a third state rather than just
> > "up" or "down".
> 
> We have that third state, it's IFF_DORMANT. Not supported yet by any
> wireless driver/stack, unfortunately.

So we have 3 states?  What purpose does DORMANT serve and what is
allowed in DORMANT?

Also, how does rfkill fit into this?  rfkill implies killing TX, but do
we have the granularity to still receive while the transmit paths are
powered down?

Dan

> Thanks,
> 
>  Jiri
> 

