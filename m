Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbULODTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbULODTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 22:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULODTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 22:19:37 -0500
Received: from lakermmtao06.cox.net ([68.230.240.33]:58327 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261835AbULODT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 22:19:29 -0500
In-Reply-To: <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: bind() udp behavior 2.6.8.1
Date: Tue, 14 Dec 2004 22:19:28 -0500
To: Adam Denenberg <adam@dberg.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 14, 2004, at 21:23, Adam Denenberg wrote:
> i think you guys are all right.  However there is one concern.  Not 
> clearing out a UDP connection in a firewall coming from a high port is 
> indeed a security risk.  Allowing a high numbered udp port to remain 
> open for a prolonged period of time would definitely impose a security 
> risk which is why the PIX is doing what it does.  The linux server is 
> "reusing" the same UDP high numbered socket however it is doing so 
> exactly as the firewall is clearing its state table (60 ms) from the 
> first connection which is what is causing the issue.
>
> I think a firewall ought to be aware of such behavior, but at the same 
> time be secure enough to not just leave high numbered udp ports wide 
> open for attack.  I am trying to find out why the PIX chose 60 ms to 
> clear out the UDP state table.  I think that is a random number and 
> probably too short of a span for this to occur however i am still 
> researching it.
>
> Any other insight would be greatly appreciated.

60ms is certainly _way_ too small for most UDP traffic.  With something 
like
that, OpenAFS would die almost immediately.  I think the current OpenAFS
minimum is like 20 minutes, although somebody patched the OpenAFS
source to send a keepalive every 5 minutes, so it could be reduced.  
OTOH,
sending a keepalive every 60ms would take a _massive_ amount of
bandwidth even for one client, think about a couple hundred :-D.  Heck, 
I've
even seen pings on a regular basis that take longer than 60ms, which
means that even an infinitely fast kerberos server wouldn't respond 
quickly
enough :-D.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


