Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161533AbWI2TOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161533AbWI2TOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161496AbWI2TOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:14:48 -0400
Received: from peacekeeper.artselect.com ([69.18.47.2]:25487 "EHLO
	wyeth.artselect.com") by vger.kernel.org with ESMTP
	id S1161533AbWI2TOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:14:47 -0400
Date: Fri, 29 Sep 2006 14:14:42 -0500
To: Tchesmeli Serge <serge@lea-linux.com>
Cc: Joerg Roedel <joro-lkml@zlug.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] ? Strange behaviour since kernel 2.6.17 with a https website
Message-ID: <20060929191442.GA18222@artselect.com>
References: <451CEBA8.8050604@lea-linux.com> <20060929100211.GB19115@zlug.org> <451CF08D.8030606@lea-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451CF08D.8030606@lea-linux.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Pete Harlan <harlan@artselect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 12:08:13PM +0200, Tchesmeli Serge wrote:
> Joerg Roedel wrote:
> > On Fri, Sep 29, 2006 at 11:47:20AM +0200, Tchesmeli Serge wrote:
> >
> >   
> >> Me and a friend have discover a stange behaviour since kernel 2.6.17.
> >>     
> >
> > Please try to switch off TCP window scaling using the command below
> > (as root) and retry.
> >
> > echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
> >
> >   
> Yes, it's work!

And for a less-intrusive workaround in 2.6.18, see this commit
comment:

commit 316c1592bea94ead75301cb764523661fbbcc1ca
Author: Stephen Hemminger <shemminger@osdl.org>
Date:   Tue Aug 22 00:06:11 2006 -0700

    [TCP]: Limit window scaling if window is clamped.
    
    This small change allows for easy per-route workarounds for broken hosts or
    middleboxes that are not compliant with TCP standards for window scaling.
    Rather than having to turn off window scaling globally. This patch allows
    reducing or disabling window scaling if window clamp is present.
    
    Example: Mark Lord reported a problem with 2.6.17 kernel being unable to
    access http://www.everymac.com
    
    # ip route add 216.145.246.23/32 via 10.8.0.1 window 65535
    
    Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

----------------------------------
Pete Harlan
ArtSelect, Inc.
harlan@artselect.com
http://www.artselect.com
ArtSelect is a subsidiary of a21, Inc.
