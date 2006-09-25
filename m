Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWIYMfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWIYMfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWIYMfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:35:31 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:21800 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751299AbWIYMfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:35:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAGpoF0WLcgEBDQ
X-IronPort-AV: i="4.09,213,1157320800"; 
   d="scan'208"; a="3471405:sNHT37326836"
Date: Mon, 25 Sep 2006 14:35:25 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@davemloft.net>, jbglaw@lug-owl.de, kaber@trash.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060925123525.GE23028@zlug.org>
References: <20060923120704.GA32284@zlug.org> <p738xk8kzym.fsf@verdi.suse.de> <20060925115744.GD23028@zlug.org> <200609251416.15738.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609251416.15738.ak@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:16:15PM +0200, Andi Kleen wrote:
> On Monday 25 September 2006 13:57, Joerg Roedel wrote:
> > On Mon, Sep 25, 2006 at 12:22:41PM +0200, Andi Kleen wrote:
> > 
> > > How would you convince those old LAN games to use a MTU < 1500 which
> > > is needed for the tunnel?  I bet they have the size hardcoded.
> > 
> > The tunnel provides an MTU of 1500. To guarantee this, it never sets the
> > DF flag in outgoing packets.
> 
> This means it will multiply all full sized packets. That sounds horrible.

Yes, all full sized packets gets fragmented at the IP layer according to
the MTU of the physical device. As I know, this is the only way to
guarantee the full Ethernet MTU on the tunnel device. This guarantee is
required for layer 3 protocols that does not know the concept of a path
MTU (as used by some old LAN based games ;-)
And for some cases this procedure is also defined in RFC 2473, section
7. for "Generic Packet Tunneling in IPv6".

Joerg
