Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272324AbRHXU4r>; Fri, 24 Aug 2001 16:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272325AbRHXU4h>; Fri, 24 Aug 2001 16:56:37 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:35764 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272324AbRHXU4c>;
	Fri, 24 Aug 2001 16:56:32 -0400
Message-ID: <3B86C01E.850008A@candelatech.com>
Date: Fri, 24 Aug 2001 13:59:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Davis <tadavis@lbl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de> <3B867096.3A1D7DE@candelatech.com> <3B869A46.B1EF708A@lbl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis wrote:
> 
> Ben Greear wrote:
> >
> > Couldn't the bonding code be made to distribute pkts to one interface or
> > another based on a hash of the sending IP port or something?  Seems like that
> > would fix the reordering problem for IP packets....  It wouldn't help for
> > a single stream, but I'm guessing the real world problem involves many streams,
> > which on average should hash such that the load is balanced...
> >
> 
> Cisco etherchannel does this, by XOR'ing the dest address with the
> source address, AND'ing with # of interfaces (limiting you to a power of
> 2), and then using the number to determine what channel to use.
> 
> Now, you end up in a 4 way Etherchannel, all the traffic going down one
> channel, and the none going down the other three.  Does that sound like
> a balanced solution?

If Cisco can't do a balanced hash, that doesn't mean the idea is bad,
it just means they implemented it poorly.  I would think that
something as simple as: src_ip_port % num_devices would give a
fairly even spread.  I'm sure you could get fancier and take other
fields (dst_ip_port) into account in your hash.
 

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
