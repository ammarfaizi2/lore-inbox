Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317543AbSFKVNb>; Tue, 11 Jun 2002 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSFKVNa>; Tue, 11 Jun 2002 17:13:30 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:10970 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317543AbSFKVNa>;
	Tue, 11 Jun 2002 17:13:30 -0400
Date: Tue, 11 Jun 2002 14:13:30 -0700
To: Andi Kleen <ak@suse.de>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
Message-ID: <20020611141330.A22927@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020611134418.A22893@bougret.hpl.hp.com.suse.lists.linux.kernel> <p737kl5cyw1.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:02:22PM +0200, Andi Kleen wrote:
> 
> There used to be a reason for it (ask Alexey for details), but it has gone.
> It should be safe now to remove it I think.
> 
> -Andi

	Ok, so let's ask Alexey ;-)

	One potential reason is that some of the message may contain
data that is root only. But this should be handled with a finer
granularity.
	One example : in the Wireless Extensions, when the user set
the WEP key, a RTNetlink message is generated indicating a change of
stateon the interface. This netlink message doesn't contain the WEP
key itself, the app has to request the key explicitely (and at that
point we catch the fact that the app is root or not).
	If you really want to be clever, you could add a bit to the
netlink message to specify root only delivery (by the way of
netlink_broadcast()). In all cases, the data producer is the one that
knows what data is sensitive or not.
	But, as currently it doesn't seem that any netlink message
that contain sensitive data (my WEP stuff beeing the exception and
taken care of), we could just lift this restriction.

	Regards,

	Jean
