Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266419AbUFWMA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266419AbUFWMA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266433AbUFWMA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:00:27 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:6792 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S266419AbUFWMAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:00:25 -0400
Date: Wed, 23 Jun 2004 14:00:23 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2 udp multicast problem (sendto hangs)
Message-Id: <20040623140023.4cd7aa3e@phoebee>
In-Reply-To: <200406231334.57816.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040622164000.110f2a63@phoebee>
	<20040623115617.68b93100@phoebee>
	<200406231334.57816.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed-Claws 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 13:34:57 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> bubbled:

> On Wednesday 23 June 2004 12:56, Martin Zwickel wrote:
> > if I use MSG_DONTWAIT with sendto, I get temporarily unavailable resources
> > (many!):
> >
> > sendto(sendfd): Resource temporarily unavailable
> >
> > but isn't udp supposed to not block?
> 
> Think about what will happen if you will try to spew
> udp packets continuously:
> 
> while(1)
> 	sendto(...);
> 
> They will pile up in queue and eventually it will fill up.
> Then kernel may either drop excess packets silently
> or return you EAGAIN.

Yes, but why does the kernel not send out the queue?(I don't know if the queue
is empty or full when my sendto stops)
Without MSG_DONTWAIT, sendto waits endlessly. But on what?
Normally the kernel should put the queued packets on the line and accept new
ones, or did I misunderstand this?

My program sends out many udp packets, and sometimes it just stops until the
kernel receives a network packet or I access the local network(with arp
command).

So if I run arp in an endless loop(while :; do arp; done), sendto runs smooth.

For me it smells like a bug ;)

Martin

-- 
MyExcuse:
I'd love to help you -- it's just that the Boss won't let me near the computer.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
