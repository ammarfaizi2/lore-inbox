Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUH0Pmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUH0Pmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUH0PkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:40:03 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:55741 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266155AbUH0Pex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:34:53 -0400
Date: Fri, 27 Aug 2004 17:26:16 +0200
From: Roger Luethi <rl@hellgate.ch>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
Message-ID: <20040827152615.GA28531@k3.hellgate.ch>
Mail-Followup-To: James Morris <jmorris@redhat.com>,
	linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sourceforge.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
References: <20040827122412.GA20052@k3.hellgate.ch> <Xine.LNX.4.44.0408271043130.7393-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408271043130.7393-100000@thoron.boston.redhat.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 10:50:23 -0400, James Morris wrote:
> On Fri, 27 Aug 2004, Roger Luethi wrote:
> 
> > At the moment, the kernel sends a separate netlink message for every
> > process.
> 
> You should look at the way rtnetlink dumps large amounts of data to  
> userspace.

At this point, I am just using a working prototype to gauge the interest
in an improved interface. Other than that, I agree. This would be one
of the "speed optimizations I haven't tried".

> > I haven't implemented any form of access control. One possibility is
> > to use some of the reserved bits in the ID field to indicate access
> > restrictions to both kernel and user space (e.g. everyone, process owner,
> > root) 
> 
> So, user tools would all need to be privileged?  That sounds problematic.

It just means that not all the pieces that would be required to make
this a merge candidate have been implemented. I focused on the basic
infrastructure that is needed for the basic protocol.

Adding some access control that is about as smart as file permissions
in /proc is fairly easy (we have the caller pid and netlink_skb_parms
as a starting point). We only have read permissions to care about. It's
trivial to flag each field as "world readable", "owner only" (for fields
with process scope), and "root only". That covers pretty much what
/proc permissions achieve. While I am confident that this will work,
others may have better ideas for access control.

Roger

