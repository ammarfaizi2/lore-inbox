Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAZOMU>; Fri, 26 Jan 2001 09:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAZOML>; Fri, 26 Jan 2001 09:12:11 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:10511 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129534AbRAZOL6>; Fri, 26 Jan 2001 09:11:58 -0500
Date: Fri, 26 Jan 2001 15:10:58 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126151058.A6331@pcep-jamie.cern.ch>
In-Reply-To: <14961.24658.319734.448248@pizda.ninka.net> <Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk> <14961.25754.449497.640325@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14961.25754.449497.640325@pizda.ninka.net>; from davem@redhat.com on Fri, Jan 26, 2001 at 03:50:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>  > Every single connection to ECN-broken sites would work as normal - it
>  > would just take an extra few seconds. Instead of "Hotmail doesn't
>  > work!" it becomes "Hrm... Hotmail is fscking slow, but Yahoo is fine. I'll
>  > use Yahoo". A few million of those, and suddenly Hotmail isn't so hot...
> 
> No, as explained in previous emails, no retry scheme can work.
> 
> Hotmails failing machines, for example, send RST packets back when
> they see ECN.  Ignoring valid TCP RST frames is unacceptable and
> Linux will not do that as long as I am maintaining it.

How about this for a deployment plan:

Ignore only _one_ RST frame (the first one), either per destination IP
address or per connection.  It's equivalent to a little "controlled"
network loss :-)

First SYN includes ECN.  Second and subsequent SYNs do not.

This won't provide the benefits of ECN on a heavily congested network,
but it is a start on a lightly congested one.  In a few months you can
flip the switch to stop ignoring RST frames and enable ECN on all SYNs.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
