Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKARU6>; Wed, 1 Nov 2000 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129221AbQKARUt>; Wed, 1 Nov 2000 12:20:49 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:6929 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S129118AbQKARUl>; Wed, 1 Nov 2000 12:20:41 -0500
Date: Wed, 1 Nov 2000 17:13:21 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: matthew <matthew@mattshouse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Sluggish After Load
Message-ID: <20001101171321.A8815@bart.dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	matthew <matthew@mattshouse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20001101152629.B31394@bart.dev.sportingbet.com> <Pine.LNX.4.21.0011011107170.7127-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011011107170.7127-100000@localhost.localdomain>; from matthew@mattshouse.com on Wed, Nov 01, 2000 at 11:10:46AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 11:10:46AM -0600, matthew wrote:
> On Wed, 1 Nov 2000, Sean Hunter wrote:
> 
> > Pardon my speculations (if I am wrong), but isn't this an oracle question?  
> 
> 
> It could be.
> 
> 
> > Isn't oracle killing the server by trying to clean up 1800 connections all at
> > once?  When they're all connected, most of the work is done by one or two
> > oracle processes, but when you kill your ddos thing, all of the oracle
> > listeners (of which there is one per connection), steam in and try to clean up.
> 
> 
> Yes, but the factor that drove me to the list was that it's been > 400
> load average for 10 hours now.  Even if Oracle tried to clean up 1800
> connections at once, would it take this long?  That's not rhetorical, as
> the answer may well be "yes".
> 

Yup.  What seems to have happened is that waking up 1800 processes at once has
caused the box to thrash so hard it is taking ages for any one process to get
enough scheduler time to clean itself up and exit.

I guess we may need a thrash preventer that slows things down enough for each
process to get a healthy bite of the cherry.

Sean

> 
> > I thought oracle had an internal connection limit (on our servers it is set to
> > 440 connections), anyways.
> 
> 
> This is set in the init.ora.  I jacked it up to allow > 2000 connections.
> 
> Matthew
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
