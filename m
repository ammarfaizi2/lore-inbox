Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUHUJQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUHUJQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268946AbUHUJQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:16:00 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:41601 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S268933AbUHUJOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:14:44 -0400
Date: Sat, 21 Aug 2004 11:14:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Josan Kadett <corporate@superonline.com>
Cc: "'Aidas Kasparas'" <a.kasparas@gmc.lt>, linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
Message-ID: <20040821091441.GA691@ucw.cz>
References: <4126FDD8.1090101@gmc.lt> <S268889AbUHUIAZ/20040821080025Z+1903@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S268889AbUHUIAZ/20040821080025Z+1903@vger.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 11:00:27AM +0200, Josan Kadett wrote:
> The problem is that the interface 192.168.1.1 does not allow any tranmission
> to occur. An implementation error I think... We send packets to 192.168.1.1,
> we get no reply, but when we send packets to 192.168.77.1 we get the replies
> (that is where the abnormality begins). However; the replies are now sourced
> from 192.168.1.1 instead. That is, the blasted code in the device calculates
> the checksum using the wrong IP address which it thinks it is assigned to...

How about assigning an IP address that generates the same checksum to
the second interface? That'd solve your problem.

Or assign both interfaces the same IP address, maybe the device allows it.

> 
> -----Original Message-----
> From: Aidas Kasparas [mailto:a.kasparas@gmc.lt] 
> Sent: Saturday, August 21, 2004 9:47 AM
> To: Josan Kadett
> Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
> 
> But will these checksums be incorect if crazy box would communicate with 
> address in 192.168.1.x only?
> 
> The whole idea was based on the fact, that if that box works well in 
> 192.168.1.x networkd, then let it think it works in the network it knows 
> how to work!
> 
> Josan Kadett wrote:
> > It is definetely impossible to use IPTables to handle packets with
> incorrect
> > checksums since NAT would drop the connection right away, otherwise I
> would
> > not have been asking this question here.
> > 
> > -----Original Message-----
> > From: Aidas Kasparas [mailto:a.kasparas@gmc.lt] 
> > Sent: Saturday, August 21, 2004 8:54 AM
> > To: Josan Kadett
> > Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
> > 
> > How about setting up a separate box which would listen on that 
> > 192.168.77.1 address and MASQUERADE connections to your crazy box from 
> > 192.168.1.x address? Maybe then you would no longer need to break things 
> >   in kernel?
> > 
> > 
> > 
> 
> -- 
> Aidas Kasparas
> IT administrator
> GM Consult Group, UAB
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
