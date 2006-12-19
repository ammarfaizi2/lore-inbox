Return-Path: <linux-kernel-owner+w=401wt.eu-S1751667AbWLSNeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWLSNeL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 08:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWLSNeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 08:34:11 -0500
Received: from 1wt.eu ([62.212.114.60]:1588 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbWLSNeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 08:34:10 -0500
Date: Tue, 19 Dec 2006 14:32:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: "J.H." <warthog9@kernel.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20061219133256.GA19084@1wt.eu>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <45858B3A.5050804@oracle.com> <20061217223730.GW10054@mea-ext.zmailer.org> <1166402576.26330.81.camel@localhost.localdomain> <20061219064646.GJ24090@1wt.eu> <1166513991.26330.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166513991.26330.136.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 11:39:51PM -0800, J.H. wrote:
> > If the frontend machines are not taken off-line too often, it should
> > be no big deal for them to handle something such as LVS, and would
> > help spreding the load.
> 
> I'll have to look into it - but by and large the round robining tends to
> work.  Specifically as I am writing this the machines are both pushing
> right around 150mbps, however the load on zeus1 is 170 vs. zeus2's 4.
> Also when we peak the bandwidth we do use every last kb we can get our
> hands on, so doing any tunneling takes just that much bandwidth away
> from the total.

Indeed.

> 	Number of Processes running
> process		#1	#2
> ------------------------------------
> rsync		162	69
> http		734	642
> ftp		353	190
> 
> as a quick snapshot.  I would agree with HPA's recent statement - that
> people who are mirroring against kernel.org have probably hard coded the
> first machine into their scripts, combine that with a few dns servers
> that don't honor or deal with round robining and you have the extra load
> on the first machine vs. the second.

I've also already experienced I/O loads due to rsync. The most annoying
part certainly being that most of the connections see nothing new, but
the disks are seeked anyway, and the cache always gets trashed. A dirty
but probably efficient emergency workaround would be to randomly refuse
a few rsync connections on www1. It would make the mirroring tools fail
once in a while, and the data would be mirrored in larger batches, so
all in all, it would reduce the rate of useless disk seeks.

Since I suspect that the volume of data transferred by rsync is fairly
moderate, it might be interesting to load balance the rsync between the
two machines, even if that involves making the data transit via the net
twice. I can help setting up a reverse proxy setup if you want to give
a try to such a setup.

Best regards,
Willy

