Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280107AbRKIUtL>; Fri, 9 Nov 2001 15:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280114AbRKIUtC>; Fri, 9 Nov 2001 15:49:02 -0500
Received: from natint.juniper.net ([207.17.136.129]:29789 "EHLO beta.jnpr.net")
	by vger.kernel.org with ESMTP id <S280107AbRKIUsm>;
	Fri, 9 Nov 2001 15:48:42 -0500
Message-ID: <3BEC4122.4C4DFB32@juniper.net>
Date: Fri, 09 Nov 2001 12:48:34 -0800
From: David Ranch <dranch@juniper.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan.Cox@linux.org, dranch@trinnet.net
Subject: 2.2.20 - Possible module symbol bug 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2001 20:48:36.0022 (UTC) FILETIME=[E6ED8560:01C1695F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello esteemed Linux gurus,


I think I've found a bug in 2.2.20.  Specifically, 
if I compile up a 2.2.20 kernel on a Mandrake 7.0 box
(glibc 2.1.3 - modutil 2.1.121) and run "depmod -a", all 
IPMASQ modules, loop, and ide-scsi modules fail dependencies.

--
#depmod -a
/lib/modules/2.2.20/scsi/ide-scsi.o: unresolved symbol(s)
/lib/modules/2.2.20/block/loop.o: unresolved symbol(s)
/lib/modules/2.2.20/ipv4/ip_masq_vdolive.o: unresolved symbol(s)
/lib/modules/2.2.20/ipv4/ip_masq_quake.o: unresolved symbol(s)
/lib/modules/2.2.20/ipv4/ip_masq_raudio.o: unresolved symbol(s)
/lib/modules/2.2.20/ipv4/ip_masq_irc.o: unresolved symbol(s)
/lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol(s)
/lib/modules/2.2.20/ipv4/ip_masq_user.o: unresolved symbol(s) 

#modprobe --debug ip_masq_ftp
/lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_new
/lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_put
/lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_listen
/lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_control_add
/lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_out_get 
--

If I do this make config on a a Mandrake 7.2 machine 
(Glibc 2.1.3 - modutils 2.3.21), only the loop module fails.

If I do this on a Mandrake 8.0 machine (Glibc 2.2.2 - modutils 2.4.3), 
everything is FINE.


So, playing around with the kernel config a little, I've found
that if I -do not- enable "CONFIG_MODVERSIONS", then everything
is ok on all machines.

Any thoughts on what is going on?  If possible, please CC: on the
the reply as I'm not on the linux-kernel list nor can my email
box handle the additional load.  ;-)  Thanks.

Ps.  If anyone would like a copy of the .config or the System.map
     files, please email me.

--David
