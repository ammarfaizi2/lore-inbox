Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVD2K1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVD2K1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVD2K1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:27:15 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:53702 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262277AbVD2K1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:27:05 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>
Subject: Re: 2.6 upgrade overall failure report
Date: Fri, 29 Apr 2005 09:57:07 GMT
Message-ID: <0563AB712@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> >  . I reported a year ago that SCSI fusion was unable to properly recover from
> >    tiny errors under 2.6 as opposed to 2.4 ... and got hit by the same problem
> >    6 monthes later
> 
> Please send a full report to Eric Moore and cc linux-scsi@vger.kernel.org

Already done.
My initial report to Eric Moore is dated mai 15 2004 (2.6.6), so you can
understand why I'm a bit afraid beeing hit by the same bug more than 6 monthes
and 3 stable kernel releases later.
After the second report dated january 26 2005 (2.6.9),
he sent me fusion 3.1.19 saying it solves the problem.
As far as I could check, no official kernel is running 3.1.19
2.6.12 will jump to 3.1.20, so I can assume it's solved;
also I have no way to verify it since the bug will append only in case of
something going wrong on the SCSI chain, what tends to append only
once every several monthes, and not on all servers.

> >  . There is still a memory leak trouble (probably in tigon3 driver since others
> >    reported so on kernel mailing list, and tigon3 is not a geek hardware since
> >    most nowdays lowend servers use either tigon3 or pro1000)
> 
> Please send a report to David Miller and Jeff Garzik and cc netdev@oss.sgi.com

I must apology about this one because it's solved in 2.6.11
When I posted to kernel mailing list about it (january 28 2005) I could not
track the memory leak problem down to tigon3 driver. Only posts from others
led me to the conclusion, and after migrating from 2.6.10 to 2.4, I forgot to
retest with 2.6.11
My fault.

> >  . Since 2.6.10, the TCP task does not work anymore with OSX (2 Mbps instead
> >    of 60 Mbps on a 100 Mbps wire)
> 
> Please send a full report to David Miller and cc netdev@oss.sgi.com.
> 
> Also please describe a simple way of reproducing this - I'll see if it
> happens here.

They are very much awared about the problem (initial post dated january 5 2005)
and tracked it to the OSX surprising handling of delayed ack. So, as a
developper having to deal fairly often with interfacing closed systems I can
understand how their task is hard since they have to workaround instead of OSX
beeing fixed.

If you want to try to reproduce it, you need a gigabit connected PC (Intel
pro1000 in my case, but as far as I could understand it, it is not related
to pro1000 offload capabilities) pushing datas (TCP connection such as
libsmbclient) through a gigabit switch to a 100 Mbps connected Mac OSX 10.3
In short, you need a situation where flow control from Linux to OSX is needed.

