Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283387AbRK2U44>; Thu, 29 Nov 2001 15:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283338AbRK2U4p>; Thu, 29 Nov 2001 15:56:45 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:63481 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S283321AbRK2U4m>; Thu, 29 Nov 2001 15:56:42 -0500
Message-ID: <3C06A1C8.C133F725@nortelnetworks.com>
Date: Thu, 29 Nov 2001 15:59:52 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: ethernet links should remember routes the same as addresses
In-Reply-To: <3C068ED1.D5E2F536@nortelnetworks.com.suse.lists.linux.kernel> <p73r8qhqrmi.fsf@amdsim2.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> "Christopher Friesen" <cfriesen@nortelnetworks.com> writes:
> > Currently, if I run "ip link set dev ethX down", all routes associated with that
> > IP address in the additional routing tables are lost.  This is somewhat
> > understandable, as the addresses are not actually available anymore.  However,
> > the addresses are still visible associated with the link.  Then I run "ip link
> > set dev ethX up".  The route in the main routing table comes back, but none of
> > the other routes do.  Somehow, all of those additional routes must be re-added.
> 
> ip route list dev device > BACKUP
> 
> ...
> 
> while read i ; do ip route add $i ; done < BACKUP

Unfortunately, this seems to only list the routes in the main routing table, and
these routes are recreated automatically when I bring the link back up.

The problem is that I have routes in multiple other routing tables, and they
don't show up in this command.  I assume I'd have to run a similar command for
each routing table, which is kind of a pain.

If the driver re-init is totally separate from the routing code, is there any
real reason why shutting down the driver *should* remove all routes to that
device?  Maybe the simplest solution would be a new ioctl that would be a link
*reset*...just down/up the link without affecting anything else....


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
